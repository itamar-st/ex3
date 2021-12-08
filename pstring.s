# 207497769 Itamar Shachen Tov

    .file "pstring.s"
    .text

    .global pstrijcmp
    .type pstrijcmp, @function
pstrijcmp:
    movb    %dl, %bl # i=0

.L81:
    cmpb    %cl, %bl  #if i< pstr.len
    jle     .L82
    movq    $0, %rax
    ret
.L82:
    movb    1(%rdi, %rbx, 1), %al  # dest[i] = al
    movb    1(%rsi, %rbx, 1), %r8b  # dest[i] = al
    cmpb    %r8b, %al # al <= 65
    jg     .L83
    jl     .L86
    jmp     .L84
.L83:
    movq    $1, %rax
    ret
.L86:
    movq    $-1, %rax
    ret
.L84:
    incq    %rbx    #i++
    jmp     .L81


    .global swapCase
    .type swapCase, @function
swapCase:
    xorq    %rax, %rax
    movb    $0, %bl # i=0
    movb    (%rdi), %cl

.L91:
    cmpb    %cl, %bl  #if i< pstr.len#
    jle     .L92
    movq    %rdi, %rax  #set for return
    ret
.L92:
    movb    1(%rdi, %rbx, 1), %al  # dest[i] = al
    cmpb    $65, %al # al <= 65
    jl     .L93
    cmpb    $90, %al # al>=90
    jge     .L93
    addb    $32, %al
    movb    %al, 1(%rdi, %rbx, 1) # al = dest[i]
    jmp     .L94
.L93:
    cmpb    $97, %al # al <97
    jl     .L94
    cmpb    $122, %al # al>122
    jg     .L94
    subb    $32, %al
    movb    %al, 1(%rdi, %rbx, 1) # al = dest[i]
.L94:
    incq    %rbx    #i++
    jmp     .L91


    .global pstrijcpy
    .type pstrijcpy, @function
pstrijcpy:

    movb    %dl, %bl # i=0

.L16:
    cmpq    %rcx, %rbx  #if i< pstr.len#
    jle     .L15
    movq    %rdi, %rax  #set for return
    ret
.L15:
    movb    1(%rsi, %rbx, 1), %al    #al = src[i]
    movb    %al, 1(%rdi, %rbx, 1) # dest[i] = al
    incq    %rbx    #i++
    jmp     .L16


    .global pstrlen
    .type pstrlen, @function
pstrlen:
    #performing swap between the args
    movb    (%rdi), %al
    ret


    .global replaceChar
    .type replaceChar, @function
replaceChar:
    pushq   %rbp    #setup
    movq    %rsp, %rbp  #setup
    subq    $24, %rsp   #create space for 2 arg


    movb    $1, %bl # i=0
    incb    (%rdi)  # not good the change is permenant
L10:
    movb    (%rdi, %rbx, 1), %al    #al = str[i]
    cmpb    %al, (%rsi) #cmp str[i] old char
    je      L11
L12:
    incq    %rbx    #i++
    cmpb    %bl, (%rdi) #if i< pstr.len
    jg     L10
    movq    %rdi, %rax  #set for return
    movq    %rbp, %rsp  #finish
    popq    %rbp        #finish
    ret

L11:
    movb    (%rdx), %al # change chars
    movb    %al, (%rdi, %rbx, 1)
    jmp     L12
