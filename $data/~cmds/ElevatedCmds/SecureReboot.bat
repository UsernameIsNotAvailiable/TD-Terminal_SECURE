@ECHO OFF
cls
echo Reverting all temporary changes. . .
call C:\TD-Terminal_SECURE\$data\~cmds\ElevatedCmds\RevertTempChanges.bat
timeout /t 2 /nobreak > nul
echo Writing unsaved data. . .
echo %DATE% %TIME% : $SYSTEM initiated secure reboot>>C:\TD-Terminal_SECURE\$data\temp\SecRbt.txt
timeout /t 4 /nobreak > nul
cls
echo The system is ready to reboot.
echo Press any key to proceed.
pause > nul
cls
timeout /t 1 /nobreak > nul
echo Initing reboot{~#secure}
echo Rebooting. . .
timeout /t 2 /nobreak > nul
cls
timeout /t 4 /nobreak > nul
shutdown -r -t 3