!*******************************************************************************
!>
!  Numeric kinds for modeling of gravity anomalies.

module grav_kinds

    use iso_fortran_env, only: real32, real64  ! precision kinds
    
    private
    
    integer,parameter,public :: dp = real64  
    integer,parameter,public :: sp = real32  
    
end module grav_kinds
!*******************************************************************************