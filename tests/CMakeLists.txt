if(BUILD_TESTING)
    add_executable(ixidb_tests
        tests.cpp
    )

    target_link_libraries(ixidb_tests
        PRIVATE
            ixidb::libixidb
            Catch2::Catch2WithMain
    )

    include(Catch)
    catch_discover_tests(ixidb_tests)
endif()
