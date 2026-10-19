@echo off
REM WIZ Lights Test Suite - Tests all 4 lights for connectivity and functionality

setlocal enabledelayedexpansion
set PORT=38899
set LIGHTS=4

echo.
echo ================================================
echo     WIZ Smart Light System - Test Suite
echo ================================================
echo.
echo Starting connectivity tests...
echo.

REM Test Light 1
echo [TEST 1] Light 1 (192.168.0.151)
echo   Testing connectivity...
powershell -Command "try { Invoke-WebRequest -Uri 'http://192.168.0.151:%PORT%/api/rpc' -Method POST -Body '{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"getPilot\",\"params\":{}}' -ContentType 'application/json' -TimeoutSec 2 -ErrorAction Stop | Out-Null; Write-Host '   [OK] Light 1 is reachable' -ForegroundColor Green } catch { Write-Host '   [FAIL] Light 1 is not responding' -ForegroundColor Red }"
echo   Testing ON command...
call light1_control.bat on >nul 2>&1
timeout /t 2 /nobreak >nul
echo   [CHECK] Light 1 should be ON now
echo   Testing brightness...
call light1_control.bat brightness 50 >nul 2>&1
echo   [CHECK] Light 1 brightness set to 50%%
echo.

REM Test Light 2
echo [TEST 2] Light 2 (192.168.0.208)
echo   Testing connectivity...
powershell -Command "try { Invoke-WebRequest -Uri 'http://192.168.0.208:%PORT%/api/rpc' -Method POST -Body '{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"getPilot\",\"params\":{}}' -ContentType 'application/json' -TimeoutSec 2 -ErrorAction Stop | Out-Null; Write-Host '   [OK] Light 2 is reachable' -ForegroundColor Green } catch { Write-Host '   [FAIL] Light 2 is not responding' -ForegroundColor Red }"
echo   Testing ON command...
call light2_control.bat on >nul 2>&1
timeout /t 2 /nobreak >nul
echo   [CHECK] Light 2 should be ON now
echo   Testing brightness...
call light2_control.bat brightness 50 >nul 2>&1
echo   [CHECK] Light 2 brightness set to 50%%
echo.

REM Test Light 3
echo [TEST 3] Light 3 (192.168.0.243)
echo   Testing connectivity...
powershell -Command "try { Invoke-WebRequest -Uri 'http://192.168.0.243:%PORT%/api/rpc' -Method POST -Body '{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"getPilot\",\"params\":{}}' -ContentType 'application/json' -TimeoutSec 2 -ErrorAction Stop | Out-Null; Write-Host '   [OK] Light 3 is reachable' -ForegroundColor Green } catch { Write-Host '   [FAIL] Light 3 is not responding' -ForegroundColor Red }"
echo   Testing ON command...
call light3_control.bat on >nul 2>&1
timeout /t 2 /nobreak >nul
echo   [CHECK] Light 3 should be ON now
echo   Testing brightness...
call light3_control.bat brightness 50 >nul 2>&1
echo   [CHECK] Light 3 brightness set to 50%%
echo.

REM Test Light 4
echo [TEST 4] Light 4 (192.168.0.140)
echo   Testing connectivity...
powershell -Command "try { Invoke-WebRequest -Uri 'http://192.168.0.140:%PORT%/api/rpc' -Method POST -Body '{\"jsonrpc\":\"2.0\",\"id\":1,\"method\":\"getPilot\",\"params\":{}}' -ContentType 'application/json' -TimeoutSec 2 -ErrorAction Stop | Out-Null; Write-Host '   [OK] Light 4 is reachable' -ForegroundColor Green } catch { Write-Host '   [FAIL] Light 4 is not responding' -ForegroundColor Red }"
echo   Testing ON command...
call light4_control.bat on >nul 2>&1
timeout /t 2 /nobreak >nul
echo   [CHECK] Light 4 should be ON now
echo   Testing brightness...
call light4_control.bat brightness 50 >nul 2>&1
echo   [CHECK] Light 4 brightness set to 50%%
echo.

echo ================================================
echo   All tests complete! Check your lights.
echo ================================================
echo.
pause
