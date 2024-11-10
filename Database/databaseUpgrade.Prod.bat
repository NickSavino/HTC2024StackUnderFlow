@echo off
REM Database upgrade batch script using SQLCMD with Azure Authentication

REM Variables passed from GitHub Actions
set SERVER_NAME=%SERVER_NAME%
set DATABASE_NAME=%DATABASE_NAME%
set USERNAME=%USERNAME%
set PASSWORD=%PASSWORD%
set SCRIPTS_DIR=%CD%\Database\Upgrade
set LOG_FILE=sql_scripts_log.txt

REM Clear the screen
cls

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
sqlcmd -S %SERVER_NAME% -U %USERNAME% -P %PASSWORD% -d master -i "%SCRIPTS_DIR%\1.CreateDatabase.sql" >> "%LOG_FILE%" 2>&1

REM Check for errors
if %errorlevel% neq 0 (
    echo ================================================
    echo Error: Failed to execute script 1.CreateDatabase.sql. Check the log file: %LOG_FILE%
    echo ================================================
    exit /b %errorlevel%
)

REM Process remaining SQL files
for %%f in ("%SCRIPTS_DIR%\2*.sql" "%SCRIPTS_DIR%\3*.sql" "%SCRIPTS_DIR%\4*.sql") do (
    echo ================================================
    echo Running script: %%~nxf
    echo ================================================
    sqlcmd -S %SERVER_NAME% -U %USERNAME% -P %PASSWORD% -d %DATABASE_NAME% -i "%%~f" >> "%LOG_FILE%" 2>&1

    REM Check for errors
    if %errorlevel% neq 0 (
        echo ================================================
        echo Error: Failed to execute script %%~nxf. Check the log file: %LOG_FILE%
        echo ================================================
        exit /b %errorlevel%
    )
)

echo ================================================
echo All scripts executed successfully!
echo ================================================
exit /b 0
