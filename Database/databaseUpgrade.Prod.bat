@echo off
REM Database upgrade batch script using SQLCMD with Azure Authentication

REM Variables passed from GitHub Actions
set SERVER_NAME=%SERVER_NAME%
set DATABASE_NAME=%DATABASE_NAME%
set USERNAME=%USERNAME%
set PASSWORD=%PASSWORD%
set SCRIPTS_DIR=%CD%\Database\Upgrade
set LOG_FILE=%SCRIPTS_DIR%\sql_scripts_log.txt

REM Clear the screen
cls

REM Validate environment variables
if "%SERVER_NAME%"=="" (
    echo Error: SERVER_NAME environment variable is not set.
    exit /b 1
)
if "%DATABASE_NAME%"=="" (
    echo Error: DATABASE_NAME environment variable is not set.
    exit /b 1
)
if "%USERNAME%"=="" (
    echo Error: USERNAME environment variable is not set.
    exit /b 1
)
if "%PASSWORD%"=="" (
    echo Error: PASSWORD environment variable is not set.
    exit /b 1
)

REM Check if the scripts directory exists
if not exist "%SCRIPTS_DIR%" (
    echo ================================================
    echo Error: Scripts directory not found at "%SCRIPTS_DIR%"
    echo ================================================
    exit /b 1
)

REM Run the first script to create the database
echo ================================================
echo Running script: 1.CreateDatabase.sql
echo ================================================
sqlcmd -S %SERVER_NAME% -U %USERNAME% -P %PASSWORD% -d master -i "%SCRIPTS_DIR%\1.CreateDatabase.sql" -t 120 >> "%LOG_FILE%" 2>&1

REM Check for errors
if %errorlevel% neq 0 (
    echo ================================================
    echo Error: Failed to execute script 1.CreateDatabase.sql. Check the log file: %LOG_FILE%
    echo ================================================
    exit /b %errorlevel%
)

REM Process remaining SQL files
set PROCESSED_SCRIPTS=0
for %%f in ("%SCRIPTS_DIR%\2*.sql" "%SCRIPTS_DIR%\3*.sql" "%SCRIPTS_DIR%\4*.sql") do (
    set /a PROCESSED_SCRIPTS+=1
    echo ================================================
    echo Running script: %%~nxf
    echo ================================================
    sqlcmd -S %SERVER_NAME% -U %USERNAME% -P %PASSWORD% -d %DATABASE_NAME% -i "%%~f" -t 120 >> "%LOG_FILE%" 2>&1

    REM Check for errors
    if %errorlevel% neq 0 (
        echo ================================================
        echo Error: Failed to execute script %%~nxf. Check the log file: %LOG_FILE%
        echo ================================================
        exit /b %errorlevel%
    )
)

if %PROCESSED_SCRIPTS%==0 (
    echo ================================================
    echo Error: No scripts found to process in the Upgrade directory.
    echo ================================================
    exit /b 1
)

echo ================================================
echo All scripts executed successfully!
echo ================================================
exit /b 0
