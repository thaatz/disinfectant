@echo off
:: http://stackoverflow.com/questions/3068929/how-to-read-file-contents-into-a-variable-in-a-batch-file
set /p stingerbuild=<stinger.txt
set /p kvrtbuild=<kvrt.txt
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
) else echo  º 2. KVRT [%kvrtbuild%]                                                 º
echo  ÈÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍÍ¼
set /p exs=Make selection: 
if /i "%exs%"=="1" goto :updstinger
if /i "%exs%"=="2" goto :updkvrt
:: needed to add quotes for syntax in windows 8+
:: http://stackoverflow.com/questions/19308159/batch-simply-syntax-error-goto-was-unexpected-at-this-time
goto :main

:updstinger
echo.
:: -N If the local file is newer, the remote file will not be re-fetched http://www.editcorp.com/personal/lars_appel/wget/wget_5.html#SEC23
bin\wget.exe -N http://downloadcenter.mcafee.com/products/mcafee-avert/stinger/stinger32.exe
echo %date%>stinger.txt
:: wait for 2 seconds so we can see the results
pause
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
