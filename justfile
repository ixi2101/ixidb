set working-directory := 'ixidb'

# Clone vcpkg if it doesn't exist
bootstrap-vcpkg:
    if [ ! -d "../vcpkg" ]; then \
        cd .. && git clone https://github.com/microsoft/vcpkg.git && \
        ./vcpkg/bootstrap-vcpkg.sh; \
    fi

# Set default toolchain file path if not provided through environment
export CMAKE_TOOLCHAIN_FILE := env_var_or_default('CMAKE_TOOLCHAIN_FILE', '../vcpkg/scripts/buildsystems/vcpkg.cmake')

@build: bootstrap-vcpkg
	cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
	cmake --build build

@test: build
	cd build && ctest --output-on-failure
