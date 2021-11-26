    .file   "ex3.c"
    .align 8
    .section .rodata
    format_input1:  .string "%d"
    format_input2:  .string "%s"
    format_print:  .string "(%d)\n"
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
#   incq    -8(%rbp)    #add byte for the /0

#  subq    -8(%rbp), %rsp  # open more place on the stack acordingto the number entered

#   movq    $format_input2, %rdi    #format in first arg(
#   leaq    -8(%rbp), %rsi  #location to save in second arg
#   xorq     %rax,%rax  #rax=0
#   call    scanf

#   movq    -8(%rbp), %r11

#    movq    $format_input2, %rdi    #format in first arg
#    leaq    -8(%rbp), %rsi  #location to save in second arg
#    xorq     %rax,%rax  #rax=0
#    call    scanf

    movq    -8(%rbp), %rsi
    movq    $format_print, %rdi
    xorq    %rax, %rax
    call    printf

    movq    %rbp, %rsp
    popq    %rbp
    xorq    %rax, %rax
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
        #ja      .L57        #if > goto ERR
        #je      .L60        #if = go to L60
        #jmp     *.TABLE(,%eax,4)    #else goto table[op]
        movq    %rbp, %rsp
        popq    %rbp
        xorq    %rax, %rax
        ret


#setting up a table with to hold all the possible numbers
#there are more lables then choosing options but the 5 more lables is faster then using modulu 10
