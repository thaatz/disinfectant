@echo off
pushd %~dp0 2>NUL
REM Download EmsisoftEmergencyKit from https://www.emsisoft.com/en/home/emergencykit/
:: SCANONLY, 1 for scan only, no d
set scanonly=1
set quarantinesetting= 
if %scanonly%==0 set quarantinesetting=/quarantine=%cd%\Quarantine

:: LOGGING
:: for use with tronlite, set this to %tronlog%
set eeklog=%tronlog%
REM set eeklog="%userprofile%\desktop\"
REM set eeklog="%cd%\EmsisoftEmergencyKit\Logs\"
rem if not exist %eeklog% md %eeklog%
REM maybe use this if you want to change log name by date or time https://ss64.com/nt/syntax-getdate.html

REM download Emsisoft Emergency Kit from https://www.emsisoft.com/en/home/emergencykit/
REM command line usage https://www.emsisoft.com/en/software/cmd/



:: https://ss64.com/nt/syntax-64bit.html
Set _os_bitness=64
IF %PROCESSOR_ARCHITECTURE% == x86 (
  IF NOT DEFINED PROCESSOR_ARCHITEW6432 Set _os_bitness=32
  )

:: run an update first
.\EmsisoftEmergencyKit\bin%_os_bitness%\a2cmd.exe /update

:: exclude onedrive because it will start to download extra junk
:: not using the %onedrive% variable because the variable might not exist on some installations of windows
echo %userprofile%\onedrive>whitelist.txt

echo starting EEK Scan on %date% at %time%>>"%eeklog%"
.\EmsisoftEmergencyKit\bin%_os_bitness%\a2cmd.exe /files="C:\" /quick /log="%cd%\Logs\EEKscan.log" /whitelist="%cd%\whitelist.txt" %quarantinesetting%
if %errorlevel%==0 set eekresult=CLEAN
if %errorlevel%==1 set eekresult=INFECTION
echo finished EEK Scan on %date% at %time% with result %eekresult%>>"%eeklog%"
if %errorlevel%==1 echo see "%cd%\Logs\EEKscan.log" for details>>"%eeklog%"