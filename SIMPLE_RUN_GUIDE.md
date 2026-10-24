# 🎯 Simple Run Guide - Urdu/English

## Bilkul Simple 3 Steps!

### Step 1: API Keys Banayein (5 min)

#### Twilio (Free):
```
1. https://www.twilio.com/try-twilio pe jao
2. Sign up karein
3. Phone number buy karein ($1)
4. Copy karein:
   - Account SID (ACxxxxxxxxx)
   - Auth Token
   - Phone Number (+1234567890)
```

#### OpenAI:
```
1. https://platform.openai.com/api-keys pe jao
2. "Create new secret key" click
3. Copy key (sk-xxxxxxxxx)
```

### Step 2: Run Script (3 min)

```cmd
# Double-click this file:
RUN_ME.bat

# Script automatically:
- Python check karega
- Dependencies install karega
- .env file open karega
- Server start karega
```

### Step 3: ngrok Start Karein (2 min)

```cmd
# New terminal/cmd window open karein
# Double-click:
START_NGROK.bat

# Ya manually:
ngrok http 8000

# Jo URL mile (like https://abc123.ngrok.io)
# Use backend/.env mein dalein:
SERVER_URL=https://abc123.ngrok.io
```

### Step 4: Twilio Configure (3 min)

```
1. Twilio Console pe jao
2. Phone Numbers → Manage → Active Numbers
3. Apna number click karein
4. "Voice Configuration" section mein:
   
   A CALL COMES IN:
   Webhook: https://abc123.ngrok.io/voice/incoming
   HTTP POST
   
5. Save karein
```

### Step 5: TEST! 🎉

```
1. Apne Twilio number ko call karein
2. Press 1 for English
3. Baat karein!
4. Translation sunein!
```

---

## 🐛 Problems?

### "Python not found"
```
Download: https://www.python.org/downloads/
Install karte waqt "Add to PATH" check karein
```

### "ngrok not found"
```
Download: https://ngrok.com/download
Extract karein
Terminal mein: cd path/to/ngrok
Phir: ngrok http 8000
```

### "No module named 'fastapi'"
```
cd backend
pip install -r requirements.txt
```

### "No audio heard"
```
Check:
1. ngrok running?
2. .env mein SERVER_URL correct?
3. Twilio webhook URL correct?
4. Server running (port 8000)?
```

---

## 📱 Test Commands

```powershell
# Test if server is running:
curl http://localhost:8000

# Should return:
# {"service": "VoiceBridge Call Translation", "status": "active"}

# Test system components:
cd backend
python test_system.py
```

---

## 🎯 Quick Reference

### Required Files:
- `backend/.env` - Your API keys
- Backend server - Running on port 8000
- ngrok - Exposing server to internet

### URLs:
- Local server: http://localhost:8000
- Demo page: http://localhost:8000/demo
- ngrok URL: https://xxxx.ngrok.io (changes each time)

### Twilio Setup:
- Console: https://console.twilio.com
- Your number → Voice Configuration
- Webhook: `https://your-ngrok-url.ngrok.io/voice/incoming`

---

## ✅ Success Checklist

- [ ] Python 3.12+ installed
- [ ] Twilio account created
- [ ] Phone number purchased
- [ ] OpenAI API key obtained
- [ ] Dependencies installed (`pip install -r requirements.txt`)
- [ ] `.env` file configured with all keys
- [ ] Server running (port 8000)
- [ ] ngrok running and URL copied
- [ ] SERVER_URL updated in `.env`
- [ ] Twilio webhook configured
- [ ] Called number and heard greeting
- [ ] Spoke and heard translation

**All checked? You're ready! 🚀**

---

## 💡 Pro Tips

1. **Keep ngrok running** - Don't close the terminal
2. **Restart server after .env changes** - Ctrl+C and run again
3. **Use headphones** - Better audio quality
4. **Speak clearly** - Better transcription
5. **Check logs** - Errors show in server terminal

---

## 🆘 Still Stuck?

1. Read full setup: [SETUP_GUIDE.md](SETUP_GUIDE.md)
2. Check logs in terminal
3. Run: `python backend/test_system.py`
4. Check all URLs are correct
5. Restart everything (server + ngrok)

---

**Simple hai! Just follow steps. Kaam karega! 🎉**
