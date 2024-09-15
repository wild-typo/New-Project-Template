// hello.s - ARM64 assembly "Hello, World!" for macOS

.section    __TEXT,__text,regular,pure_instructions
.global     _start                   // Entry point for the program
.align      2                        // Align to 4-byte boundary (2^2 = 4)

_start:
    // Write system call (syscall number 0x20, equivalent to syscall 4 on x86)
    mov     x0, #1                   // File descriptor 1 is stdout
    adrp    x1, helloworld@PAGE      // Load the page of the message
    add     x1, x1, helloworld@PAGEOFF // Add the offset within the page
    mov     x2, #13                  // Message length (13 bytes for "Hello World!\n")
    mov     x16, #0x4                // Syscall number for sys_write (write)
    svc     #0                       // Make system call

    // Exit system call (syscall number 0x1)
    mov     x0, #0                   // Exit code 0
    mov     x16, #0x1                // Syscall number for sys_exit (exit)
    svc     #0                       // Make system call

// Data section
.section    __TEXT,__cstring
helloworld:
    .asciz   "Hello World!\n"        // Null-terminated string

