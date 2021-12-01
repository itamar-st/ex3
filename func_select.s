    .file   "ex3.c"
    .align 8
    .section .rodata
    .TABLE:
        .quad .L50 #Op = 0
        .quad .L51 #Op = 1
        .quad .L52 #Op = 2
        .quad .L53 #Op = 3
        .quad .L54 #Op = 4
        .quad .L55 #Op = 5
        .quad .L56 #Op = 6
        .quad .L57 #Op = 7
        .quad .L58 #Op = 8
        .quad .L59 #Op = 9
        .quad .L60 #Op = 10
        .quad .DEF #Op = 11
    format_input_int:  .string " %d"
    format_input_str:  .string " %s"
    format_input_char:  .string " %c"
    format_print:   .string "(%s,%s)"
    pstrlen_msg:    .string "first pstring length: %d, second pstring length: %d\n"
    replaceChar_msg:.string "old char: %c, new char: %c, first string: %s, second string: %s\n"


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

    #movq    $format_print, %rdi     #format in first arg
    #leaq    1(%rbp, %r12,1), %rsi    #important!! str location in firt arg
    #leaq    1(%rbp, %r13,1), %rdx    #important!! str location in firt arg
    #xorq    %rax, %rax      #rax = 0
    #call    printf

    leaq    (%rbp, %r12,1), %rdi    #pstring 1
    leaq    (%rbp, %r13,1), %rsi    #pstring2
    leaq    -8(%rbp), %rdx          #choice
    xorq    %rax, %rax  #finish
    call    run_func
    movq    %rbp, %rsp  #finish
    popq    %rbp        #finish
    xorq    %rax, %rax  #finish
    ret

    .type run_func, @function
run_func:
        pushq   %rbp    #setup
        movq    %rsp, %rbp  #setup
        subq    $24, %rsp #create space for 3 args

        movb    (%rdx), %al
        #movl    %edi, %eax  #eax = op
        sub     $50, %al   #noralize the inputs 1 to 10
        cmpl    $10, %eax    #cmp op,10
        jg      .L57        #if > goto ERR
        jmp     *.TABLE(,%eax,8)    #else goto table[op]
    .L_fin:
        movq    %rbp, %rsp
        popq    %rbp
        xorq    %rax, %rax
        ret

    .L50:
        pushq   %rbp    #setup
        movq    %rsp, %rbp  #setup
        subq    $16, %rsp   #create space for 1 arg

        call    pstrlen
        movq    %rax, -8(%rbp)
        movq    %rsi, %rdi
        call    pstrlen
        movq    %rax, -16(%rbp)
        movq    -8(%rbp), %rsi
        movq    -16(%rbp), %rdx
        #xorq    %rdx, %rdx  #rdx = 0
        #save the first byte (the len) into last byte of rdx
        #movb    (%rsi), %dl  #save the first byte (the len) into last byte of rdx
        #xorq    %rsi, %rsi  #rsi = 0
        #movb    (%rdi), %sil  #save the first byte (the len) into last byte of rsi
        movq    $pstrlen_msg, %rdi     #format in first arg
        #xorq    %rax, %rax      #rax = 0
        call    printf
        movq    %rbp, %rsp  #finish
        popq    %rbp        #finish
        xorq    %rax, %rax  #finish
        jmp     .L_fin
    .L51:
        ret
    .L52:
        pushq   %rbp    #setup
        movq    %rsp, %rbp  #setup
        subq    $32, %rsp   #create space for 1 arg
        movq    %r12, -8(%rbp)
        movq    %r13, -16(%rbp)
        movq    %rdi, %r12
        movq    %rsi, %r13

    #first len
        movq    $format_input_char, %rdi    #format in first arg
        leaq    -24(%rbp), %rsi  #location to save in second arg
        xorq    %rax,%rax  #rax=0
        call    scanf
    #second len
        movq    $format_input_char, %rdi    #format in first arg
        leaq    -32(%rbp), %rsi  #location to save in second arg
        xorq    %rax,%rax  #rax=0
        call    scanf

        movq    %r12, %rdi
        leaq    -24(%rbp), %rsi  #location to save in second arg
        leaq    -32(%rbp), %rdx  #location to save in second arg
        call    replaceChar
        movq    %rax, %r12

        movq    %r13, %rdi
        call    replaceChar

        movq    $replaceChar_msg, %rdi
        movq    -24(%rbp), %rsi  #location to save in second arg
        movq    -32(%rbp), %rdx
        leaq    1(%r12), %rcx
        leaq    1(%rax), %r8
        call    printf
        movq    -8(%rbp), %r12
        movq    -16(%rbp), %r13
        movq    %rbp, %rsp  #finish
        popq    %rbp        #finish
        xorq    %rax, %rax  #finish
        jmp     .L_fin
    .L53:
        ret
    .L54:
        ret
    .L55:
        ret
    .L56:
        ret
    .L57:
        ret
    .L58:
        ret
    .L59:
        ret
    .DEF:
        ret
    .L60:
        jmp .L50
    .ERR:
        ret
#setting up a table with to hold all the possible numbers
#there are more lables then choosing options but the 5 more lables is faster then using modulu 10




    .type pstrlen, @function
pstrlen:
        #performing swap between the args
        movb    (%rdi), %al
        ret


    .type replaceChar, @function
replaceChar:
    pushq   %rbp    #setup
    movq    %rsp, %rbp  #setup
    subq    $24, %rsp   #create space for 2 arg


    movb    $1, %bl
    incb    (%rdi)  #not good the change is permenant
    L10:
        movb    (%rdi, %rbx, 1), %al
        cmpb    %al, (%rsi)
        je      L11
    L12:
        incq    %rbx
        cmpb    %bl, (%rdi)
        jg     L10
        movq    %rdi, %rax
        movq    %rbp, %rsp  #finish
        popq    %rbp        #finish
        ret

    L11:
        movb    (%rdx), %al
        movb    %al, (%rdi, %rbx, 1)
        jmp     L12