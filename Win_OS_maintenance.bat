@echo off

:check_Permissions
echo Administrative permissions required. Detecting permissions ...
echo.
net session >nul 2>&1
if %errorLevel% == 0 (
    echo Success: Administrative permissions confirmed.
	goto start
) else (
    echo Failure: Current permissions inadequate.
	goto end_PermFail
)

:start
title Starting health check
echo.
echo Starting health check
echo.
goto dism

:dism
title Fixing OS image
echo ------------------------------
echo Fixing OS image ...
echo.
DISM /Online /Cleanup-image /Restorehealth
echo.
goto sfc

:sfc
echo.
title Fixing File system
echo ------------------------------
echo Fixing File system ...
echo.
sfc /scannow
echo.
goto end

:end
title Done
echo ------------------------------
echo Script ended successfully.
echo Press any key to exit
pause >nul
exit

:end_PermFail
title Error - Insufficient Permissions
echo ------------------------------
echo Error - Insufficient Permissions. Run the script as administrator.
echo Press any key to exit
pause >nul
exit