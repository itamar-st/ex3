# 207497769 Itamar Shachen Tov

        .file "run_main.s"
        .section .rodata
    format_input_int:   .string " %d"
    format_input_str:   .string " %s"

    .text
    .globl run_main
    .type run_main, @function

run_main:
    pushq   %rbp    #setup
    movq    %rsp, %rbp  #setup
    subq    $16, %rsp   #create space for 1 arg
#first len
    movq    $format_input_int, %rdi    #format in first arg
    leaq    -8(%rbp), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf

    movq    -8(%rbp), %rax  #save the length
    movq    %rax, %rbx      #save again for future use
    imulq   $-16, %rax #align for 16 addresses
    addq    %rax, %rsp  # open more place on the stack acordingto the number entered
    movq    %rax, %r12     #save the num of byts for future use
    movq    %rbx, (%rbp, %r12,1)    #save the input int

#first str
    movq    $format_input_str, %rdi    #format in first arg
    leaq    1(%rbp, %r12,1), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf

#second len
    movq    $format_input_int, %rdi    #format in first arg
    leaq    -8(%rbp), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf

    movq    -8(%rbp), %rax  #save the length
    movq    %rax, %rbx      #save again for future use
    imulq   $-16, %rax #align for 16 addresses
    addq    %rax, %rsp  # open more place on the stack acordingto the number entered
    movq    %rax, %r13     #save the num of byts for future use
    addq    %r12, %r13
    movq    %rbx, (%rbp, %r13,1)    #save the input int
#second str
    movq    $format_input_str, %rdi    #format in first arg
    leaq    1(%rbp, %r13,1), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf
#choice
    movq    $format_input_int, %rdi    #format in first arg
    leaq    -8(%rbp), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf

    leaq    (%rbp, %r12,1), %rdi    #pstring 1
    leaq    (%rbp, %r13,1), %rsi    #pstring2
    leaq    -8(%rbp), %rdx          #choice
    xorq    %rax, %rax  #finish
    call    run_func
    movq    %rbp, %rsp  #finish
    popq    %rbp        #finish
    xorq    %rax, %rax  #finish
    ret
