# KRNL386.EXE: a choice from SYSTEM.INI?

In Win9x, KRNL386.EXE is loaded by **SHELL.VXD**, which is packed in the **VMM32.VXD**. **SHELL.VXD** has a very rarely mentioned configuration option in **SYSTEM.INI [386enh]**. It is the **ShellName=** directive. The value of this directive is loaded as a replacement of the **KRNL386.EXE**.

In all versions of Windows 95/98, for replacing KRNL386.EXE, never copy other files over it. Just use the setting in the **SYSTEM.INI**. For example, if you want Windows to give you a dos command shell in its system VM. Just use the following setting in **SYSTEM.INI [386enh]**.

```
ShellName=C:\COMMAND.COM
```

It should be noted that this command shell is a full screen one. You cannot do task switch in it. It will take all extra parameters from the **WIN.COM**. Therefore, if you want it to be permanent, supply the /P to **WIN.COM** before any of the necessary **WIN.COM** own parameters 

For Windows ME, this is a bit tricky. As everyone knows in the retro-computing community, Windows ME load **VMM32.VXD** directly from **IO.SYS**. This options works in Windows ME. However, you have no chance to pass parameters to it without any patch. Plus, the original version of **COMMAND.COM** on Windows ME HDD installation does not work in this condition. The **COMMAND.COM** thinks it is still in DOS and will show you the message you should restart your computer. The Windows ME **COMMAND.COM** 75->EB patch is needed to make this work. Details of this patch can be found on [MultiBoot.Ru](http://www.multiboot.ru/msdos8.htm).

