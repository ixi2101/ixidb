#include <cstdio>
#include <libixidb/libixidb.hpp>
#include <iostream>
#include <sched.h>
#include <sys/ptrace.h>
#include <unistd.h>

namespace {
	pid_t attach(int argc, const char** argv){
		pid_t pid = 0;
		if (argc == 3 && argv[1] == std::string_view("-p")){
			pid = std::stoi(argv[2]);
			if (pid <= 0){
				std::cerr << "invalid pid" << std::endl;
				return -1;
			}
			if (ptrace(PTRACE_ATTACH, pid, nullptr, nullptr) < 0){
				std::perror("Could not attach to process");
			}
		} else {

		}
		return pid;
	}
}

int main(int argc, const char** argv){
	if (argc == 1){
		std::cerr << "missing args" << std::endl;
		return -1;
	}
	pid_t pid = attach(argc, argv);
}
