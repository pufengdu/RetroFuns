# How to dump MBR

There are many tools for doing this. However, this is a simple task in DOS. Just use DEBUG, call INT13H, read the correct sector, and write it to a file. To ease this job, I wrote a DEBUG script as follows (DO NOT MISS THE BLANK LINE):

```
; ========================================================
; This is a DEBUG script for dumping MBR into mbr.bin
;     DEBUG < DUMPMBR.DBS
; ======================================================== 
a 300
mov ax,0201
mov bx,0100
mov cx,1
mov dx,80
int 13
int 3

g=300
rcx
200
n mbr.bin
w 100
q

```

Just save the above script as `DUMPMBR.DBS`, and call it with


```
DEBUG < DUMPMBR.DBS
```

It will dump MBR into the `mbr.bin` file. Process like the following screenshot.

<p align="center">
  <img src="https://github.com/pufengdu/RetroFuns/assets/5275359/cf043c25-3b6a-4359-b174-1b011082e05e" width="60%"/>
</p>

Please note the NC flag. That indicates a successful reading.
