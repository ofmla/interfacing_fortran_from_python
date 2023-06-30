!************************************************************************************
!>
!  Computation of 3D gravity anomalies for arbitrary-shaped 3D bodies, which are
!  approximated by rectangular prisms (blocks). It is considered that a parabolic
!  density-contrast function can reasonably approximate the arbitrary 
!  depth-dependent density contrast of geologic bodies (i.e. sedimentary basins)                        

module grav3d_module
    use grav_kinds

    implicit none

    private

    ! parameters
    real(dp), parameter :: tog=13.3486_dp
    real(dp), parameter :: z1=1e-6
    integer, parameter :: lenstrn=5

    public funcpdf, c_funcpdf, gr3dprm

    contains
!************************************************************************************      
!>
!  Computes the theoretical gravity anomaly of 3d rectangular/square block
!
!### References
!  * Chakravarthi, V., H. M. Raghuram, and S. B. Singh, 2002, 3-D forward
!    gravity modeling of basement interfaces above which the density contrast
!    varies continuously with depth: Computers & Geosciences, 28, 53–57,
!    doi: 10.1016/S0098-3004(01)00080-2.

    real(dp) function gr3dprm (x,t,y,z,sd,alpha)

    implicit none
    real(dp) :: x, t, y, z, sd, alpha
    real(dp) :: g, dc, z2, al4, al5, al6, al8, q1, q2, r1, r2, r3, r4
    real(dp) :: t1, t2, t3, t4, t5, tt2, ttr1, ttr2
    real(dp) :: ter1, ter2, ter3, ter4, ter5
    real(dp) :: ter6, ter7, ter8, ter9, ter10, ter11
    real(dp) :: t41, t42, t51, t52, t61, t62
    real(dp) :: t71, t72, t81, t82, t91, t92, t101, t102
    real(dp) :: t111, t112, t122, t131, t132 
    real(dp) :: t141, t142, t143, t144, t145
	
    dc=tog*sd**3
    if(z .eq. 0._dp) then
      z2=11e-7
    else
      z2=z
    endif
    al5=sd-alpha*z1
    al6=sd-alpha*z2
    q1=x+t
    q2=x-t
    r1=SQRT(q1**2+y**2+z1**2)
    r2=SQRT(q2**2+y**2+z1**2)
    r3=SQRT(q2**2+y**2+z2**2)
    r4=SQRT(q1**2+y**2+z2**2)
    t1=1/alpha
    t2=(ATAN((y*q1)/(z2*r4)))/al6-(ATAN((y*q1)/(z1*r1)))/al5
    ttr1=t1*t2
    tt2=(ATAN((y*q2)/(z2*r3)))/al6-(ATAN((y*q2)/(z1*r2)))/al5
    ttr2=t1*tt2
    ter1=ttr1-ttr2
    t3=y*q1
    al8=SQRT((q1**2+y**2)*alpha**2+sd**2)
    t41=alpha*(2*sd**2+alpha**2*(q1**2+y**2))
    t42=al8*(y**2*alpha**2+sd**2)*(q1**2*alpha**2+sd**2)
    t4=t41/t42
    t51=al5*(alpha*r4*al8+al8**2-sd*al6)
    t52=al6*(alpha*r1*al8+al8**2-sd*al5)
    t5=LOG(t51/t52)
    ter2=t3*t4*t5
    t61=sd/(alpha*(sd**2+y**2*alpha**2))
    t62=ATAN((y*r4)/(z2*q1))-ATAN((y*r1)/(z1*q1))
    ter3=t61*t62
    t71=sd/(alpha*(sd**2+q1**2*alpha**2))
    t72=ATAN((q1*r4)/(z2*y))-ATAN((q1*r1)/(z1*y))
    ter4=t71*t72
    t81=y/(2*(sd**2+y**2*alpha**2))
    t82=LOG(((q1-r4)*(q1+r1))/((q1+r4)*(q1-r1)))
    ter5=t81*t82
    t91=q1/(2*(sd**2+q1**2*alpha**2))
    t92=LOG(((y-r4)*(y+r1))/((y+r4)*(y-r1)))
    ter6=t91*t92
    t101=sd/(alpha*(sd**2+y**2*alpha**2))
    t102=ATAN((y*r3)/(z2*q2))-ATAN((y*r2)/(z1*q2))
    ter7=t101*t102
    t111=sd/(alpha*(sd**2+q2**2*alpha**2))
    t112=ATAN((q2*r3)/(z2*y))-ATAN((q2*r2)/(z1*y))
    ter8=t111*t112
    t122=LOG(((q2-r3)*(q2+r2))/((q2+r3)*(q2-r2)))
    ter9=t81*t122
    t131=q2/(2*(sd**2+q2**2*alpha**2))
    t132=LOG(((y-r3)*(y+r2))/((y+r3)*(y-r2)))
    ter10=t131*t132
    al4=SQRT((q2**2+y**2)*alpha**2+sd**2)
    t141=y*q2
    t142=alpha*(2*sd**2+alpha**2*(q2**2+y**2))
    t143=al4*(y**2*alpha**2+sd**2)*(q2**2*alpha**2+sd**2)
    t144=al5*(alpha*r3*al4+al4**2-sd*al6)
    t145=al6*(alpha*r2*al4+al4**2-sd*al5)
    ter11=((t141*t142)/(t143))*LOG(t144/t145)
    g=ter1+ter2-ter3-ter4+ter5+ter6+ter7+ter8-ter9-ter10-ter11
    gr3dprm=dc*g
      
    end function gr3dprm

!************************************************************************************      
!>
!  Compute the field (f array) for all ('m') or some (ista:iend) points in the xy plane, 
!  as the sum of the contributions of 'n' rectangular prisms 
	
    subroutine c_funcpdf(ista, iend, n, m, sd, alpha, dx, dy, z, &
        xprm, yprm, xrec, yrec, f, cpl_opt) bind(C, name="c_funcpdf")

    use iso_c_binding
    implicit none
    integer(c_int) :: ista, iend, n, m
    real(c_double) :: sd, alpha, dx, dy
    real(c_double), dimension(n) :: xprm, yprm, z
    real(c_double), dimension(m) :: xrec, yrec, f
    type(c_ptr), value  :: cpl_opt
    character(len=:),allocatable :: pl_opt

    if (c_associated(cpl_opt)) then
      block
        !convert the C string to a Fortran string
        character(kind=c_char,len=lenstrn+1),pointer :: s
        call c_f_pointer(cptr=cpl_opt,fptr=s)
        pl_opt = s(1:lenstrn)
        nullify(s)
      end block
        call funcpdf(ista,iend,n,m,sd,alpha,dx,dy,z,xprm,yprm,xrec,yrec,f,pl_opt)
    else
      call funcpdf(ista,iend,n,m,sd,alpha,dx,dy,z,xprm,yprm,xrec,yrec,f)
    endif

    end subroutine c_funcpdf

    subroutine funcpdf(ista,iend,n,m,sd,alpha,dx,dy, &
        z,xprm,yprm,xrec,yrec,f,pl_opt)

    !$ use omp_lib
    implicit none
    integer  :: n, m
    real(dp), dimension (n) :: xprm, yprm, z
    real(dp), dimension (m) :: xrec, yrec, f
    real(dp) :: dx, dy, sd, alpha, soma
    real(dp) :: dxby2, dyby2, x, y, zi, y1, y2, dg
    !$ real(dp) :: t1, t2
    character(len=5) :: loop
    character(len=5), optional :: pl_opt
    integer :: i, j, ista, iend
	
    f(ista:iend)=0._dp
    dxby2=dx/2.0
    dyby2=dy/2.0 
    loop='outer'
    if (present(pl_opt)) loop=pl_opt
	
    if (loop .ne. 'outer')then
      !$ t1 = omp_get_wtime()  
      do i=ista,iend
        soma=0._dp
        !$OMP PARALLEL PRIVATE(j,y,y1,y2,x,zi,dg)
        !$OMP DO REDUCTION(+:soma) schedule (runtime)
        do j=1,n
          y=yprm(j)-yrec(i)
          y1=dyby2+y
          y2=dyby2-y
          x=xprm(j)-xrec(i)
          zi=z(j)
          dg=gr3dprm(x,dxby2,y1,zi,sd,alpha)
          dg=0.5*(dg+gr3dprm(x,dxby2,y2,zi,sd,alpha))
          soma=soma+dg
        enddo
        !$OMP END DO NOWAIT
        !$OMP END PARALLEL 
        f(i)=soma
      enddo
      !$ t2 = omp_get_wtime()
    else
      !$ t1 = omp_get_wtime()  
      !$OMP PARALLEL PRIVATE(i,j,y,y1,y2,x,zi,dg)
      !$OMP DO
      do i=ista,iend
        do j=1,n
          y=yprm(j)-yrec(i)
          y1=dyby2+y
          y2=dyby2-y
          x=xprm(j)-xrec(i)
          zi=z(j)
          dg=gr3dprm(x,dxby2,y1,zi,sd,alpha)
          dg=0.5*(dg+gr3dprm(x,dxby2,y2,zi,sd,alpha))
          f(i)=f(i)+dg
        enddo
      enddo
      !$OMP END DO NOWAIT
      !$OMP END PARALLEL
      !$ t2 = omp_get_wtime()
    endif

    !$ print*, "Forward modeling took", t2-t1, "seconds"

    end subroutine funcpdf
        
end module grav3d_module
!************************************************************************************
