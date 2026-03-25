# Z87 is Z97?

This is just a quick note, recording my experiments yesterday. 

I have an ASRock **Z87M** Pro4 mobo. I downloaded the ASRock **Z97M** Pro4 newest UEFI image. Use [me_cleaner](https://github.com/corna/me_cleaner) to disable its ME. I then use an external SPI programmer to flash the image. The board runs, with an i7-5775C and "AMD memory bars". This is simple, right. There is still a bug. The UEFI can not read fan speed. The thermal control works normally, just without fan speed readings.
