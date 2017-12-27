@echo off

set ssdir=%~dp0

if exist %ssdir%Shadowsocks.exe goto SSValid

:SSNotValid
echo Shadowsocks application not existed in path "%ssdir%". 
echo Please check the folder path.
timeout /t 7 /nobreak>nul
exit

:SSValid
if exist %ssdir%gui-config.json goto CFGValid

:CFGNotValid
echo Config file does not exist or port setup not detected.
echo Using defalt localport 1080.
set ss_port=1080
goto StartCheck

:CFGValid
FOR /F "tokens=1,2 delims= " %%j IN (%ssdir%gui-config.json ) DO if %%j=="localPort": set port_str=%%k
FOR /F "tokens=1 delims=," %%l IN ("%port_str%") DO set ss_port=%%l
if "%ss_port%"=="" goto CFGNotValid
echo gui-config.json detected. localPort was set to %ss_port%.

:StartCheck
for /f "tokens=5" %%i in ('netstat -aon ^|find /i "listening" ^|findstr %ss_port%') do set pidnum=%%i
if "%pidnum%"=="" GOTO StartSS
for /f "tokens=1" %%i in ('tasklist ^|findstr %pidnum%') do set proc_name=%%i
if "%proc_name%"=="Shadowsocks.exe" GOTO AlreadyRun

:KillPID
echo Found process with PID %pidnum% using port %ss_port%. Force killing it...
TASKKILL /F /PID %pidnum%

:StartSS
start %ssdir%shadowsocks.exe
echo Shadowsocks successfully started.
timeout /t 5 /nobreak>nul
exit

:AlreadyRun
echo Shadowsock is running on port %ss_port% already.
timeout /t 7 /nobreak>nul
exit