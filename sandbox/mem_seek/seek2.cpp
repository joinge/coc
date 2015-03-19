
#include <sys/ptrace.h> //For ptrace()
#include <sys/wait.h>   //For waitpid()

int main (int argc, char *argv[]) {
   
    int pid = atoi(argv[0]);  //The process id you wish to attach to
    int address = 0x13371337; //The address you wish to read in the process

    //First, attach to the process
    //All ptrace() operations that fail return -1, the exceptions are
    //PTRACE_PEEK* operations
    if (ptrace(PTRACE_ATTACH, pid, NULL, NULL) == -1) {
        //Read the value of errno for details.
        //To get a human readable, call strerror()
        //strerror(errno) <-- Returns a human readable version of the
        //error that occurred
        return 0;
    }

    //Now, attaching doesn't mean we can read the value straight away
    //We have to wait for the process to stop
    int status;
    //waitpid() returns -1 on failure
    //W.I.F, not W.T.F
    //WIFSTOPPED() returns true if the process was stopped when we attached to it
    if (waitpid(pid, &status, 0) == -1 || !WIFSTOPPED(status)) {
        //Failed, read the value of errno or strerror(errno)
        return 0;
    }

    errno = 0; //Set errno to zero
    //We are about to perform a PTRACE_PEEK* operation, it is possible that the value
    //we read at the address is -1, if so, ptrace() will return -1 EVEN THOUGH it succeeded!
    //This is why we need to 'clear' the value of errno.
    int value = ptrace(PTRACE_PEEKDATA, pid, (void*)addr, NULL);
    if (value == -1 && errno != 0) {
        //Failed, read the value of errno or strerror(errno)
        return 0;
    } else {
        //Success! Read the value
    }

    //Now, we have to detach from the process
    ptrace(PTRACE_DETACH, pid, NULL, NULL);
    return 0;
    
    
    
//    char mem_file_name[50000000];
//    void *buf;
//    int mem_fd = 0, offset = 0;
//    
//    int pid = atoi(argv[0]);
//    
//    sprintf(mem_file_name, "/proc/%d/mem", pid);
//    mem_fd = open(mem_file_name, O_RDONLY);
//    ptrace(PTRACE_ATTACH, pid, NULL, NULL);
//    waitpid(pid, NULL, 0);
//    lseek(mem_fd, offset, SEEK_SET);
//    read(mem_fd, buf, _SC_PAGE_SIZE);
//    ptrace(PTRACE_DETACH, pid, NULL, NULL);
   
   
}