@echo off
pushd %~dp0 2>NUL
set stingerlog="%userprofile%\desktop\stinger\"
if not exist %stingerlog% md %stingerlog%
REM https://www.mcafee.com/us/downloads/free-tools/how-to-use-stinger.aspx
REM --adl         : scan all local drives
REM --go          : start scanning immediately
REM --silent      : initiate a silent scan
REM --program     : report applications
REM --repair      : repair object if a virus is found
REM --reportpath= : save log file to specified directory
REM --scanpath=   : scan specified directories (--scanpath=c:\)
REM --epo         : run without the real protect component https://www.mcafee.com/us/downloads/free-tools/how-to-use-stinger.aspx
stinger32.exe --go --silent --program --repair --reportpath=%stingerlog% --epo