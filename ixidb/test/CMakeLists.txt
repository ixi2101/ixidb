add_executable(tests tests.cpp)
target_link_libraries(tests PRIVATE ixidb::libixidb Catch2::Catch2WithMain)

include(Catch)
catch_discover_tests(tests)
