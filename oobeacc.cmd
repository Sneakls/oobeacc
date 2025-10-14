@echo off

goto GETOPTS

:GETOPTS
IF "%~1"=="" goto NoUser
IF NOT "%~1"=="" goto SetUser

:SetUser
net user %~1 "" /add
net localgroup administrators %~1 /add
net user %~1 /active:yes
net user %~1 /expires:never
net user Administrator /active:no
net user defaultUser0 /delete
echo Y | REG DELETE "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE /va /f
echo Y | REG ADD "HKLM\SOFTWARE\Microsoft\Windows\CurrentVersion\OOBE" /v SkipMachineOOBE /t REG_DWORD /d 1 /f
shutdown /r /t 1
exit

:NoUser
echo No username was entered
pause
