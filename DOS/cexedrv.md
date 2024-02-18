# Writing exe format device drivers in C with a small model and farstack

## Notes

### 1 Can device drivers be written in C?

Yes, but not completely. Some ASM is needed. Just do not link C startup codes. Write some ASM lines to set segment registers for C routines, and also set header of a driver.

### 2 Can device drivers be an EXE?

Yes, a lot of them exist. How is the only question. Compile and link C obj files with the manually ASM startup codes together, small model will work for EXE format. SS and DS does not need to be equal. Having a special SS is a good choice. Just make the ASM memory model identical to the C model. For BCC, use `-ms!` to set DS!=SS. For TASM, use `model small, c, farstack` directive. Plus, we must keep DS and SS:SP before calling C routines. They must be restored before returning to the DOS system. So, before invoking a C function, set DS and SS:SP to our own DS, and SS:SP. Use somthing like the follows and use the `invoke_c` macro.

```asm
macro enter_c r_sys_data, r_sys_stack, r_c_data
    ;; r_sys_stack: dd for keeping system ss:sp
    ;; r_sys_data: dw for keeping system ds, must be in CS segment
    ;; r_c_data: ds for c realm, @data is ok for small model
    mov [word ptr cs:r_sys_data], ds
    push r_c_data
    pop ds
    mov [word ptr ds:r_sys_stack], sp
    mov [word ptr ds:r_sys_stack + 2],ss
endm

macro leave_c r_sys_data, r_sys_stack
    ;; r_sys_stack: dd for keeping system ss:sp
    ;; r_sys_data: dw for keeping system ds, must be in CS segment
    mov sp, [word ptr ds:r_sys_stack]
    mov ss, [word ptr ds:r_sys_stack + 2]
    mov ds, [word ptr cs:r_sys_data]
endm

macro invoke_c r_sys_data, r_sys_stack, r_c_data, r_c_stack, r_c_stack_size, r_c_proc
    enter_c r_sys_data, r_sys_stack, r_c_data
    push r_c_stack
    pop ss
    mov sp, r_c_stack_size
    call r_c_proc
    leave_c r_sys_data, r_sys_stack
endm
```


If DS==SS is assumed by BOTH C and ASM, adjust DS and SS:SP before invoking C functions, because it is not default by ASM. Use somthing like:

```asm
mov dx, @data
mov ds, dx
mov bx, ss
sub bx, dx
shl bx, 04h
mov ss, dx
add sp, bx
```


