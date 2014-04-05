@echo off 
 
tasklist /FI "IMAGENAME eq notepad.exe" | find /i "notepad.exe"
 
IF ERRORLEVEL 2 GOTO TEST2 
IF ERRORLEVEL 1 GOTO TEST1 
 
:TEST2  
goto EXIT 
 
:TEST1 
mailsend.exe -to you@gmail.com -from me@nwgat.net -ssl -port 465 -auth -smtp smtp.gmail.com -sub test -user me@nwgat.net -pass "password"  -M "notepad.exe does not run!
goto EXIT 
 
:EXIT 
pause
