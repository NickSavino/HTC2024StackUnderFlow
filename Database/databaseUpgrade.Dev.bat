@echo off
REM Script to run SQL scripts sequentially using SQLCMD with Windows Authentication

REM Set database connection variables
set SERVER_NAME=LAPTOP-FR3RBO5B
set DATABASE_NAME=HTC_DB
set SCRIPTS_DIR=C:\Hackathon\HTC2024StackUnderFlow\Database\Upgrade
set LOG_FILE=sql_scripts_log.txt

REM Clear the screen
cls

REM Check if the scripts directory exists
if not exist "%SCRIPTS_DIR%" (
    echo ================================================
    echo Error: Scripts directory not found at "%SCRIPTS_DIR%"
    echo ================================================
    pause
    exit /b 1
)

REM Run the first script to create the database
echo ================================================
echo Running script: 1.CreateDatabase.sql
echo ================================================
sqlcmd -S %SERVER_NAME% -d master -E -i "%SCRIPTS_DIR%\1.CreateDatabase.sql" >> "%LOG_FILE%" 2>&1

REM Check for errors
if %errorlevel% neq 0 (
    echo ================================================
    echo Error: Failed to execute script 1.CreateDatabase.sql. Check the log file: %LOG_FILE%
    echo ================================================
    pause
    exit /b %errorlevel%
)

REM Process remaining SQL files in order
for %%f in ("%SCRIPTS_DIR%\2*.sql" "%SCRIPTS_DIR%\3*.sql" "%SCRIPTS_DIR%\4*.sql") do (
    echo ================================================
    echo Running script: %%~nxf
    echo ================================================
    sqlcmd -S %SERVER_NAME% -d HTC_DB -E -i "%%~f" >> "%LOG_FILE%" 2>&1

    REM Check for errors
    if %errorlevel% neq 0 (
        echo ================================================
        echo Error: Failed to execute script %%~nxf. Check the log file: %LOG_FILE%
        echo ================================================
        goto :error
    )
)

echo ================================================
echo All scripts executed successfully!
echo ================================================
pause
exit /b 0

:error
echo ================================================
echo Script execution halted due to an error. Check the log file: %LOG_FILE%
echo ================================================
pause
exit /b 1
