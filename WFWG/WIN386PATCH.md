# A drop-in method for patching WIN386.EXE

### Author: Pu-Feng Du

It is a common knowledge in the retro computing, that installing Windows 3.x on a FAT32 partition needs patching WIN386.EXE. Otherwise, directories will be "garbled" after exiting Windows 3.x. This has been discussed in details on [MSFN](https://msfn.org/board/topic/155954-how-do-i-stop-garbled-directory-after-exiting-win311). [Vogons](https://www.vogons.org/viewtopic.php?t=31922) also mentioned it .

Here, I propose an alternative way for this patching WIN386.EXE. 

With the [VXDLIB](https://web.archive.org/web/20061231040431/http://www.tbcnet.com/~clive/vxdlib.zip) tools from Clive Turve, WIN386.EXE can be extracted to several separate VxD files. Or, you may also call them 386 files, in the context of Windows 3.x. The patch, which is from R Loew, resides in the DOSMGR.VXD. Therefore, patching DOSMGR.VXD will be enough. The patched VxD file can be loaded via configurations in the SYSTEM.INI. This is better than directly patching WIN386.EXE, as it can be unloaded easily, just by adding a colon in SYSTEM.INI.

The full steps are here:

### 1 Use VXDLIB to extract WIN386.EXE

Find a safe place, copy your WIN386.EXE there, extract it.

```
VXDLIB -e WIN386.EXE *
```

### 2 Use any hex editor to patch DOSMGR.VXD

Find and replace the following patten, **!!TWICE!!**.

I have tried Windows 3.1, WFW3.11, and Windows 3.2 CHS edition. All have same patterns.

```
66 C7 46 49 FF FF -> 6A FF 8F 46 49 90
```

### 3 Copy the patched DOSMGR.VXD to the SYSTEM directory of your windows 3.x installation.

Just or better feelings, name it as DOSMGR.386

### 4 Switch On/Off the patch in your SYSTEM.INI

Install the patch

```
; This installs the patch
;device=*dosmgr
device=dosmgr.386
```

Uninstall the patch

```
; This uninstalls the patch
device=*dosmgr
;device=dosmgr.386
```
