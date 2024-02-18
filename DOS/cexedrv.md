# Writing exe format device drivers in C with a small model and farstack

## Notes

### 1 Can device drivers be written in C?

Yes, but not completely. Some ASM is needed. Just do not link C startup codes. Write some ASM lines to set segment registers for C routines, and also set header of a driver.

### 2 Can device drivers be an EXE?

Yes, a lot of them exist. How is the only question. Compile and link C obj files with the manually ASM startup codes together, small model will work for EXE format. SS and DS does not need to be equal. Having a special SS is a good choice. Just make the ASM memory model identical to the C model. For BCC, use `-ms!` to set DS!=SS. For TASM, use `model small, c, farstack` directive. Plus, we must keep DS and SS:SP before calling C routines. They must be restored before returning to the DOS system. So, before invoking a C function, set DS and SS:SP to our own DS, and SS:SP. 

If DS==SS is assumed by BOTH C and ASM, adjust DS and SS:SP before invoking C functions, because it is not default by ASM. Use somthing like:

```
mov dx, @data
mov ds, dx
mov bx, ss
sub bx, dx
shl bx, 04h
mov ss, dx
add sp, bx
```


