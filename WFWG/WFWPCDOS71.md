# Running Windows For Workgroups 3.11 on IBM PC-DOS 7.1

## Results

The very interesting result is: this is possible. Running WFW on PC-DOS 7.1 is pretty simple, like on MS-DOS 7.1. I know that many people have failed in doing this. Some thread on [Vogon](https://www.vogons.org/viewtopic.php?f=61&t=67237) does not look like a success. However, I made them work. The most important tip is: **Refrain your finger from touching the 32BFA or 32BDA options**, if you do not want any weird event. The best choice of the Virtual Memory setting is: a **temporary swap file** on a FAT32 partition, with **Disk Access = Using MS-DOS**, and **32BFA/32BDA OFF**. See the following figure, size of the swap file does not matter. 

<img src="https://github.com/pufengdu/RetroFuns/assets/5275359/6f771d3e-5ca8-4462-8502-62644be66b1d" width="50%" align="center" />

## Installation steps

1 WFW can be installed on a FAT32 partition in PC-DOS 7.1, normally. The problem happens on starting WFW for the first time. Usually, an error message like:

```
Cannot find or load required file KRNL386.EXE.
```

2 Unlike MS-DOS 7.1, PC-DOS 7.1 does not need any patch. The original PC-DOS 7.1 in the [IBM SGTK](https://www.ibm.com/support/pages/ibm-serverguide-scripting-toolkit-dos-edition-version-1307) can start WFW normally.

3 Due to the FAT32 issue, as described on [MSFN](https://msfn.org/board/topic/155954-how-do-i-stop-garbled-directory-after-exiting-win311/), the [WIN386.EXE patch](https://msfn.org/board/topic/155954-how-do-i-stop-garbled-directory-after-exiting-win311/?do=findComment&comment=993173) is still needed.

4 Suppose WFW is installed in C:\WINDOWS, the following directives must be added to CONFIG.SYS. I still have no idea on the [SWITCHES=/I](https://msfn.org/board/topic/185983-what-is-the-function-of-switchesi-in-pc-dos-71-configsys/#comment-1258983)

```
SWITCHES=/I /W
DEVICE=C:\WINDOWS\IFSHLP.SYS
```

A reboot is required to apply these directives.

5 The following directive MUST be commented out in your **SYSTEM.INI [386enh]**

```
device=vshare.386
```

It must be changed to 

```
; device=vshare.386
```

or be deleted.

6 The WINA20.386 from PC-DOS 2000 is needed. It should be placed in the SYSTEM directory of your WFW installation. Plus, the following directive must be added in **SYSTEM.INI [386enh]**

```
device=wina20.386
```

After performing all these, WFW should work smoothly on a FAT32 partition in PC-DOS 7.1.

## Additional tips:

**Tip 1**: If you have a FAT16 partition, you may put a permanent swap file on that FAT16 partition.

**Tip 2**: Once you began to do Tip 1, never ever click "Restart Windows" in the following dialog box, or the "Restart computer" in some similar box. Make sure you always choose "Continue". There is a potential risk of data lose if you violate this. After choosing "Continue", exit windows and restart manually.

<img src=https://github.com/pufengdu/RetroFuns/assets/5275359/cc9f368c-401d-44ca-8f99-ebeae9b24627 width="40%" /> <img src=https://github.com/pufengdu/RetroFuns/assets/5275359/2b6b27ab-f07f-44e5-9aaf-76928126de80 width="40%" />

**Tip 3**: If you installed your WFW on a FAT16 partition in PC-DOS 7.1. All those installation steps are still needed to make it work for the first time! After that, you can enable permanent swap file and 32 BFA as described in Tip 2. Before you restart WFW, make sure to edit **SYSTEM.INI [386enh]**, now the 

```
device=vshare.386 
```

**MUST** be enabled. 

**Tip 4**: Be aware, after Tip 3, you are restricted to run programs that are stored on your FAT16 partition ONLY!. All attempt to execute a program on a FAT32 partition will result in Sector not found error like the following. 

Be sure to choose "A" in the case of the following figure!! Never choose "I", which may result in data lose here. However, you can copy files from other drives to your FAT16 partition.

![image](https://github.com/pufengdu/RetroFuns/assets/5275359/1fbda580-129a-4e3c-8491-e92a9b71b25d)

**Tip 5**: 32BDA can also be enabled after Tip4. Surely, a proper driver is needed. The MicroHouse MH32BIT.386 works in my case. The behavior does not change much.

![image](https://github.com/pufengdu/RetroFuns/assets/5275359/50c743f4-158d-4085-abeb-fac1fbd2d746)

After enabling 32BDA, add the following directive to your **SYSTEM.INI [386enh]** if your drive C is a FAT32 partition. Some rumors say this will help protecting your FAT32 drive in PC-DOS 7.1

```
ForceMapper=C
```

Remember that MS-DOS 7.1 has a **LOCK** command? PC-DOS 7.1 does not have this command. According to [RBIL](http://www.ctyme.com/intr/rb-2897.htm), LOCK command in MS-DOS 7.1 were essentially performed by INT 21H/AX=440DH. I tried to call that API in PC-DOS 7.1 using DEBUG. It's a success. But the behavior of WFW does not change.

That all I have done in installing WFW in PC-DOS 7.1.

