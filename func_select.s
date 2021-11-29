    .file   "ex3.c"
    .align 8
    .section .rodata
    format_input_int:  .string "%d"
    format_input_str:  .string "%s"
    format_input_char:  .string "%c"
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
    call    pstrlen
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
        #ja      .L57        #if > goto ERR
        #je      .L60        #if = go to L60
        #jmp     *.TABLE(,%eax,4)    #else goto table[op]
        movq    %rbp, %rsp
        popq    %rbp
        xorq    %rax, %rax
        ret



#setting up a table with to hold all the possible numbers
#there are more lables then choosing options but the 5 more lables is faster then using modulu 10
.TABLE:
    .long .L50 #Op = 0
    .long .L51 #Op = 1
    .long .L52 #Op = 2
    .long .L53 #Op = 3
    .long .L54 #Op = 4
    .long .L55 #Op = 5
    .long .L56 #Op = 6
    .long .L57 #Op = 7
    .long .L58 #Op = 8
    .long .L59 #Op = 9
    .long .L60 #Op = 10
    .long .DEF #Op = 11

.l50:
    ret
.l51:
    ret
.l52:
    ret
.l53:
    ret
.l54:
    ret
.l55:
    ret
.l60:
    ret

    .type pstrlen, @function
pstrlen:
        #performing swap between the args
        movb    (%rdi), %al
        ret
        #xorq    %rdx, %rdx  #rdx = 0
        #save the first byte (the len) into last byte of rdx
        #movb    (%rsi), %dl  #save the first byte (the len) into last byte of rdx
        #xorq    %rsi, %rsi  #rsi = 0
        #movb    (%rdi), %sil  #save the first byte (the len) into last byte of rsi
        #movq    $pstrlen_msg, %rdi     #format in first arg
        #xorq    %rax, %rax      #rax = 0
        #call    printf

    .type replaceChar, @function
replaceChar:
    pushq   %rbp    #setup
    movq    %rsp, %rbp  #setup
    subq    $24, %rsp   #create space for 2 arg


L10:
    movb    $1, %bl
    movb    (%rdi, %rbx, 1), %al
    cmpb    %al, (%rsi)
    je      L11
    incq    %rbx
    cmpb    %bl, (%rdi)
    jmp     L10

L11:
    movb    %dl, %al