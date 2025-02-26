@echo off
echo Starting local preview server for Zervi website...

rem Change to the zervi-website directory
cd /d "C:\Users\Archie\Desktop\Coding Projects\zervi-website"

echo.
echo Website will be available at: http://localhost:8000
echo.
echo Press Ctrl+C to stop the server when finished.
echo.

rem Start a simple HTTP server using Python
python -m http.server 8000

pause
