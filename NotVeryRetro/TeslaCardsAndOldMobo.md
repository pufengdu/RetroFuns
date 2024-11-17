# Running Tesla Cards on Intel 7x/8x/9x boards

## Author: Dr. Pu-Feng Du (2024)

Tesla series is dedicated for datacenter and computational purpose. They are popular in training AIs. They require the "Above 4G decoding" options in UEFI bios on to run normally. However, old mobos do not have this option, even not in hidden options. Installing Tesla cards on Intel 7x/8x/9x mobo always results in a yellow triangle with error "not enough resources". The best solution to this problem is to upgrade your mobo to C236/C246 second hand boards, which is under 400CNY recently (convert to USD yourself if you want the number). 

We are not rich guys, right? So …

The fact is, it is possible to use Tesla cards on these outdated boards. I have tested P40 / P100 / V100 / K80 / K40c / P4 / M10, with GigaByte Z97X-D3H / Asus H87M-PRO / MSI H87M-G43 / Asrock Z87M-PRO4 / GigaByte H77M-D3H. Under the condition that you can obtain correct drivers, the only additional work on these boards is to use DSDT patches to turn on "Above 4G decoding" options. Theoretically, the patches should work even on H61 boards. I have no Intel 6x family boards. Therefore, not tested. But, I have tested H55 / Q57 / X58 / S5520HC, with no luck. If they are possible with 5x families, please tell me details. There is one exception: The Tesla P4 card seems to be different. It does not need the "Above 4G decoding" to be turned on.

The DSDT patches can be applied on firmware level or only loaded by bootloaders. I have successfully in flashing modified firmware on GigaByte Z97 boards. I have also successfully in loading patches using the Clover Bootloader or Grub on all 8x / 7x family boards.

The primary hint comes from the well-known resizable BAR dxe driver, which can be obtained from xCuri0 on Github (https://github.com/xCuri0/ReBarUEFI). But, what really matters in our case is the DSDT patching way that is described in (https://github.com/xCuri0/ReBarUEFI/wiki). All we need to make Tesla cards working is the DSDT patches. 

The complication of these patches is that they are not universal for different boards, even the same chipset. You MUST manually patch each board and each configuration. There is also no AI / automated way to generate these patches. These patches involve manual programing using intel ASL scripts. Since there are errors you must solve yourself, you need to read through the entire wiki of the ReBarUEFI. You may also need to google related information yourself. 

For the details of patches, check links below for details (Read them through, if you are not a Chinese, use a translation software like google translate.) Again, all we need is the DSDT patching part, not the dxe module replacement / insertion part.

For GigaByte 7x / MSI H87 / Asrock Z87 /Asus H87

https://github.com/xCuri0/ReBarUEFI/wiki/DSDT-Patching

For GigaByte Z97 / Z87

https://www.bilibili.com/opus/932064528133259305?spm_id_from=333.999.0.0

Once you have made your own patch, you may try loading them using Grub and test them by Linux first, as described

https://winraid.level1techs.com/t/enable-above-4g-decoding-for-gigabyte-z97x-sli/90728/9

and may be referenced with

https://wiki.archlinux.org/title/DSDT#Using_modified_code

After testing, these patches must be flashed. The above way, in my test, only safely work on GigaByte boards with dual-bios protections. Because these patches, may potentially brick your mobo. GigaByte dual-bios can save you from that. For Asus and Asrock boards, even they have FlashBack protection, you can not do this easily. Because:

1 their stock BIOS images are saved in the "Aptio capsule" format, which is signed. Without correct signature, normal bios update methods do not work. You will see security check errors.

2 It is quite easy to generate the pad-file issue, which is difficult to be fixed, even with the MMTool.

The only luck on Asus /Asrock boards is that their bios chip is a plugged DIP chip, which can be easily rewritten by an external programmer. Remember to solve the serial number / MAC address issue if you do this.

For MSI boards, even it has the M-flash mech, which allow you to test your patch before flashing, bricking the boards will require SPI online programing to recover, as MSI seems to solder their bios chip on board. This is not easy if you do not have all wires ready and quit a dirty work if you are working with an old box and you do not want to clean it first. 

All above issues exist if you decide to patch and flash DSDT patches to UEFI firmware in your mobos. However, we have a different way of doing this. The hint comes from here:

Clover bootloader can be used to load DSDT patches before OS loading. This works for Windows.

https://gist.github.com/raenye/d6645d7039a6136ccfb055e0f8517698

Since all we need is the DSDT patches, not the rebar dxe driver, we can use boot loaders to load DSDT patches.

Several tips for using this method to solve our case:

1 Clover bootloader MUST be installed AFTER Windows installation.

2 Clover bootloader MUST have the config.plist config file

3 Directory structure MUST be established as described: 

https://cloverhackycolor.github.io/Clover-Documentation/#Fixing-DSDT

4 The original DSDT MUST be saved in Clover by pressing F4. It is different to the one we extracted from the BIOS images! Patches MUST be made based on the Clover boot loader version DSDT.

5 After loading patches, the device manager in Windows will show "Large Memory" if you switch the view to "Resource by classes" or something like that. THAT IS THE ONLY SIGN OF ABOVE 4G DECODING IS ON.

