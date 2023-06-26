module mod_sum
    use iso_fortran_env, only: real64
    use iso_c_binding, only: c_double, c_int
    implicit none
    private
    integer, parameter, public :: wp = real64
    public sum_columns, csum_columns
    contains
      subroutine sum_columns(a, n_r_a, n_c_a, sum_col)
        real(wp), intent(in) :: a(n_r_a, n_c_a)
        integer, intent(in) :: n_c_a, n_r_a
        real(wp) :: sum_col(n_c_a)
        sum_col(:) = sum(a,1)
      end subroutine sum_columns

      subroutine csum_columns(a, n_r_a, n_c_a, sum_col) bind(c, name="csum_columns")
        real(c_double), intent(in) :: a(n_c_a, n_r_a)
        integer(c_int), value, intent(in) :: n_c_a, n_r_a
        real(c_double) :: sum_col(n_c_a)
        sum_col(:) = sum(a,2)  
      end subroutine csum_columns
    end module mod_sum