# Win386 support info in MS-DOS 7.1 data segments

I spent some time in reversing the DOSDATA segment of MS-DOS 7.1 (Winver=4.10.2222). Below is a part of it, all regarding data structures for running Windows in 386 mode.

I still have questions, see those question marks below.

Can anyone here answer those qeustions?

```
; ===
; Win386_Info
; This is from memory dump and inferred based on Jeff Parsons SPY:DOS.INC, and MD6S:dostab.asm.
; MD6S(MS-DOS 6 source code leaks)
; ===
; @dosdata:EE1
Win386_Info	struct
	dw 4                                      ; 04 00 
	dd 0, 0, 0                                ; 00 00 00 00 
                                              ; 00 00 00 00
                                              ; 00 00 00 00
	dw offset dosdata:Instance_Table, 0       ; F7 0E C9 00
	dw offset dosdata:Opt_Instance_Table, 0   ; 3D 0F C9 00
Win386_Info ends

; ===
; Instance_Table
; UDF1 and UDF2 are two undocumented flags, located just before NLS_DATA
; Tail Zeros seem too long. May be other fields.
; NLS_DATA: the data returned by Int 21H, AX=7000H, RBIL61
; What are the meaning of UDF1 and UDF2?
; ===
; @dosdata:EF7
Instance_Table struct
	dw offset dosdata:contpos,0,2             ; 22 00 C9 00 02 00              
	dw offset dosdata:bcon,0,4                ; 32 00 C9 00 04 00
	dw offset dosdata:carpos,0,106h           ; F9 01 C9 00 06 01
	dw offset dosdata:charco,0,1              ; 00 03 C9 00 01 00
	dw offset dosdata:exec_init_sp,0,34       ; BF 0E C9 00 00 22
	dw offset dosdata:umbflag,0,1	          ; 89 00 C9 00 01 00
	dw offset dosdata:umb_head,0,2            ; 8C 00 C9 00 02 00
	dw offset dosdata:EXECA20,0,1             ; 86 00 C9 00 01 00
	dw offset dosdata:UDF1,0,1                ; B8 12 C9 00 01 00
	dw offset dosdata:UDF2,0,1                ; B9 12 C9 00 01 00
	dw	0, 0, 0, 0, 0
Instance_Table ends

; ===
; Opt_Instance_Table
; This is all guessed. 
; ===
; @dosdata:F3D
; This structure provides a description that excluedes SFT and DPB from DOSDATA segment
Opt_Instance_Table struct
	dw offset dosdata:sysinit, 0, CCH         ; 00 00 C9 00 CC 00 ; 0000 + 00CC = 00CC (SFT starts here)
	dw offset dosdata:carpos,0, 114DH         ; F9 01 C9 00 4D 11 ; 01F9 + 114D = 1346 (DPB starts here)
	dw 0, 0                                   ; 00 00 00 00
Opt_Instance_Table ends

; ===
; Win386_DOSVars
; All from MD6S:dostab.asm
; ===
; @dosdata:F4D
Win386_DOSVars struct
	dw 5, 0                                   ; 05 00 
	dw offset dosdata:SaveDS                  ; EC 05  
	dw offset dosdata:SaveBX                  ; EA 05
	dw offset dosdata:Indos                   ; 21 03
	dw offset dosdata:User_id                 ; 2E 03 
	dw offset dosdata:CritPatch               ; 15 03 
	dw offset dosdata:UMB_Head	              ; 8C 00
Win386_DOSVars ends

; @dosdata: F5B
db IsWin386
db Enable_Win3x                               ; This is from RBIL61, Int 2FH, AX=1231H
```
