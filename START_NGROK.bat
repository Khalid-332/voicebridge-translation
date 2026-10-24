@echo off
echo ========================================
echo Starting ngrok tunnel...
echo ========================================
echo.

REM Check if ngrok is installed
ngrok version >nul 2>&1
if errorlevel 1 (
    echo ERROR: ngrok not found!
    echo.
    echo Please install ngrok:
    echo 1. Download from: https://ngrok.com/download
    echo 2. Extract ngrok.exe
    echo 3. Add to PATH or run from ngrok folder
    echo.
    pause
    exit /b 1
)

echo Starting tunnel on port 8000...
echo.
echo Copy the HTTPS URL that appears below
echo Update it in backend/.env as SERVER_URL
echo.
echo Press Ctrl+C to stop
echo.

ngrok http 8000
