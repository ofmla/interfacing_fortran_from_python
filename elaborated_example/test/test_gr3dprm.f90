!*******************************************************************************
!>
!  Unit tests for the [[gr3dmod]] module. The test compares the gravity anomaly
!  caused by a prism with parabolic variation in density contrast with that
!  generated by several prism with constant density contrast, whose combined
!  heights are equal to the height of the prism with parabolic decrease of density
!  contrast
      
    program gr3dprm_test

    use grav_kinds
    use grav3d_module, only : gr3dprm
    implicit none
    real(dp) :: del_stat, del_prm, alpha, sd, dxby2, dyby2
    real(dp) :: cx, cy, g, g1, y, y1, y2, x, x1, x2, z1, z2, dg
    real(dp) :: z, drho, dg1
    integer :: nrow, ncol, jj, ii, kk, i, j, k
    real(dp), allocatable :: a(:,:), a1(:,:), gz(:), gz1(:)

    open(21,file="xy-gzs.dat",form="formatted",status='unknown') ! output file

    del_stat=0.5d0     !! interval between stations (km). It is the same for both directions x and y
    nrow= 10           !! number of measuring stations in y direction
    ncol= 10           !! number of measuring stations in x direction
    del_prm =1.0d0     !! edge length of the square prisms 
    sd=-0.52d0         !! density contrast at surface (g/cm³)
    alpha=0.057d0      !! constant of the parabolic density function (g.cm⁻³/km)
    dxby2=del_prm/2.d0
    dyby2=del_prm/2.d0 

    allocate (a(nrow,ncol),a1(nrow,ncol),gz(ncol*nrow),gz1(nrow*ncol))
     
    a(:,:)=0.d0 ;a1(:,:)=0.d0
    do jj=1,nrow
      cx=del_stat/2.d0 + (del_stat)*dble(jj-1)
      do ii=1,ncol
        cy=del_stat/2.d0 + (del_stat)*dble(ii-1) 
        g=0.d0; g1=0.d0

        y=2.5d0-cy
        y1=dyby2+y
        y2=dyby2-y
        x=2.5d0-cx
        z=5.d0
        dg=gr3dprm(x,dxby2,y1,z,sd,alpha)
        dg=0.5d0*(dg+gr3dprm(x,dxby2,y2,z,sd,alpha))
        g=g+dg

        x1=(del_prm/2.d0)*4.d0
        x2=x1 + del_prm
        y1=(del_prm/2.d0)*4.d0
        y2=y1 + del_prm
        x1=x1-cx ; x2=x2-cx
        y1=y1-cy ; y2=y2-cy

        do kk=1,160
          z1=(0.03125d0*dble(kk) - 0.015625d0) - 0.015625d0
          z2=(0.03125d0*dble(kk) - 0.015625d0) + 0.015625d0
          drho= sd**3/(sd - alpha*(0.03125d0*dble(kk) - 0.015625d0))**2
          dg1 = atrac_prism(x1,x2,y1,y2,z1,z2,drho)
          g1=g1+dg1
        enddo

        a(jj,ii)=g
        a1(jj,ii)=g1
      enddo
    enddo 

    k=0; gz=0.d0; gz1=0.d0
    do i=1,nrow
      do j=1,ncol
        k=k+1 ; gz(k)=a(i,j); gz1(k)=a1(i,j)
        print*, gz(k), gz1(k), abs(gz(k)-gz1(k))
        if (abs(gz(k)-gz1(k)) > 1.0e-3 ) error stop 'TEST FAILED'
      enddo
    enddo

    do i = 1, 10
      k = 10*(i-1) + 1
      do j = 1, 10
        write(21, '(4(f12.8,1x))') 0.25d0+(j-1)*0.5d0, 0.25d0+(i-1)*0.5d0, gz(k), gz1(k) ! save file for gnuplot
        k = k +1
      enddo
      write(21,*) ' '
    enddo

    deallocate (a, a1, gz, gz1)  

    contains
!*****************************************************************************************

!*****************************************************************************************
!>
!  Calculates the vertical atraction, g_z, of rigth rectangular
!  prism of density d_r, defined by the coordinates of its six
!  vertex x1,x2,y1,y2,z1,z2 (Nagy et al., J Geodesy 2000, 74)
!  All input units must be referred to SI (km,g/cm³,m/s²). 
!  Output is in mgal (1 mgal=1e-5 m/s²)
!
!### Reference
!  * Nagy, D., G. Papp, and J. Benedek (2000), The gravitational potential and its
!    derivatives for the prism: Journal of Geodesy, 74, 552–560, doi: 10.1007/s001900000116.

    function  atrac_prism(x1,x2,y1,y2,z1,z2,d_r) result(g_z)

    implicit none
    integer :: i,j,k,sgn
    real(dp) :: x1, x2, y1, y2, z1, z2, d_r, v, r, gama
    real(dp) :: g_z
    real(dp), allocatable :: x(:), y(:), z(:)

    allocate (x(2),y(2),z(2))

    gama=6.67430d0  !! gama constant
    x(1)=x1
    x(2)=x2
    y(1)=y1
    y(2)=y2
    z(1)=z1
    z(2)=z2

    v=0.
    do i=1,2
      do j=1,2
        do k=1,2 

        sgn=(-1)**(i+j+k+1)
        !sgn=((-1)**i)*((-1)**j)*((-1)**k)
        r=sqrt(x(i)**2+y(j)**2+z(k)**2)
      
        if ((x(i)==0).and.(y(j)==0).and.(z(k)==0)) then
         g_z=0
        elseif ((x(i)==0).and.(y(j)==0)) then
         g_z=-z(k)*atan(x(i)*y(j)/(z(k)*r))*sgn
        elseif (((x(i)==0).and.(z(k)==0))) then
         g_z=y(j)*log(abs(y(j)))*sgn
        elseif ((y(j)==0).and.(z(k)==0)) then
         g_z=x(i)*log(abs(x(i)))*sgn
        elseif ((z(k)==0)) then
         g_z=(x(i)*log(y(j)+r)+y(j)*log(x(i)+r))*sgn
        else
        g_z=x(i)*log(y(j)+r)+y(j)*log(x(i)+r)-z(k)*atan(x(i)*y(j)/(z(k)*r))
        g_z=g_z*sgn
        endif
        v=v+g_z
        
        enddo
      enddo
    enddo

    !g_z=v*d_r*G*1D5
    g_z=v*d_r*gama

    deallocate (x,y,z)

    end function atrac_prism
!*****************************************************************************************

!*****************************************************************************************
    end program gr3dprm_test
!*****************************************************************************************