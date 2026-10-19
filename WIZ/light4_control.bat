@echo off
REM WIZ Light 4 Control (192.168.0.140)
REM Usage: light4_control.bat [on|off|brightness|color] [brightness 0-100] [color hex]

setlocal enabledelayedexpansion
set IP=192.168.0.140
set PORT=38899
set ACTION=%1
set BRIGHTNESS=%2
set COLOR=%3

if "%ACTION%"=="" (
    echo Usage: light4_control.bat [on^|off^|brightness^|color] [args]
    echo   on              - Turn light on
    echo   off             - Turn light off
    echo   brightness NUM  - Set brightness 0-100
    echo   color HEX       - Set color ^(e.g. FF0000 for red^)
    exit /b 1
)

if /i "%ACTION%"=="on" (
    echo Turning Light 4 ON...
    powershell -Command "Invoke-WebRequest -Uri 'http://%IP%:%PORT%/api/rpc' -Method POST -Body '{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"setPilot\",\"params\":{\"state\":true}}' -ContentType 'application/json' -ErrorAction SilentlyContinue" >nul 2>&1
    echo Light 4 is now ON
    goto :eof
)

if /i "%ACTION%"=="off" (
    echo Turning Light 4 OFF...
    powershell -Command "Invoke-WebRequest -Uri 'http://%IP%:%PORT%/api/rpc' -Method POST -Body '{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"setPilot\",\"params\":{\"state\":false}}' -ContentType 'application/json' -ErrorAction SilentlyContinue" >nul 2>&1
    echo Light 4 is now OFF
    goto :eof
)

if /i "%ACTION%"=="brightness" (
    if "%BRIGHTNESS%"=="" (
        echo Error: Please specify brightness level 0-100
        exit /b 1
    )
    echo Setting Light 4 brightness to %BRIGHTNESS%%%...
    powershell -Command "Invoke-WebRequest -Uri 'http://%IP%:%PORT%/api/rpc' -Method POST -Body '{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"setPilot\",\"params\":{\"state\":true,\"brightness\":%BRIGHTNESS%}}' -ContentType 'application/json' -ErrorAction SilentlyContinue" >nul 2>&1
    echo Light 4 brightness set to %BRIGHTNESS%%%
    goto :eof
)

if /i "%ACTION%"=="color" (
    if "%COLOR%"=="" (
        echo Error: Please specify color in hex format ^(e.g., FF0000^)
        exit /b 1
    )
    echo Setting Light 4 color to %COLOR%...
    powershell -Command "Invoke-WebRequest -Uri 'http://%IP%:%PORT%/api/rpc' -Method POST -Body '{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"setPilot\",\"params\":{\"state\":true,\"c\":{\"r\":!COLOR:~0,2!,\"g\":!COLOR:~2,2!,\"b\":!COLOR:~4,2!}}}' -ContentType 'application/json' -ErrorAction SilentlyContinue" >nul 2>&1
    echo Light 4 color set to %COLOR%
    goto :eof
)

echo Invalid action: %ACTION%
exit /b 1
