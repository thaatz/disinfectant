@echo off
pushd %~dp0 2>NUL
:: http://stackoverflow.com/questions/3068929/how-to-read-file-contents-into-a-variable-in-a-batch-file
set /p stingerbuild=<stinger.txt
set /p kvrtbuild=<kvrt.txt
set /p eekbuild=<eek.txt
title Disinfectant Updater
:main
cls
echo.
echo  ÉÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ»
echo  º                               Disinfectant                                º
echo  ºÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄÄº
echo  º What do you want to update?                                               º
echo  º                                                                           º
if "%stingerbuild%"=="" (
	echo  º 1. Stinger [none]                                                         º
) else echo  º 1. Stinger [%stingerbuild%]                                               º
if "%kvrtbuild%"=="" (
	echo  º 2. KVRT [none]                                                            º
) else echo  º 2. KVRT [%kvrtbuild%]                                                  º
if "%eekbuild%"=="" (
	echo  º 3. EEK [none]                                                             º
) else echo  º 3. EEK [%eekbuild%]						     º
echo  ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
set /p exs=Make selection: 
if /i "%exs%"=="1" goto :updstinger
if /i "%exs%"=="2" goto :updkvrt
if /i "%exs%"=="3" goto :updeek
:: needed to add quotes for syntax in windows 8+
:: http://stackoverflow.com/questions/19308159/batch-simply-syntax-error-goto-was-unexpected-at-this-time
goto :main

:updstinger
echo.
:: -N If the local file is newer, the remote file will not be re-fetched http://www.editcorp.com/personal/lars_appel/wget/wget_5.html#SEC23
bin\wget.exe -N http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe
echo %date%>stinger.txt
:: wait for 2 seconds so we can see the results
REM pause
ping localhost -n 3 >nul
goto :EOF

:updkvrt
echo.
:: -N If the local file is newer, the remote file will not be re-fetched http://www.editcorp.com/personal/lars_appel/wget/wget_5.html#SEC23
bin\wget.exe -N http://devbuilds.kaspersky-labs.com/devbuilds/KVRT/latest/full/KVRT.exe
echo %date%>kvrt.txt
:: wait for 2 seconds so we can see the results
ping localhost -n 3 >nul
goto :EOF

:updeek
echo.
:: -N If the local file is newer, the remote file will not be re-fetched http://www.editcorp.com/personal/lars_appel/wget/wget_5.html#SEC23
:: first get the home page to read the version
echo check for updates . . .
echo.
bin\wget.exe https://www.emsisoft.com/en/home/emergencykit/
::http://stackoverflow.com/questions/22198458/find-text-in-file-and-set-it-as-a-variable-batch-file
REM for /F "delims=" %%a in ('findstr "&mdash; Released:" index.html') do set new_link=%%a
for /F "delims=" %%a in ('findstr "Released" index.html') do set "eek_ver=%%a"
del index.html
:: just get the section right after Version:
set eek_ver=%eek_ver:~8,15%
:: remove the & sign in case we capture that as well https://www.dostips.com/DtTipsStringManipulation.php#Snippets.Replace
set eek_ver=%eek_ver:&=%
:: also remove spaces
set eek_ver=%eek_ver: =%
echo %eek_ver%>eek.txt

if "%eek_ver%"=="%eekbuild%" (
	echo.
	echo %eek_ver%
	echo no update detected
	pause
	goto :EOF
)

:: now start the actual download
bin\wget.exe -N https://dl.emsisoft.com/EmsisoftEmergencyKit.exe
REM 7zip stuff here
bin\7z x -o"EmsisoftEmergencyKit.exe" -y "EmsisoftEmergencyKit"

:: wait for 2 seconds so we can see the results
ping localhost -n 3 >nul
goto :EOF
