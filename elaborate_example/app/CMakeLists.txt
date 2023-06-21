set(f90-sources
    main.f90
)

add_executable(app ${f90-sources})
target_link_libraries(app pygravmod3d)

install(TARGETS app DESTINATION ${CMAKE_INSTALL_BINDIR})

if(WITH_OPENMP)
    add_executable(app-openmp ${f90-sources})
    target_link_libraries(app-openmp pygravmod3d_openmp)

    install(TARGETS app-openmp DESTINATION ${CMAKE_INSTALL_BINDIR})
endif()
