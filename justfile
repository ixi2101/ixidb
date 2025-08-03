# Setup vcpkg
bootstrap-vcpkg:
    if [ ! -d "vcpkg" ]; then \
        git clone https://github.com/microsoft/vcpkg.git && \
        cd vcpkg && \
        git fetch origin && \
        ./bootstrap-vcpkg.sh; \
    else \
        cd vcpkg && \
        git fetch origin; \
    fi

# Set default toolchain file path if not provided through environment
export CMAKE_TOOLCHAIN_FILE := env_var_or_default('CMAKE_TOOLCHAIN_FILE', 'vcpkg/scripts/buildsystems/vcpkg.cmake')

# Configure the project
@configure *args='': bootstrap-vcpkg
    cmake -B build -S . \
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
        -DCMAKE_BUILD_TYPE=Debug \
        -DBUILD_TESTING=ON \
        {{args}}

# Build the project
@build: configure
    cmake --build build

# Run tests
@test: build
    ctest --test-dir build --output-on-failure

# Generate coverage report
@coverage:
    just configure "-DCODE_COVERAGE=ON"
    just test
    # Capture coverage data
    lcov --gcov-tool /usr/bin/gcov-14 \
        --directory build \
        --base-directory . \
        --capture \
        --initial \
        --output-file coverage.base.info
    lcov --gcov-tool /usr/bin/gcov-14 \
        --directory build \
        --base-directory . \
        --capture \
        --output-file coverage.test.info
    # Combine base and test coverage
    lcov --gcov-tool /usr/bin/gcov-14 \
        --add-tracefile coverage.base.info \
        --add-tracefile coverage.test.info \
        --output-file coverage.total.info
    # Filter out system files and test files
    lcov --gcov-tool /usr/bin/gcov-14 \
        --remove coverage.total.info \
        '*vcpkg*' '*tests*' '/usr/*' \
        --output-file coverage.filtered.info
    # Show coverage report
    lcov --gcov-tool /usr/bin/gcov-14 --list coverage.filtered.info
    # Generate HTML report
    genhtml --ignore-errors source coverage.filtered.info --output-directory coverage_report

# Install the project
@install: build
    cmake --install build

# Clean build artifacts
@clean:
    rm -rf build/ coverage*.info coverage_report/
