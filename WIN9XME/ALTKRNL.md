# KRNL386.EXE a choice from SYSTEM.INI

In Win9x, KRNL386.EXE is loaded by **SHELL.VXD**, which is packed in the VMM32.VXD. SHELL.VXD has a very rarely mentioned configuration option in **SYSTEM.INI [386enh]**. It is the **ShellName=** directive. The value of this directive is loaded as a replacement of the KRNL386.EXE.

For replacing KRNL386.EXE, never copy other files over it. Just use the setting in the SYSTEM.INI. For example, if you want Windows to give you as dos command shell in its system VM. Just use the following settings in SYSTEM.INI [386enh].

```
ShellName=C:\COMMAND.COM
```
