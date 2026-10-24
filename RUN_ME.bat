@echo off
echo ========================================
echo VoiceBridge Setup Script
echo ========================================
echo.

REM Check Python
python --version >nul 2>&1
if errorlevel 1 (
    echo ERROR: Python not found!
    echo Please install Python 3.12 from https://www.python.org/downloads/
    pause
    exit /b 1
)

echo [1/5] Python found!
echo.

REM Go to backend
cd backend

echo [2/5] Installing dependencies...
pip install -r requirements.txt

echo.
echo [3/5] Setting up environment file...
if not exist .env (
    copy .env.example .env
    echo.
    echo ========================================
    echo IMPORTANT: Edit .env file with your API keys!
    echo ========================================
    echo.
    echo You need to add:
    echo 1. TWILIO_ACCOUNT_SID
    echo 2. TWILIO_AUTH_TOKEN
    echo 3. TWILIO_PHONE_NUMBER
    echo 4. OPENAI_API_KEY
    echo 5. SERVER_URL (after starting ngrok)
    echo.
    echo Opening .env file in notepad...
    timeout /t 3
    notepad .env
    echo.
    echo After editing .env, press any key to continue...
    pause
)

echo.
echo [4/5] Testing system...
python test_system.py

echo.
echo [5/5] Starting server...
echo.
echo ========================================
echo Server will start on http://localhost:8000
echo.
echo NEXT STEPS:
echo 1. Open NEW terminal and run: ngrok http 8000
echo 2. Copy ngrok URL (https://xxx.ngrok.io)
echo 3. Update SERVER_URL in .env file
echo 4. Restart this script
echo 5. Configure Twilio webhook with ngrok URL
echo ========================================
echo.

python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
