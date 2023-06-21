program main

	use grav_kinds
	use grav3d_module
	implicit none
	real(dp), allocatable :: x(:), y(:), z(:)
	real(dp), allocatable :: xrec(:), yrec(:), f(:)
	real(dp)              :: sd, alpha, dx, dy
	integer               :: ierr,irow, in_unit, in1_unit, in2_unit, out_unit
	integer               :: nprisms, n_grd_pts
	character(:), allocatable :: arg1, arg2, arg3, arg4
	integer               :: arglen1, arglen2, arglen3, arglen4
	
	! First, make sure the right number of inputs have been provided
	if(command_argument_count() .ne. 4)then
		stop 'Error: four command-line arguments required, stopping'
	endif

	call get_command_argument(number=1, length=arglen1)  ! Assume for simplicity success
	allocate (character(arglen1) :: arg1)
	call get_command_argument(number=1, value=arg1)
	call get_command_argument(number=2, length=arglen2)  ! Assume for simplicity success
	allocate (character(arglen2) :: arg2)
	call get_command_argument(number=2, value=arg2)
	call get_command_argument(number=3, length=arglen3)  ! Assume for simplicity success
	allocate (character(arglen3) :: arg3)
	call get_command_argument(number=3, value=arg3)
	call get_command_argument(number=4, length=arglen4)  ! Assume for simplicity success
	allocate (character(arglen4) :: arg4)
	call get_command_argument(number=4, value=arg4)

	! Open the data file
	open (newunit=in_unit, file = arg1, action = "read", &
		  iostat=ierr, status = "old")
	if (ierr /= 0) stop 'Error: opening file failed'

	read (in_unit,*) nprisms   ! number of prisms
	read (in_unit,*) n_grd_pts ! number of grid points
	read (in_unit,*) sd        ! density contrast at ground surface (gm/cc)
	read (in_unit,*) alpha     ! constant of the parabolic density function (gm/cc/Km)
	read (in_unit,*) dx        ! size of the prisms rectangular faces in the x direction (Km)
	read (in_unit,*) dy        ! size of the prisms rectangular faces in the y direction (Km)

	! Open the data file
	open (newunit=in1_unit, file = arg2, action = "read", &
		  iostat=ierr, status = "old")
	if (ierr /= 0) stop 'Error: opening file failed'

	! Open the data file
	open (newunit=in2_unit, file = arg3, action = "read", &
    	  iostat=ierr, status = "old")
	if (ierr /= 0) stop 'Error: opening file failed'

	allocate (x(nprisms), y(nprisms), z(nprisms))
	allocate (xrec(n_grd_pts), yrec(n_grd_pts), f(n_grd_pts))

	! Loop over the prisms
	do irow=1,nprisms
		read (in1_unit,*) x(irow), y(irow), z(irow)
	end do

	! Loop over the grid points
	do irow=1,n_grd_pts
		read (in2_unit,*) xrec(irow), yrec(irow)
	end do

	! Now we should process the data somehow...
	call funcpdf(1, n_grd_pts, nprisms, n_grd_pts, sd, alpha, &
				dx, dy, z, x, y, xrec, yrec, f)

	open (newunit=out_unit, file = arg4, action = "write", status = "replace")

	do irow=1,n_grd_pts
		write (out_unit,*) xrec(irow), yrec(irow), f(irow)
	enddo

	deallocate(x,y,z)
	deallocate(xrec,yrec,f)
	deallocate(arg1,arg2,arg3,arg4)

	! Close the files
 	close(in_unit)
 	close(in1_unit)
 	close(in2_unit)
	close(out_unit)

end program main
