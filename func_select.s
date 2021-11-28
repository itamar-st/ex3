    .file   "ex3.c"
    .align 8
    .section .rodata
    format_input1:  .string "%d"
    format_input2:  .string "%s"
    end_of_str:     .string "\0"
    format_print:  .string "(%s)"
    .text
    .globl run_main
    .type run_main, @function

run_main:
    pushq   %rbp    #setup
    movq    %rsp, %rbp  #setup
    subq    $16, %rsp   #create space for 1 arg

    movq    $format_input1, %rdi    #format in first arg
    leaq    -8(%rbp), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf

    movq    -8(%rbp), %rax  #save the length
    movq    %rax, %rbx      #save again for future use
    imulq   $-16, %rax #align for 16 addresses
    addq    %rax, %rsp  # open more place on the stack acordingto the number entered
    movq    %rax, %r12     #save the num of byts for future use
    movq    %rbx, (%rbp, %r12,1)    #save the input int

    movq    $format_input2, %rdi    #format in first arg
    leaq    1(%rbp, %r12,1), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf

    leaq    1(%rbp, %r12,1), %rsi    #important!! str location in firt arg
    movq    $format_print, %rdi     #format in second arg
    xorq    %rax, %rax      #rax = 0
    call    printf

    movq    %rbp, %rsp  #finish
    popq    %rbp        #finish
    xorq    %rax, %rax  #finish
    ret

    .globl run_func
    .type run_func, @function

run_func:
        pushq   %rbp    #setup
        movq    %rsp, %rbp  #setup
        subq    $24, %rsp #create space for 3 args


        movl    %edi, %eax  #eax = op
        sub     $50, %eax   #noralize the inputs 1 to 10
        cmpl    $10, %edi    #cmp op,10
        jmp
        #ja      .L57        #if > goto ERR
        #je      .L60        #if = go to L60
        #jmp     *.TABLE(,%eax,4)    #else goto table[op]
        movq    %rbp, %rsp
        popq    %rbp
        xorq    %rax, %rax
        ret



#setting up a table with to hold all the possible numbers
#there are more lables then choosing options but the 5 more lables is faster then using modulu 10

    .type get_len, @function
run_func: