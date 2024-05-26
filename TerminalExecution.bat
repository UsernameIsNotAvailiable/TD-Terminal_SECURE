@ECHO OFF


::set global vars n stuff
for /f "tokens=3" %%a in ('reg query "HKCU\Software\TD-Secure\Users\$Administrator"  /V Username  ^|findstr /ri "REG_SZ"') do set AdminName=%%a
for /f "tokens=3" %%b in ('reg query "HKCU\Software\TD-Secure\Users\$default"  /V Username  ^|findstr /ri "REG_SZ"') do set NormalName=%%b
set TempAdmin=0
set TempSys=0
set displayuser="~/Users/$default> "
set syspsw="210129944"
set adpw="120464"
set defaultpswd="9944"


cls
echo Preparing terminal. . .
timeout /t 3 /nobreak > nul
cls
echo Loading. . .
timeout /t 1 /nobreak > nul
cls
echo Notice!
echo ---------------------------------------
echo TD-Terminal Secure is intended for jobs requiring secure terminals.
echo Your system administrator can change the security settings.
echo ---------------------------------------
echo Press any key to proceed to TD-Terminal
pause > nul

:start
cls
echo TD-Terminal_SECURE (Version: 5.3.21)
echo System Administrator: %AdminName%
echo ---------------------------------------
:cmd
set /p cmd=%displayuser%

::cmd list
set elevate="elevate /type:admin"
set elevate2="elevate /type:sys"
set exit="quit"
set elevatehelp="elevate /help"
set clear="cls"
set changeuser="ucu"
set secreboot="reboot /type:secure"
set systemtree="tree:host"
set help="help"
set updates="updates"
set ipconfig="ip /all"
    set ipconfigdns="ip /dns"
    set ipconfigflushdns="ip /flushdns"
set winescape="escape"
set Update="get: updates"


if "%cmd%"==%elevate% goto :ElevateUser
if "%cmd%"==%elevate2% goto :ElevateSys
if "%cmd%"==%exit% goto :shutdownseqence
if "%cmd%"==%elevate% goto :elevatehelp
if "%cmd%"==%changeuser% goto :usernamechange
if "%cmd%"==%clear% goto :clearcmd
if "%cmd%"==%secreboot% goto :secrebt
if "%cmd%"==%systemtree% goto :systree
if "%cmd%"==%help% goto :help
if "%cmd%"==%updates% goto :updatelog
if "%cmd%"==%ipconfig% goto :ipconfig
if "%cmd%"==%ipconfigdns% goto :ipconfigdns
if "%cmd%"==%ipconfigflushdns% goto :ipconfigflushdns
if "%cmd%"==%winescape% goto :winscape
if "%cmd%"==%Update% goto :update
echo Unknown command: '%cmd%', try typing 'help'.
goto :cmd

:update
cls
echo EXPERIMENTAL FEATURE : UPDATES
echo ---------------------------------------------
echo        U - Check for updates
echo        C - Cancel
echo.
echo ---------------------------------------------
choice /c UC /m "Select an option"
if %ERORRLEVEL%==1 goto :update2
if %ERORRLEVEL%==2 goto :cmd

:update2
call C:\TD-Terminal_SECURE\$data\~cmds\StandardCmds\update.bat
pause
goto :cmd

:help
echo.
echo ---------------------------------------------
echo elevate   -      Elevate the current user
echo quit      -      Quits the process.
echo cls       -      Clears the output
echo ucu       -      Username Change Utility
echo tree:host -      Creates a tree of the host.
echo updates   -      Lists Updates
echo ip        -      Windows IP Utilities
echo escape    -      Escapes to windows cmd
echo.
goto :cmd


:ipconfigall
echo Internet Protocol Configuration Utility
pause
ipconfig /all
goto :cmd

:ipconfigdns
echo Internet Protocol Configuration Utility
pause
ipconfig /displaydns
goto :cmd

:ipconfigflushdns
echo Internet Protocol Configuration Utility
pause
ipconfig /flushdns
goto :cmd





:updatelog
echo Integrated 'help' as a command.
echo Working on introducing windows commands.
echo    1 - Introducing ipconfig as ip /config:ACTION
echo ---------------------------------------
echo.
goto :cmd





:systree
cls
echo Preparing to execute. . .
timeout /t 3 > nul
cls
cd \
tree /f
echo Finished!
echo Press any key to exit.
pause > nul
goto :start

:clearcmd
cls
goto :cmd

:secrebt
echo Checking permissions. . .
timeout /t 3 /nobreak > nul
if %TempSys%==1 (
    echo Verified the user as $SYSTEM.
    timeout /t 2 /nobreak > nul
    cls
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
shutdown /r /t 3
) else (
    cls
    echo Error: Invalid permissions.
    echo Error details
    echo ---------------------------
    echo The user was the verified as $SYSTEM.
    echo The user requires $SYSTEM permissions to execute tasks on the device.
    echo Press any key to leave this menu.
    pause > nul
    goto :start
)


:usernamechange
cls
echo Loading. . .
timeout /t 3 /nobreak > nul
cls
echo Notice    -     Username Change Utility
echo ---------------------------------------
echo This will only change the Username displayed on screen.
echo Changing the file name of your use will cause the system to break.
pause
:UCU2
cls
echo Username Change Utility
echo ---------------------------------------
::users
set user1="$default"
set user2="$Administrator"
set revert="REVERT"
set leave="QUIT"
echo Select a user or type REVERT to revert all username changes.
echo Type QUIT to leave UCU.
echo     $Administrator
echo     $default
echo.
set /p userchange="ucu> "
echo Processing. . .
timeout /t 3 /nobreak > nul

if "%userchange%"==%user1% goto :changedefault
if "%userchange%"==%user2% goto :changeAdministrator
if "%userchange%"==%revert% goto :usernamerevert
if "%userchange%"==%leave% (
    echo.
    echo Leaving Username Change Utlity. . .
    echo.
    goto :cmd
)


:usernamerevert
echo To proceed with reverting, enter the password for $SYSTEM
set /p revertuser="Password for $SYSTEM: "
echo Verifying. . .
timeout /t 3 /nobreak > nul
echo Verified!
echo Reverting username changes. . .
call C:\TD-Terminal_SECURE\$data\~cmds\StandardCmds\ChangeUser.bat $default $default
call C:\TD-Terminal_SECURE\$data\~cmds\StandardCmds\ChangeUser.bat $Administrator $Administrator
timeout /t 1 /nobreak > nul
echo Usernames reverted with 0 error(s).
goto :UCU2

:changedefault
set /p newuser1="Enter the new username for $default: "
timeout /t 1 /nobreak > nul
set /p passuser1="Enter the password of $default: "
echo Verifying. . .
timeout /t 2 /nobreak > nul
if "%passuser1%"==%defaultpswd% (
    echo Verified!
    timeout /t 2 /nobreak > nul
    echo Changing username. . .
    call C:\TD-Terminal_SECURE\$data\~cmds\StandardCmds\ChangeUser.bat $default %newuser1%
    echo Username changed with 0 error(s)
    goto :UCU2
)
:changeAdministrator
set /p newuser2="Enter the new username for $Administratrator: "
timeout /t 1 /nobreak > nul
set /p passuser2="Enter the password of $Administrator: "
echo Verifying. . .
timeout /t 2 /nobreak > nul
if "%passuser2%"==%adpw% (
    echo Verified!
    timeout /t 2 /nobreak > nul
    echo Changing username. . .
    call C:\TD-Terminal_SECURE\$data\~cmds\StandardCmds\ChangeUser.bat $Administrator %newuser2%
    echo Username changed with 0 error(s)
    goto :UCU2
)


:ElevateUser
cls
echo User requested permission elevation.
set /p VerifyAdmin="Password for %AdminName%: "
echo Verifying. . .
timeout /t 3 /nobreak > nul
if "%VerifyAdmin%"==%adpw% (
    echo Verified!
    echo Adding changes. . .
    reg add HKCU\Software\TD-Secure\Users\$default /v ElevatedAccess /t REG_DWORD /d 1 /f
    set TempAdmin=1
    set displayuser="~/Users/$Administrator> "
    goto :start
) else (
    echo Invalid password.
    cls
    goto :start
)

:ElevateSys
cls
echo User requested permission elevation.
set /p VerifySys="Password for $SYSTEM: "
echo Verifying. . .
timeout /t 4 /nobreak > nul
if "%VerifySys%"==%syspsw% (
    echo Verified!
    echo Adding changed. . .
    reg add HKCU\Software\TD-Secure\Users\$Administrator /v SystemAccess /t REG_DWORD /d 1 /f
    set TempSys=1
    set displayuser="~/$SYSTEM> "
    goto :start
) else (
    echo Invalid password.
    cls
    goto :start
)

:elevatehelp
echo 'elevate' used with invalid syntax.
echo Proper syntax:
echo 'elevate type:TYPE'
echo.
echo TYPE       Elevation Level
echo ---------------------------------------
echo SYS        $SYSTEM
echo admin      Administrator
goto :cmd

:shutdownseqence
cls
call C:\TD-Terminal_SECURE\$data\~cmds\ElevatedCmds\RevertTempChanges.bat
exit


:winscape
cls
echo Escaping to command promt. . .
timeout /t 1 /nobreak > nul
echo.
cmd /k