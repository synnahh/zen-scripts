@echo off
REM WIZ Light Automation Examples
REM Save this as a separate script with the routine you want to run

REM ============================================================================
REM EXAMPLE 1: MORNING ROUTINE
REM ============================================================================
REM Gradually brighten all lights in the morning

@echo off
REM :morning_routine
REM echo [%date% %time%] Starting morning routine...
REM
REM REM Start dim
REM call light1_control.bat brightness 10 >nul 2>&1
REM call light2_control.bat brightness 10 >nul 2>&1
REM call light3_control.bat brightness 10 >nul 2>&1
REM call light4_control.bat brightness 10 >nul 2>&1
REM echo All lights set to 10%% brightness
REM timeout /t 120 /nobreak
REM
REM REM Medium brightness
REM call light1_control.bat brightness 40 >nul 2>&1
REM call light2_control.bat brightness 40 >nul 2>&1
REM call light3_control.bat brightness 40 >nul 2>&1
REM call light4_control.bat brightness 40 >nul 2>&1
REM echo All lights set to 40%% brightness
REM timeout /t 120 /nobreak
REM
REM REM Full brightness
REM call light1_control.bat brightness 100 >nul 2>&1
REM call light2_control.bat brightness 100 >nul 2>&1
REM call light3_control.bat brightness 100 >nul 2>&1
REM call light4_control.bat brightness 100 >nul 2>&1
REM echo All lights set to 100%% brightness
REM echo Morning routine complete!

REM ============================================================================
REM EXAMPLE 2: EVENING ROUTINE
REM ============================================================================
REM Dim lights for evening

@echo off
REM :evening_routine
REM echo [%date% %time%] Starting evening routine...
REM call light1_control.bat brightness 50 >nul 2>&1
REM call light2_control.bat brightness 50 >nul 2>&1
REM call light3_control.bat brightness 50 >nul 2>&1
REM call light4_control.bat brightness 50 >nul 2>&1
REM echo All lights dimmed to 50%%
REM echo Evening routine complete!

REM ============================================================================
REM EXAMPLE 3: BEDTIME ROUTINE
REM ============================================================================
REM Turn off all lights gradually

@echo off
REM :bedtime_routine
REM echo [%date% %time%] Starting bedtime routine...
REM
REM REM Very dim
REM call light1_control.bat brightness 20 >nul 2>&1
REM call light2_control.bat brightness 20 >nul 2>&1
REM call light3_control.bat brightness 20 >nul 2>&1
REM call light4_control.bat brightness 20 >nul 2>&1
REM echo All lights set to 20%% brightness
REM timeout /t 60 /nobreak
REM
REM REM Ultra dim
REM call light1_control.bat brightness 5 >nul 2>&1
REM call light2_control.bat brightness 5 >nul 2>&1
REM call light3_control.bat brightness 5 >nul 2>&1
REM call light4_control.bat brightness 5 >nul 2>&1
REM echo All lights set to 5%% brightness
REM timeout /t 60 /nobreak
REM
REM REM Off
REM call light1_control.bat off >nul 2>&1
REM call light2_control.bat off >nul 2>&1
REM call light3_control.bat off >nul 2>&1
REM call light4_control.bat off >nul 2>&1
REM echo All lights turned off
REM echo Bedtime routine complete!

REM ============================================================================
REM EXAMPLE 4: MOVIE MODE
REM ============================================================================
REM Dim all lights for movie watching

@echo off
REM :movie_mode
REM echo [%date% %time%] Starting movie mode...
REM call light1_control.bat brightness 0 >nul 2>&1
REM call light2_control.bat brightness 0 >nul 2>&1
REM call light3_control.bat off >nul 2>&1
REM call light4_control.bat off >nul 2>&1
REM echo Movie mode: All lights off!

REM ============================================================================
REM EXAMPLE 5: PARTY MODE
REM ============================================================================
REM Color changing lights (requires color-capable lights)

@echo off
REM :party_mode
REM echo [%date% %time%] Starting party mode...
REM :party_loop
REM call light1_control.bat color FF0000 >nul 2>&1
REM call light2_control.bat color 00FF00 >nul 2>&1
REM call light3_control.bat color 0000FF >nul 2>&1
REM call light4_control.bat color FFFF00 >nul 2>&1
REM timeout /t 1 /nobreak >nul
REM call light1_control.bat color 00FF00 >nul 2>&1
REM call light2_control.bat color 0000FF >nul 2>&1
REM call light3_control.bat color FFFF00 >nul 2>&1
REM call light4_control.bat color FF0000 >nul 2>&1
REM timeout /t 1 /nobreak >nul
REM goto party_loop

REM ============================================================================
REM EXAMPLE 6: WORK MODE
REM ============================================================================
REM Bright lights for focus and productivity

@echo off
REM :work_mode
REM echo [%date% %time%] Starting work mode...
REM call light1_control.bat brightness 100 >nul 2>&1
REM call light2_control.bat brightness 100 >nul 2>&1
REM call light3_control.bat brightness 100 >nul 2>&1
REM call light4_control.bat brightness 100 >nul 2>&1
REM echo Work mode: All lights at 100%%

REM ============================================================================
REM INSTRUCTIONS
REM ============================================================================
REM
REM To use these automation routines:
REM
REM 1. Create a new batch file (e.g., my_morning_routine.bat)
REM 2. Copy one of the example routines (uncomment the REM statements)
REM 3. Run the batch file or schedule it using Task Scheduler
REM
REM TO SCHEDULE WITH TASK SCHEDULER:
REM
REM a) Open Task Scheduler (search for "Task Scheduler")
REM b) Click "Create Basic Task"
REM c) Name: "Morning Light Routine"
REM d) Trigger: Daily at 7:00 AM
REM e) Action: Start a program
REM f) Program: my_morning_routine.bat
REM g) Click OK
REM
REM EXAMPLE: Create morning_routine.bat with this content:
REM
REM @echo off
REM call light1_control.bat brightness 30 >nul 2>&1
REM call light2_control.bat brightness 30 >nul 2>&1
REM call light3_control.bat brightness 30 >nul 2>&1
REM call light4_control.bat brightness 30 >nul 2>&1
REM timeout /t 120 /nobreak >nul
REM call light1_control.bat brightness 75 >nul 2>&1
REM call light2_control.bat brightness 75 >nul 2>&1
REM call light3_control.bat brightness 75 >nul 2>&1
REM call light4_control.bat brightness 75 >nul 2>&1
REM
REM THEN schedule morning_routine.bat to run at your desired time
REM
REM ============================================================================

echo.
echo This file contains examples for creating automated light routines.
echo Please read the comments for detailed instructions on how to use them.
echo.
echo To create your own routine:
echo   1. Create a new .bat file
echo   2. Copy one of the examples (remove REM statements)
echo   3. Edit it to suit your needs
echo   4. Schedule it with Windows Task Scheduler
echo.
pause
