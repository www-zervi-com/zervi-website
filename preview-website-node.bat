@echo off
echo Starting local preview server for Zervi website using Node.js...

rem Change to the zervi-website directory
cd /d "C:\Users\Archie\Desktop\Coding Projects\zervi-website"

echo.
echo Checking if http-server is installed...
npx http-server -v >nul 2>&1
if %errorlevel% neq 0 (
    echo Installing http-server...
    npm install -g http-server
)

echo.
echo Website will be available at: http://localhost:8080
echo.
echo Press Ctrl+C to stop the server when finished.
echo.

rem Start the HTTP server
npx http-server -o

pause
