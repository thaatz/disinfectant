@echo off
REM -N If the local file is newer, the remote file will not be re-fetched http://www.editcorp.com/personal/lars_appel/wget/wget_5.html#SEC23
bin\wget.exe -N http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe
echo latest stinger as of %date% > stinger.txt
pause