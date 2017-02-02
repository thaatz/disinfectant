@echo off
set kvrtlog="%userprofile%\desktop\kvrt\"
if not exist %kvrtlog% md %kvrtlog%
REM http://support.kaspersky.com/8537
REM -d                    : specify the folder for reports, quarantine, and trace files
REM -accepteula           : accept the license agreement
REM -adinsilent           : active disinfection without displaying graphical user interface
REM -silent               : run in silent mode
REM -processlevel 2       : neutralize objects with high and moderate threat levels
REM -dontcryptsupportinfo : disable encryption of trace files/reports/dump files
kvrt.exe -d "%kvrtlog%" -accepteula -adinsilent -silent -processlevel 2 -dontcryptsupportinfo