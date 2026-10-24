# ⚡ Quick Start - 10 Minutes to Working System

Fastest way to get VoiceBridge running for testing.

## Prerequisites
- Python 3.12+ ✅
- Twilio account (free trial) ✅
- OpenAI API key ✅

## Step-by-Step (10 minutes)

### 1. Setup Accounts (5 min)

**Twilio:**
```
1. Sign up: https://www.twilio.com/try-twilio
2. Get a phone number (Voice enabled)
3. Copy: Account SID + Auth Token
```

**OpenAI:**
```
1. Get API key: https://platform.openai.com/api-keys
2. Copy the key (starts with sk-)
```

### 2. Install & Configure (3 min)

```bash
# Navigate to backend
cd backend

# Install
pip install -r requirements.txt

# Configure
copy .env.example .env
notepad .env
```

Add your keys to `.env`:
```env
TWILIO_ACCOUNT_SID=ACxxxxxxxx
TWILIO_AUTH_TOKEN=your_token
TWILIO_PHONE_NUMBER=+1234567890
OPENAI_API_KEY=sk-xxxxxxxx
SERVER_URL=https://will-update-this.ngrok.io
```

### 3. Run Server (1 min)

```bash
# Terminal 1: Start backend
python -m uvicorn app.main:app --reload

# Terminal 2: Expose with ngrok
ngrok http 8000
```

Copy ngrok URL (like `https://abc123.ngrok.io`) and update `.env`

Restart backend!

### 4. Configure Twilio (1 min)

```
1. Twilio Console → Phone Numbers → Your Number
2. Voice Configuration:
   Webhook: https://abc123.ngrok.io/voice/incoming
   HTTP POST
3. Save
```

### 5. TEST! 🎉

**Call your Twilio number:**
- Press 1 for English
- Speak: "Hello, how are you?"
- Hear it in Urdu!

## Troubleshooting

**No audio?**
```bash
# Check logs:
# Is ngrok running?
# Is webhook correct?
```

**Errors?**
```bash
# Install ffmpeg:
choco install ffmpeg  # Windows
brew install ffmpeg   # Mac
```

## What's Next?

- Read full [SETUP_GUIDE.md](SETUP_GUIDE.md)
- Test with two phones
- Add more languages
- Deploy to production

## Support

Open an issue if stuck!

---

**Expected result:** Call → Speak English → Hear Urdu translation in 2-3 seconds!
