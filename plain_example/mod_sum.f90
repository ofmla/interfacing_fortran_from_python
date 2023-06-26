module mod_sum
  use iso_fortran_env, only: real64
  implicit none
  private
  integer, parameter, public :: wp = real64
  public sum_columns
  contains
    subroutine sum_columns(a, n_r_a, n_c_a, sum_col)
      real(wp), intent(in) :: a(n_r_a, n_c_a)
      integer, intent(in) :: n_c_a, n_r_a
      real(wp) :: sum_col(n_c_a)
      sum_col(:) = sum(a,1)
    end subroutine sum_columns
end module mod_sum