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
@configure: bootstrap-vcpkg
    cmake -B build -S . \
        -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE} \
        -DCMAKE_BUILD_TYPE=Release \
        -DBUILD_TESTING=ON \
        -DCMAKE_CXX_COMPILER=/usr/bin/g++-14 \
        -G "Ninja"

# Build the project
@build: configure
    cmake --build build --config Release

# Run tests
@test: build
    ctest --test-dir build --output-on-failure

# Install the project
@install: build
    cmake --install build

# Clean build artifacts
@clean:
    rm -rf build/
