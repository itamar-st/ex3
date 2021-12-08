# 207497769 Itamar Shachen Tov

    .file   "func_select.s"
    .section .rodata

    .align 8
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

format_input_int:   .string " %d"
format_input_str:   .string " %s"
format_input_char:  .string " %c"
format_input_2char: .string " %c %c"
pstrlen_msg:        .string "first pstring length: %d, second pstring length: %d\n"
replaceChar_msg:    .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
pstrijcpy_msg:      .string "length: %d, string: %s\n"
invalid_input:      .string "invalid input!\n"
invalid_option:      .string "invalid option!\n"
pstrijcmp_msg:      .string "compare result: %d\n"

    .text
    .global run_func
    .type run_func, @function
run_func:
    pushq   %rbp    #setup
    movq    %rsp, %rbp  #setup
    subq    $24, %rsp #create space for 3 args

#setting up a table with to hold all the possible numbers
#there are more lables then choosing options but the 5 more lables is faster then using modulu 10
    movb    (%rdx), %al
    #movl    %edi, %eax  #eax = op
    sub     $50, %al   #noralize the inputs 1 to 10
    cmpl    $10, %eax    #cmp op,10
    jg      .ERR        #if > goto ERR
    cmpl    $0, %eax    #cmp op,10
    jl      .ERR        #if > goto ERR
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
    movq    %rax, -8(%rbp) #save first len
    movq    %rsi, %rdi
    call    pstrlen

    movq    %rax, -16(%rbp) #save second len
    movq    -8(%rbp), %rsi  #args pointing to mem
    movq    -16(%rbp), %rdx
    movq    $pstrlen_msg, %rdi     #format in first arg
    call    printf

    movq    %rbp, %rsp  #finish
    popq    %rbp        #finish
    xorq    %rax, %rax  #finish
    jmp     .L_fin
.L51:
    jmp     .ERR
.L52:
    pushq   %rbp    #setup
    movq    %rsp, %rbp  #setup
    subq    $32, %rsp   #create space for 1 arg
    movq    %r12, -8(%rbp)
    movq    %r13, -16(%rbp)
    movq    %rdi, %r12
    movq    %rsi, %r13

#first char
    movq    $format_input_2char, %rdi    #format in first arg
    leaq    -24(%rbp), %rsi  #location to save in second arg
    leaq    -32(%rbp), %rdx  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf

    movq    %r12, %rdi  #str in first arg
    leaq    -24(%rbp), %rsi  #location to save in second arg
    leaq    -32(%rbp), %rdx  #location to save in third arg
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

    movq    -8(%rbp), %r12  #pop
    movq    -16(%rbp), %r13 #pop
    movq    %rbp, %rsp  #finish
    popq    %rbp        #finish
    xorq    %rax, %rax  #finish
    jmp     .L_fin

.L53:
    pushq   %rbp    #setup
    movq    %rsp, %rbp  #setup
    subq    $32, %rsp   #create space for 1 arg
    movq    %r12, -8(%rbp)
    movq    %r13, -16(%rbp)
    movq    %rdi, %r12
    movq    %rsi, %r13

    movq    $format_input_int, %rdi    #format in first arg
    leaq    -24(%rbp), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf

    movq    $format_input_int, %rdi    #format in first arg
    leaq    -16(%rbp), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf
    #incb    -16(%rbp)

    xorq    %rax,%rax  #rax=0
    movb    -24(%rbp), %al
    cmpb    %al, (%r12)     #check if the index is out of range
    jl     .L21
    cmpb    %al, (%r13)
    jl     .L21
    xorq    %rax,%rax  #rax=0
    movb    -16(%rbp), %al
    cmpb    %al, (%r12)
    jle     .L21
    cmpb    %al, (%r13)
    jle     .L21

    xorq    %rdx, %rdx
    movb    -24(%rbp), %dl
    xorq    %rcx, %rcx
    movb    -16(%rbp), %cl
    movq    %r12, %rdi
    movq    %r13, %rsi
    call    pstrijcpy

    .L23:
        movq    $pstrijcpy_msg, %rdi
        xorq    %rsi, %rsi  #rsi = 0
        xorq    %rbx, %rbx  #rdi = 0
        movb    (%rax), %bl #location to save in second arg
        movq    %rbx, -32(%rbp) #location to save in second arg
        movq    -32(%rbp), %rsi#create free space for the arg
        leaq    1(%rax), %rdx   #len in first arg
        xorq    %rax, %rax  #str in second arg
        call    printf

        movq    $pstrijcpy_msg, %rdi
        xorq    %rsi, %rsi
        xorq    %rbx, %rbx
        movb    (%r13), %bl     #location to save in second arg
        movq    %rbx, -32(%rbp) #create free space for the arg
        movq    -32(%rbp), %rsi #len in first arg
        leaq    1(%r13), %rdx   #str in second arg
        xorq    %rax, %rax
        call    printf

        movq    %rbp, %rsp  #finish
        popq    %rbp        #finish
        xorq    %rax, %rax  #finish
        jmp     .L_fin

    .L21:
         movq   $invalid_input, %rdi
         xorq    %rax,%rax  #rax=0
         call    printf
         movq   %r12, %rax
         jmp    .L23

.L54:
    pushq   %rbp    #setup
    movq    %rsp, %rbp  #setup
    subq    $32, %rsp   #create space for 3 arg
    movq    %r12, -8(%rbp)  #save callee
    movq    %r13, -16(%rbp)
    movq    %rdi, %r12
    movq    %rsi, %r13

    movq    %r12, %rdi  #str in first arg
    leaq    -24(%rbp), %rsi  #location to save
    leaq    -32(%rbp), %rdx  #location to save
    call    swapCase
    movq    %rax, %r12  #save output

    movq    %r13, %rdi  #str in first arg
    call    swapCase
    movq    %rax, %r13  #save output

    movq    $pstrijcpy_msg, %rdi    #format in first arg
    xorq    %rsi, %rsi  #rsi = 0
    xorq    %rbx, %rbx  #rbx = 0
    movb    (%r12), %bl   #location to save in second arg
    movq    %rbx, -32(%rbp) #create free space for the arg
    movq    -32(%rbp), %rsi #lenin first arg
    leaq    1(%r12), %rdx   #str in second arg
    xorq    %rax, %rax
    call    printf

    movq    $pstrijcpy_msg, %rdi    #format in first arg
    xorq    %rsi, %rsi   #rsi = 0
    xorq    %rbx, %rbx  #rbx = 0
    movb    (%r13), %bl   #location to save in second arg
    movq    %rbx, -32(%rbp) #create free space for the arg
    movq    -32(%rbp), %rsi #len in first arg
    leaq    1(%r13), %rdx    #str in second arg
    xorq    %rax, %rax
    call    printf

    movq    -8(%rbp), %r12  #pop
    movq    -16(%rbp), %r13 #pop
    movq    %rbp, %rsp  #finish
    popq    %rbp        #finish
    xorq    %rax, %rax  #finish
    jmp     .L_fin

.L55:
    pushq   %rbp    #setup
    movq    %rsp, %rbp  #setup
    subq    $48, %rsp   #create space for 1 arg
    movq    %r12, -8(%rbp)
    movq    %r13, -16(%rbp)
    movq    %rdi, %r12
    movq    %rsi, %r13

    movq    $format_input_int, %rdi    #format in first arg
    leaq    -24(%rbp), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf

    movq    $format_input_int, %rdi    #format in first arg
    leaq    -16(%rbp), %rsi  #location to save in second arg
    xorq    %rax,%rax  #rax=0
    call    scanf

    xorq    %rax,%rax  #rax=0
    movb    -24(%rbp), %al  #check if out of range
    cmpb    %al, (%r12)
    jl     .LF2
    cmpb    %al, (%r13)
    jl     .LF2
    xorq    %rax,%rax  #rax=0
    movb    -16(%rbp), %al
    cmpb    %al, (%r12)
    jl     .LF2
    cmpb    %al, (%r13)
    jl     .LF2

    xorq    %rdx, %rdx
    movb    -24(%rbp), %dl
    xorq    %rcx, %rcx
    movb    -16(%rbp), %cl
    movq    %r12, %rdi
    movq    %r13, %rsi
    call    pstrijcmp

    .LF1:
        movq    $pstrijcmp_msg, %rdi
        movq    %rax, -32(%rbp)
        movq    -32(%rbp), %rsi
        xorq    %rax, %rax
        call    printf

        movq    %rbp, %rsp  #finish
        popq    %rbp        #finish
        xorq    %rax, %rax  #finish
        jmp     .L_fin

    .LF2:
         movq   $invalid_input, %rdi
         xorq    %rax,%rax  #rax=0
         call    printf
         movq   %r12, %rax
         movq   $-2, %rax
         jmp    .LF1
# all other options send to err section
.L56:
    jmp     .ERR
.L57:
    jmp     .ERR
.L58:
    jmp     .ERR
.L59:
    jmp     .ERR
.L60:
    jmp     .L50
.DEF:
    jmp     .ERR
.ERR:
    movq   $invalid_option, %rdi
    xorq    %rax,%rax  #rax=0
    call    printf
    xorq    %rax, %rax  #finish
    jmp     .L_fin

