@echo off
REM -N If the local file is newer, the remote file will not be re-fetched http://www.editcorp.com/personal/lars_appel/wget/wget_5.html#SEC23
bin\wget.exe -N http://devbuilds.kaspersky-labs.com/devbuilds/KVRT/latest/full/KVRT.exe
echo KVRT downloaded on %date% > kvrt.txt
pause