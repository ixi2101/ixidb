set working-directory := 'ixidb'

@build:
	cmake -B build -S . -DCMAKE_TOOLCHAIN_FILE=../vcpkg/scripts/buildsystems/vcpkg.cmake
	cmake --build build

@test: build
	cd build && ctest --output-on-failure
