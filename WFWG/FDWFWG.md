# WFWG on FreeDOS

## Background
FreeDOS is a good open source implementation of DOS. According to its [official statement](http://wiki.freedos.org/wiki/index.php/FreeDOS_Spec), it mimics MS-DOS 6.22. However, one obvious different is: FreeDOS is generally unable to start Windows 3.x in 386 enhanced mode. This has been discussed widely online, including FreeDOS [official wiki](http://wiki.freedos.org/wiki/index.php/Windows), and also [VOGON](https://www.vogons.org/viewtopic.php?f=61&t=51577).

In most cases, Windows 3.x can be started in the standard mode, but not its 386 enhanced mode. Recently, Windows 3.1 enhanced mode can be started on FreeDOS. This has been proven by many individuals, like discussions on [Reddit](https://www.reddit.com/r/FreeDos/comments/mv5nmj/is_it_possible_to_install_windows_31_on_freedos/) or [BetaArchive](https://www.betaarchive.com/forum/viewtopic.php?t=32105). [SourceForge](https://sourceforge.net/p/freedos/news/2021/07/windows-31-on-freedos/) also has discussions on this topic. Plus, [YouTube](https://www.youtube.com/watch?v=35OQjLYdvJ0) has videos on running Windows 3.1 in enhanced mode. A blog on [VirtuallyFun](https://virtuallyfun.com/2021/07/27/freedos-running-windows-3-1/) shows s serial of screenshots.

However, most people mention that Windows 3.11 or WFWG do not work in FreeDOS. One exception for Windows 3.11 can be found [here](https://danielectra.github.io/blog/windows-31-on-freedos). 

According to my test, WFWG also works, with more settings. See below for two screen shots:

<p align="center">
  <img src="https://github.com/pufengdu/RetroFuns/assets/5275359/2ef84b3a-6864-439e-a2fb-7c716f388d4e" width="40%" />
  <img src="https://github.com/pufengdu/RetroFuns/assets/5275359/b99c8265-7fd0-4693-bdd0-746071bb92ee" width="40%" />
</p>

Although you see the version show 7.1,this is not a fake. If you are familiar with FreeDOS, you know this is set by FreeDOS kernel for compatibility. 

In this article, I will share the steps for making WFWG running under FreeDOS 1.3.

## Methods and Results

The first step is to follow the lead on [StackExchange](https://retrocomputing.stackexchange.com/questions/27480/how-to-use-start-windows-3-11-with-freedos), to download a [kernel file](https://pushbx.org/ecm/test/20230805.2/kwin31.zip) that is compiled with **-DWIN31SUPPORT** with improved [SHARE.EXE](https://pushbx.org/ecm/download/fdshare.zip). According to my trials, the first package contains everything. The SHARE package is not a must.

With a fresh FreeDOS plain installation, replace its kernel with the kernel from kwin31.zip, also the SHARE.EXE. Modify FDAUTO.BAT to load the SHARE.EXE. 

Install WFWG as usual. 

Choose "Return to MS-DOS" at the final stage of the installation. Modifiy FDCONFIG.SYS to load HIMEM.SYS, EMM386.EXE, and SMARTDRV.EXE, which are all come with WFWG. DO NOT use JEMMEX, HIMEMX, or JEMM386. These FreeDOS memory managers are not compatible with WFWG.

Restart computer to use drivers that come with WFWG.

Before WFWG can be started, make sure the following devices are commented out in **SYSTEM.INI**.

```
[386enh]
; Device=ifsmgr.286
; Device=vcache.386
; Device=vshare.386
```

Also, make sure the following line is added as all individuals online

```
[386enh]
InDOSPolling=True
```

After all these modifications, WFWG should work on FreeDOS 1.3, even on a FAT32 partition. Surely, this is like almost every FAT32 DOS running WFWG. Never try to enable 32BFA or 32BDA and live with a temporary swap file.

Plus, the FreeCom response in dos window is weird. After task-switching keys, like Alt+TAB or Alt+Enter is pressed, it will not execute that task switching, an addition Enter key must be pressed to make the previous key effective. I am not sure why. Just replace it with 4DOS 8.0, which is also free. However, if you keep FreeCom to work only in full screen, it is ok. 

## Conclusion

WFWG can be started on FreeDOS 1.3, with some settings. These settings make WFWG and FreeDOS compatible by sacrificing performance of WFWG.


