@echo off
echo ========================================
echo VoiceBridge Frontend Startup
echo ========================================
echo.

REM Check if Node.js is installed
node --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Node.js not found!
    echo.
    echo Please install Node.js:
    echo Download from: https://nodejs.org/
    echo Choose LTS version (recommended)
    echo.
    pause
    exit /b 1
)

echo [1/3] Node.js found!
node --version
echo.

REM Go to frontend directory
cd frontend

REM Check if node_modules exists
if not exist node_modules (
    echo [2/3] Installing dependencies...
    echo This may take a few minutes...
    echo.
    npm install
) else (
    echo [2/3] Dependencies already installed
)

echo.
echo [3/3] Starting development server...
echo.
echo ========================================
echo Frontend will open at: http://localhost:5173
echo.
echo Press Ctrl+C to stop the server
echo ========================================
echo.

npm run dev
