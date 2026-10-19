@echo off
REM WIZ Master Control Script - Central hub for all light controls

setlocal enabledelayedexpansion

:menu
cls
echo.
echo ================================================
echo   WIZ Smart Light Master Control Panel
echo ================================================
echo.
echo   1 - Turn ALL lights ON
echo   2 - Turn ALL lights OFF
echo   3 - Set ALL brightness
echo   4 - Set individual light
echo   5 - Test all lights
echo   6 - Color mode (Coming Soon)
echo   7 - Scenes (Coming Soon)
echo   0 - Exit
echo.
echo ================================================
set /p choice="Enter your choice (0-7): "

if "%choice%"=="1" goto all_on
if "%choice%"=="2" goto all_off
if "%choice%"=="3" goto all_brightness
if "%choice%"=="4" goto individual
if "%choice%"=="5" goto test
if "%choice%"=="0" goto end
cls
echo Invalid choice. Please try again.
timeout /t 2 /nobreak >nul
goto menu

:all_on
cls
echo.
echo Turning ALL lights ON...
call light1_control.bat on >nul 2>&1
call light2_control.bat on >nul 2>&1
call light3_control.bat on >nul 2>&1
call light4_control.bat on >nul 2>&1
echo All lights are now ON!
echo.
pause
goto menu

:all_off
cls
echo.
echo Turning ALL lights OFF...
call light1_control.bat off >nul 2>&1
call light2_control.bat off >nul 2>&1
call light3_control.bat off >nul 2>&1
call light4_control.bat off >nul 2>&1
echo All lights are now OFF!
echo.
pause
goto menu

:all_brightness
cls
echo.
set /p brightness="Enter brightness level (0-100): "
if %brightness% LSS 0 (
    echo Invalid brightness value. Must be 0-100.
    pause
    goto menu
)
if %brightness% GTR 100 (
    echo Invalid brightness value. Must be 0-100.
    pause
    goto menu
)
echo.
echo Setting all lights to %brightness%%%...
call light1_control.bat brightness %brightness% >nul 2>&1
call light2_control.bat brightness %brightness% >nul 2>&1
call light3_control.bat brightness %brightness% >nul 2>&1
call light4_control.bat brightness %brightness% >nul 2>&1
echo All lights brightness set to %brightness%%%!
echo.
pause
goto menu

:individual
cls
echo.
echo   1 - Light 1 (192.168.0.151)
echo   2 - Light 2 (192.168.0.208)
echo   3 - Light 3 (192.168.0.243)
echo   4 - Light 4 (192.168.0.140)
echo.
set /p light="Select light (1-4): "

if "%light%"=="1" goto light1_menu
if "%light%"=="2" goto light2_menu
if "%light%"=="3" goto light3_menu
if "%light%"=="4" goto light4_menu
goto individual

:light1_menu
cls
echo.
echo   Light 1 Control (192.168.0.151)
echo   1 - ON
echo   2 - OFF
echo   3 - Set Brightness
echo.
set /p action="Select action (1-3): "
if "%action%"=="1" call light1_control.bat on
if "%action%"=="2" call light1_control.bat off
if "%action%"=="3" (
    set /p bri="Enter brightness (0-100): "
    call light1_control.bat brightness !bri!
)
pause
goto menu

:light2_menu
cls
echo.
echo   Light 2 Control (192.168.0.208)
echo   1 - ON
echo   2 - OFF
echo   3 - Set Brightness
echo.
set /p action="Select action (1-3): "
if "%action%"=="1" call light2_control.bat on
if "%action%"=="2" call light2_control.bat off
if "%action%"=="3" (
    set /p bri="Enter brightness (0-100): "
    call light2_control.bat brightness !bri!
)
pause
goto menu

:light3_menu
cls
echo.
echo   Light 3 Control (192.168.0.243)
echo   1 - ON
echo   2 - OFF
echo   3 - Set Brightness
echo.
set /p action="Select action (1-3): "
if "%action%"=="1" call light3_control.bat on
if "%action%"=="2" call light3_control.bat off
if "%action%"=="3" (
    set /p bri="Enter brightness (0-100): "
    call light3_control.bat brightness !bri!
)
pause
goto menu

:light4_menu
cls
echo.
echo   Light 4 Control (192.168.0.140)
echo   1 - ON
echo   2 - OFF
echo   3 - Set Brightness
echo.
set /p action="Select action (1-3): "
if "%action%"=="1" call light4_control.bat on
if "%action%"=="2" call light4_control.bat off
if "%action%"=="3" (
    set /p bri="Enter brightness (0-100): "
    call light4_control.bat brightness !bri!
)
pause
goto menu

:test
cls
call test_all_lights.bat
goto menu

:end
cls
echo.
echo Exiting WIZ Master Control. Goodbye!
echo.
