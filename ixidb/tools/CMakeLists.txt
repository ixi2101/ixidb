add_executable(ixidb ixidb.cpp)
target_link_libraries(ixidb PRIVATE ixidb::libixidb)

include(GNUInstallDirs)
install(
	TARGETS ixidb
	RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
)
