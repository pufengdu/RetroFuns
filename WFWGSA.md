# WFWG Loaded by IO.SYS

It is well known that Windows ME let IO.SYS directly load VMM32.VXD, without using COMMAND.COM, without processing CONFIG.SYS and AUTOEXEC.BAT, and without calling WIN.COM. This is also why a number of patches have been released to activate the MS-DOS 8.0 Real mode, which is buried inside Windows ME. 

Another interesting question is: is it possible to configure other versions of Windows to run in a mode like Windows ME, particularly, without loading WIN.COM and any kind of dos command shell before loading Windows. The answer is, Yes. Below is a screen shot, which I have just snapped from my 86Box running MS-DOS 7.1 and Windows for Workgroups 3.11. Please note that in this user's DOS session, the usually exist WIN and the second command shell disappeared. Although a bit tricky, even WFWG311 can be configured in this directly loading mode. Here, direct loading does not mean ignoring CONFIG.SYS, but mean loading without running WIN.COM or a dos command shell first. Obviously, without a dos command shell, the AUTOEXEC.BAT is not processed. The dos kernel IO.SYS has the ability to load the WIN386.EXE of WFWG311 directly after processing CONFIG.SYS.

Besides that, if you are familiar with the limitation of WFWG, the second screenshot show that 4DOS.COM is being used as the WFWG windows shell, under the title W3XDOS, which is not possible if you just set that in the SYSTEM.INI. The WinGO/WinStart did helped. They are not the key to achieve this.

Tech details will be released in future.

![WFWG Loaded by IO.SYS](https://github.com/pufengdu/RetroFuns/blob/main/WFWG_1.png?raw=true)

![4DOS as WFWG shell](https://github.com/pufengdu/RetroFuns/blob/main/WFWG_2.png?raw=true)
