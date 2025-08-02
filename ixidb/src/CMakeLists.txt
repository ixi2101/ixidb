add_library(libixidb libixidb.cpp)
add_library(ixidb::libixidb ALIAS libixidb)

set_target_properties(
	libixidb
	PROPERTIES OUTPUT_NAME ixidb
)

target_compile_features(libixidb PUBLIC cxx_std_23)

target_include_directories(
	libixidb PRIVATE include PUBLIC $<INSTALL_INTERFACE:include> $<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include> 
)

include(GNUInstallDirs)
install(TARGETS libixidb
	EXPORT ixidb-targets
	LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR}
	ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR}
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
	INCLUDES DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
	DIRECTORY ${PROJECT_SOURCE_DIR}/include/
	DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}
)

install(
	EXPORT ixidb-targets
	FILE ixidb-config.cmake
	NAMESPACE ixidb::
	DESTINATION ${CMAKE_INSTALL_LIBDIR}/cmake/ixidb
)
