add_executable(ixidb 
    main.cpp
)

target_link_libraries(ixidb
    PRIVATE
        ixidb::libixidb
)

install(TARGETS ixidb
    RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
