# 📞 VoiceBridge Setup Guide

Complete step-by-step setup for your real-time call translation system.

## Prerequisites

- ✅ Python 3.12+ installed
- ✅ Twilio account (free trial works!)
- ✅ OpenAI API key
- ✅ Google Cloud account (optional, for better TTS)
- ✅ ngrok installed

## Step 1: Twilio Account Setup (5 minutes)

### 1.1 Create Twilio Account
```
1. Go to https://www.twilio.com/try-twilio
2. Sign up for free trial
3. Verify your phone number
4. You get $15 free credit!
```

### 1.2 Get Phone Number
```
1. Go to Phone Numbers → Manage → Buy a number
2. Select country (Pakistan +92 or US +1)
3. Check "Voice" capability
4. Buy number (uses $1-2 of credit)
```

### 1.3 Get API Credentials
```
1. Go to Console Dashboard
2. Copy:
   - Account SID (starts with AC...)
   - Auth Token (click "show" to reveal)
3. Save these - you'll need them!
```

## Step 2: OpenAI API Key (2 minutes)

```
1. Go to https://platform.openai.com/api-keys
2. Create new API key
3. Copy it (starts with sk-...)
4. Save securely - it won't show again!
```

## Step 3: Google Cloud Setup (Optional - 10 minutes)

For better Urdu/Punjabi voices:

```
1. Go to https://console.cloud.google.com
2. Create new project: "voicebridge"
3. Enable APIs:
   - Cloud Text-to-Speech API
   - Cloud Speech-to-Text API
4. Create Service Account:
   - IAM & Admin → Service Accounts
   - Create Account
   - Grant "Editor" role
   - Create JSON key
   - Download and save as credentials.json
```

## Step 4: Install Backend (5 minutes)

### 4.1 Clone and Navigate
```bash
cd backend
```

### 4.2 Create Virtual Environment
```bash
python -m venv venv

# Activate:
# Windows:
venv\Scripts\activate
# Mac/Linux:
source venv/bin/activate
```

### 4.3 Install Dependencies
```bash
pip install -r requirements.txt
```

### 4.4 Configure Environment
```bash
# Copy example env file
copy .env.example .env

# Edit .env with your values:
notepad .env
```

Fill in:
```env
TWILIO_ACCOUNT_SID=AC...your_sid
TWILIO_AUTH_TOKEN=...your_token
TWILIO_PHONE_NUMBER=+1234567890

OPENAI_API_KEY=sk-...your_key

# For Google TTS (optional):
GOOGLE_APPLICATION_CREDENTIALS=path/to/credentials.json

# This will be set after ngrok:
SERVER_URL=https://xxxx.ngrok.io
```

## Step 5: Test Locally (3 minutes)

### 5.1 Start Server
```bash
python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

You should see:
```
INFO:     Uvicorn running on http://0.0.0.0:8000
INFO:     Application startup complete.
```

### 5.2 Test API
Open browser: http://localhost:8000

You should see:
```json
{
  "service": "VoiceBridge Call Translation",
  "status": "active",
  "version": "1.0.0"
}
```

### 5.3 Check Demo Page
http://localhost:8000/demo

## Step 6: Expose with ngrok (2 minutes)

### 6.1 Install ngrok
```bash
# Download from https://ngrok.com/download
# Or use:
choco install ngrok  # Windows
brew install ngrok   # Mac
```

### 6.2 Start ngrok
```bash
ngrok http 8000
```

You'll see:
```
Forwarding   https://abc123.ngrok.io -> http://localhost:8000
```

### 6.3 Update .env
Copy the ngrok URL and update `.env`:
```env
SERVER_URL=https://abc123.ngrok.io
```

Restart your server!

## Step 7: Configure Twilio Webhook (3 minutes)

### 7.1 Set Webhook URL
```
1. Go to Twilio Console
2. Phone Numbers → Manage → Active Numbers
3. Click your phone number
4. Under "Voice & Fax":
   
   A CALL COMES IN:
   Webhook: https://abc123.ngrok.io/voice/incoming
   HTTP POST
   
5. Save!
```

## Step 8: TEST! 🎉

### Test 1: Call Your Number
```
1. Call your Twilio number from your phone
2. Listen to the greeting
3. Press 1 for English (or 2 for Urdu)
4. Start speaking!
5. You should hear your voice translated back
```

### Test 2: Web Demo
```
1. Open http://localhost:8000/demo
2. Enter two phone numbers
3. Select languages
4. Click "Start Translated Call"
```

## Troubleshooting

### "No audio heard"
```bash
# Check:
1. Is ngrok running?
2. Is the webhook URL correct in Twilio?
3. Check server logs for errors
4. Try restarting the server
```

### "Translation is slow"
```bash
# Solutions:
1. Use Google Translate instead of GPT
   - Set USE_GPT_TRANSLATION=false in .env
2. Reduce audio buffer time
3. Use faster Whisper model
```

### "Poor audio quality"
```bash
# Check:
1. Good phone signal?
2. Try Google TTS instead of default
3. Increase sample rate
```

### "Whisper errors"
```bash
# Install ffmpeg:
# Windows:
choco install ffmpeg
# Mac:
brew install ffmpeg
```

## Cost Estimate

### Per Minute (both sides):
- Twilio: $0.0085/min
- Whisper: $0.006/min  
- GPT-4: $0.02/min
- Google TTS: $0.016/min

**Total: ~$0.05/minute**

### For Testing (100 minutes):
- Twilio credit: $15 = ~300 minutes
- OpenAI credit: $5 = ~100 minutes

## Next Steps

### 1. Add More Languages
Edit `backend/app/config.py`:
```python
LANGUAGE_NAMES = {
    "sd": "Sindhi / سنڌي",  # Add Sindhi
    "ps": "Pashto / پښتو",  # Add Pashto
}
```

### 2. Improve Translation
- Use GPT-4 for better quality
- Add conversation context
- Handle code-mixing better

### 3. Deploy to Production
```bash
# Use Railway, Heroku, or AWS:
1. Push code to GitHub
2. Connect to Railway
3. Add environment variables
4. Deploy!
```

### 4. Add Features
- Call recording
- Live transcripts
- SMS translation
- WhatsApp integration

## Support

- GitHub Issues: [your-repo]/issues
- Email: support@voicebridge.com
- Discord: https://discord.gg/voicebridge

## Architecture Diagram

```
┌─────────────┐
│   Caller    │
│  (English)  │
└──────┬──────┘
       │ calls
       ▼
┌─────────────┐
│   Twilio    │
│  Phone #    │
└──────┬──────┘
       │ webhook
       ▼
┌─────────────┐
│  Your API   │
│  (ngrok)    │
└──────┬──────┘
       │
  ┌────┴────┐
  │ FastAPI │
  └────┬────┘
       │
  ┌────┼────┐
  │    │    │
  ▼    ▼    ▼
[STT][GPT][TTS]
  │    │    │
  └────┴────┘
       │
       ▼
  Audio back
```

## Success Criteria

✅ Call your number
✅ Hear greeting in English
✅ Speak English
✅ Hear translation in Urdu
✅ Clear audio quality
✅ Less than 3 second delay

**If all checks pass - CONGRATULATIONS! 🎉**

Your real-time call translation system is working!

---

**Questions?** Open an issue or join our Discord!
