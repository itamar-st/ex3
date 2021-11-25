    .file   "ex3.c"
    .align 8
    .section .rodata
    .text
    .type run_func, @function

run_func:
        pushq   %rbp    #setup
        movq    %rsp, %rbp  #setup
        subq    $24, %rsp #create space for 3 args

        movl    %edi, %eax  #eax = op
        sube    $50, %eax   #noralize the inputs 1 to 10
        cmpl    $10, %edi    #cmp op,10
        ja      .ERR        #if > goto ERR
        je      .L60        #if = go to L60
        jmp     *.TABLE(,%eax,4)    #else goto table[op]

.ERR:
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