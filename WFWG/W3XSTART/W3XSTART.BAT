@echo off
:: ==========================================================================
:: W3XSTART.BAT - A batch file to help loading Windows 3.x in MS-DOS 7.1
::     Copyright 2026 (C) Dr. Pu-Feng Du.
::
:: All below relies on STRINGS.COM. Only two bytes need to be modified for
:: loading Windows 3.x. All modifications are in memory.
::
:: 1) W3Enable Flag: This is the byte just after IsWin386 flag. In MS-DOS 7.1
::    ,this flag is at offset F5C in DOS data segment, which can be obtained 
::    by calling INT 21H, AH=52H. Set that byte to 01.
:: 2) Expected Windows Version: This is an imm16 operand in a CMP instruction
::    in the INT 2FH, AX=1605H handler. The search pattern: 81 FF 00 04 73 06
::    BE 04, will return a unique offset in the DOS code segment. Since we 
::    only need to patch memory, we set DOSCODE to FFFF if DOS is in HMA, to
::    the same segment as DOSDATA if DOS is in LOW. The patch location is at
::    offset + 3. Replace the byte 04 with byte 03.
::
:: Note: Every time Windows 3.x exits, 1) will be rewritten to 00, 2) will
:: remain unchanged. Therefore, run this batch file every time before you
:: type WIN. 
:: ==========================================================================

:: ==========================================================================
:: Check system status
:: HIMEM if HIMEM is installed
:: WINBOX if now is in Windows dos session
:: ISWIN if running Windows
:: After obtaining three status, call INT 21H, AH=52H to obtain DOS Data
:: segment. The W3Enable flag is @ DOSDATA:F5C
:: Use %DOSDATA%:%W3XENABLE% as the address to modify
:: ==========================================================================
strings HIMEM=2fcheck himem
strings WINBOX=2fcheck dosbox
strings ISWIN=INWIN
strings /B16 I21AH52=interrupt 21,5200
strings DOSDATA=parse %I21AH52%,9,
set I21AH52=
set W3XENABLE=F5C

:: ==========================================================================
:: If no HIMEM is installed, we do not need futher processing, as Windows will
:: not run.
:: ==========================================================================
if NOT (%HIMEM%)==(0) goto hashimem
goto end

:: ==========================================================================
:: If already in Windows, just abort.
:: ==========================================================================
if NOT (%WINBOX%)==(0) goto exit_inwin
if NOT (%ISWIN%)==(0) goto exit_inwin

:: ==========================================================================
:: Check if DOS is in HMA or not
:: ==========================================================================
:hashimem
strings /B16 I2FAX4A01=interrupt 2f,4a01
strings HMASIZE=parse %I2FAX4A01%,2,
if NOT (%HMASIZE%)==(0) goto dosinhma
goto dosinlow

:: ==========================================================================
:: Set DOSCODE segment according to above tests
:: ==========================================================================
:dosinhma
set DOSCODE=FFFF
goto findexpwin

:dosinlow
set DOSCODE=%DOSDATA%

:: ==========================================================================
:: Search the pattern
::     CMP DI,0400
::     JAE +06
:: to find the patch location, add the offset with 3 to get W3VEXP location.
:: If searching pattern fails, go nopat_exit to perform only one patch.
:: ==========================================================================
:findexpwin
strings /B16 W3VERCHK=scan %DOSCODE%,0,81,ff,00,04,73,06,be,04
if (%W3VERCHK%)==() goto nopat_exit
strings /B16 W3VEREXP=parse %W3VERCHK%,2,
strings /B16 W3VEXP=add %W3VEREXP%,3

:: ==========================================================================
:: Perform the patch in memory
:: ==========================================================================
:mpatch
strings /B16 POKE %DOSDATA%,%W3XENABLE%,1
strings /B16 POKE %DOSCODE%,%W3VEXP%,3
goto end

:: ==========================================================================
:: Already in windows, abort
:: ==========================================================================
:exit_inwin
echo Windows is running, abort
goto end

:: ==========================================================================
:: For second time running this batch file, the search will fail. Therefore,
:: patch only the W3Enable flag.
:: ==========================================================================
:nopat_exit
echo No code pattern, only W3Enable flag patched
strings /B16 POKE %DOSDATA%,%W3XENABLE%,1

:: ==========================================================================
:: Cleanup and exits
:: ==========================================================================
:end
SET HIMEM=
SET WINBOX=
SET ISWIN=
SET I2FAX4A01=
SET HMASIZE=
set W3VERCHK=
set W3VEREXP=
SET DOSDATA=
SET DOSCODE=
SET W3XENABLE=
SET W3VEXP=

