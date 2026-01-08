# How MS-DOS 8.0's SYS.COM works

It is a quit common knowledge that the SYS.COM of Windows ME does not work in the same way as Windows 98's It you execute SYS C: command from the EBD disk with an empty hard drive C, you will see it complains:

```
Cannot find the system file in the standard locations on drive C:. SYS can only be used on drive C: to attempt a repair of an already existing installation of Windows. Use Windows SETUP to make drive C: bootable.
```

This is normal. Windows ME has different IO.SYS for hard drive and EBD. Therefore, its normal behavior should not be coping IO.SYS from the EBD to the hard drive. The hard drive version IO.SYS must be copied from elsewhere. This is what the "standard locations" refer to. The "standard location" when you see the above message refer to the following directory:

```
C:\WINDOWS\COMMAND\EBD
```

As long as you keep an WINBOOT.SYS in this directory, the SYS C: command will copy it to C:\IO.SYS anyway, regardless to the content of the file.

In addition, Windows ME's SYS.COM would NOT copy command.com to C:\. Why? Windows ME does not need it to start. IO.SYS will load VMM32.VXD directly. There is no position in Windows ME for a COMMAND.COM in it startup process.

**Therefore, to let SYS.COM work, you will need to build the directory yourself, and copy MSDOS.SYS and COMMAND.COM yourself**. These can be done with a simple batch file, right?

