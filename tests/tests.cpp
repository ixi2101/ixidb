#include <catch2/catch_test_macros.hpp>
#include <libixidb/libixidb.hpp>

TEST_CASE("Test say_hello functionality") {
    // This will be captured by the coverage report
    ixidb::say_hello();
    SUCCEED("Function called successfully");
}
