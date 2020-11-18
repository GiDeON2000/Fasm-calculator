format PE64 console 4.0
entry start

include 'C:\Users\vl\Downloads\INCLUDE\win64a.inc'

section '.text' code executable
start:
        cinvoke printf,s,message
        cinvoke printf,s,lines
        invoke getch
        jmp code

code:
        cinvoke printf,s,main_message
        cinvoke scanf,d,num1

        push $
        cinvoke scanf,c,oper
        cmp [oper],'='
        je @F
        cinvoke scanf,d,num2

        cmp [oper],'+'
        je @@0
        cmp [oper],'-'
        je @@1
        cmp [oper],'*'
        je @@2
        cmp [oper],'/'
        je @@3
        cmp [oper],'e'
        je @@4
        ret

@@0:
        mov rax,qword[num1]
        add rax,qword[num2]
        mov qword[num1],rax
        ret
@@1:
        mov rax,qword[num1]
        sub rax,qword[num2]
        mov qword[num1],rax
        ret
@@2:
        mov rax,qword[num1]
        xor rdx,rdx
        imul qword[num2]
        mov qword[num1],rax
        ret
@@3:
        mov rax,qword[num1]
        xor rdx,rdx
        idiv qword[num2]
        mov qword[num1],rax
        ret

@@4:
        invoke getch
        invoke ExitProcess,0

@@:
        cinvoke printf,s,res_message
        cinvoke printf,d,[num1]
        invoke getch
        jmp code


section '.data' data readable writable
        c db '%c',0
        s db '%s',0
        d db '%d',0
        lf db '%lf',0

        message db "Welocme to calculator V1.2(press any key...)",0
        lines db 10,"----------------------",0
        res_message db 10,"Result is: ",0
        main_message db 10,"Enter your operation and finish it with '=': "

        num1 dd 0
        num2 dd 0
        oper db 0
        res dq 0

section '.idata' data readable import
        library kernel32, 'kernel32.dll', \
                msvcrt,   'msvcrt.dll'
        import kernel32, ExitProcess, 'ExitProcess'

        import msvcrt, printf, 'printf', \
                       scanf, 'scanf', \
                       getch, '_getch'