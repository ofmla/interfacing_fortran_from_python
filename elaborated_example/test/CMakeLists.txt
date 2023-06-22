add_executable(test_gr3dprm test_gr3dprm.f90)
target_link_libraries(test_gr3dprm pygravmod3d)
add_test(
    NAME test_gr3dprm
    COMMAND ${CMAKE_CURRENT_BINARY_DIR}/test_gr3dprm
)

