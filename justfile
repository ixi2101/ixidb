set working-directory := 'ixidb'

# Set default toolchain file path if not provided through environment
export CMAKE_TOOLCHAIN_FILE := env_var_or_default('CMAKE_TOOLCHAIN_FILE', `realpath ../vcpkg/scripts/buildsystems/vcpkg.cmake`)

@build:
	cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}
	cmake --build build

@test: build
	cd build && ctest --output-on-failure
