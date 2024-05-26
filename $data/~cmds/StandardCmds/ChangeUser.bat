set user=%1
set newuser=%2
reg add HKCU\Software\TD-Secure\Users\%user% /v Username /d %newuser% /f