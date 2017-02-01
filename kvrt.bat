@echo off
set kvrtlog="%userprofile%\desktop\stinger\"
if not exist %kvrtlog% md %kvrtlog%
kvrt.exe -d "%kvrtlog%" -accepteula -adinsilent -silent -processlevel 2 -dontcryptsupportinfo