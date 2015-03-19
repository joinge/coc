
#include <cstdio>
#include <sys/ptrace.h>

int main(int argc, char *argv[]) {
   
   int pid = argv[0];
   
   sprintf(mem_file_name, "/proc/%d/mem", pid);
   mem_fd = open(mem_file_name, O_RDONLY);
   ptrace(PTRACE_ATTACH, pid, NULL, NULL);
   waitpid(pid, NULL, 0);
   lseek(mem_fd, offset, SEEK_SET);
   read(mem_fd, buf, _SC_PAGE_SIZE);
   ptrace(PTRACE_DETACH, pid, NULL, NULL);
 
   return 0;
}