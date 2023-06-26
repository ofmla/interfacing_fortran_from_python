program main
  use mod_sum
  implicit none
  real(wp) :: x(2,3) = reshape((/1,1,2,2,3,3/), (/2,3/))
  real(wp) :: y(3)

  call sum_columns(x, 2, 3, y)
  print*, y(:)
end program main