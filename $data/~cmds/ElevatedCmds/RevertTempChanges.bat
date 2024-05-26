@ECHO OFF
reg add HKCU\Software\TD-Secure\Users\$default /v ElevatedAccess /t REG_DWORD /d 0 /f
reg add HKCU\Software\TD-Secure\Users\$Administrator /v SystemAccess /t REG_DWORD /d 0 /f
exit