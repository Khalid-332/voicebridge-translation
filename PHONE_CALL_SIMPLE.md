# 📞 Phone Call Setup - Simple Guide

## ✅ Your Backend Already Supports Phone Calls!

The code is ready. You just need to configure Twilio.

---

## 🎯 What You Need

### 1. Twilio Account (Phone Service)
- **Cost:** $15 free credit when you sign up
- **Phone number:** ~$1/month
- **Website:** https://www.twilio.com/try-twilio

### 2. OpenAI API Key (For Translation)
- **Cost:** $5-10 credit
- **Website:** https://platform.openai.com/signup

### 3. ngrok (To expose your local server)
- **Cost:** Free
- **Website:** https://ngrok.com/download

---

## 🚀 Quick Setup (15 Minutes)

### Step 1: Create Twilio Account

1. Go to: https://www.twilio.com/try-twilio
2. Sign up with email
3. Verify phone number
4. **You get $15 free credit!** ✅

### Step 2: Buy Twilio Phone Number

1. In Twilio Console, go to: **Phone Numbers → Buy a Number**
2. Select your country (Pakistan: +92, US: +1)
3. Check "Voice" capability
4. Click "Search" → Pick any number
5. Click "Buy" (~$1)

### Step 3: Get Twilio Credentials

1. Go to Twilio Console Dashboard
2. Copy these:
   - **Account SID** (starts with "AC...")
   - **Auth Token** (click "show")
   - **Phone Number** (format: +1234567890)

**SAVE THESE!** You'll need them next.

### Step 4: Get OpenAI API Key

1. Go to: https://platform.openai.com/signup
2. Sign up → Verify email
3. Go to: https://platform.openai.com/settings/organization/billing
4. Add payment method → Add $5-10 credits
5. Go to: https://platform.openai.com/api-keys
6. Click "Create new secret key"
7. Copy it (starts with "sk-...")

**SAVE THIS TOO!**

### Step 5: Update Your .env File

1. Open file: `backend\.env`
2. Replace with your real values:

```env
# Twilio (from Step 3)
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_auth_token_here
TWILIO_PHONE_NUMBER=+1234567890

# OpenAI (from Step 4)
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxx

# Server
HOST=0.0.0.0
PORT=8000
SERVER_URL=https://your-ngrok-url.ngrok-free.app
```

**Don't fill SERVER_URL yet - we'll get it in Step 7!**

### Step 6: Install ngrok

1. Download: https://ngrok.com/download
2. Extract ngrok.exe
3. Optional: Sign up for free account at https://dashboard.ngrok.com/signup
4. Get auth token from: https://dashboard.ngrok.com/get-started/your-authtoken
5. Run in PowerShell:

```powershell
C:\path\to\ngrok.exe config add-authtoken YOUR_AUTH_TOKEN
```

### Step 7: Start ngrok

Open a **NEW PowerShell window** and run:

```powershell
C:\path\to\ngrok.exe http 8000
```

You'll see something like:
```
Forwarding   https://abc123.ngrok-free.app -> http://localhost:8000
```

**COPY THE HTTPS URL** (e.g., https://abc123.ngrok-free.app)

### Step 8: Update .env with ngrok URL

1. Open `backend\.env` again
2. Update SERVER_URL:

```env
SERVER_URL=https://abc123.ngrok-free.app
```

Save the file.

### Step 9: Restart Backend

Stop backend (Ctrl+C) and restart:

```powershell
cd backend
python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### Step 10: Configure Twilio Webhook

1. Go to Twilio Console: https://console.twilio.com/
2. Click **Phone Numbers → Manage → Active Numbers**
3. Click on your phone number
4. Scroll to **Voice Configuration**
5. Under "A CALL COMES IN":
   - Select: **Webhook**
   - Enter: `https://your-ngrok-url.ngrok-free.app/voice/incoming`
   - Method: **HTTP POST**
6. Click **Save**

---

## ✅ DONE! Now Test It

### Call Your Twilio Number

1. From your phone, call the Twilio number
2. You should hear: "Welcome to Voice Bridge"
3. System will ask you to select language:
   - Press 1 for English
   - Press 2 for Urdu
   - Press 3 for Punjabi
   - Press 4 for Arabic
4. Start speaking!
5. System will translate in real-time!

---

## 🎯 How It Works

```
Your Phone → Twilio → ngrok → Your Backend → Translation → Voice Output
```

1. You call Twilio number
2. Twilio sends audio to your backend (via ngrok)
3. Backend transcribes audio (Whisper)
4. Backend translates (GPT-4)
5. Backend sends translated voice back
6. You hear translation!

---

## 📊 Costs

### Setup (One-time):
- Twilio sign up: **FREE** ($15 credit)
- Twilio phone number: **~$1** (one-time)
- OpenAI credit: **$5-10**

**Total: ~$6-11 to get started**

### Monthly:
- Twilio phone number: **~$1/month**
- Twilio calls: **~$0.02/minute**
- OpenAI usage: **~$0.01-0.05 per translation**

**Example:** 100 minutes of calls = ~$7/month

---

## 🐛 Troubleshooting

### "Call failed" or no answer:
- Check ngrok is running
- Check backend is running
- Verify webhook URL is correct

### "Can't hear translation":
- Check OpenAI API key is valid
- Check you have credits in OpenAI account
- Look at backend terminal for errors

### ngrok URL changed:
- ngrok free tier gives new URL each restart
- Update .env and Twilio webhook with new URL

---

## 🎉 Two-Person Call Example

### Setup:
- Person A in Pakistan (speaks Urdu)
- Person B in China (speaks Chinese)

### How They Use:

**Both people call the same Twilio number:**

1. Person A calls → Selects Urdu (Press 2)
2. Person B calls → Selects Chinese (different Twilio number or conference)

**OR use conference call feature (advanced setup)**

---

## 💡 Important Notes

### For Testing:
- Use your own phone
- Call the Twilio number
- Test with common phrases first

### For Production:
- Need multiple Twilio numbers for multiple simultaneous calls
- Consider upgrading ngrok to paid plan (fixed URL)
- Or deploy to cloud (Railway, Heroku, AWS)

---

## 🚀 Next Steps

### Once Phone Calls Work:

1. **Test with multiple people**
2. **Add more languages to IVR menu**
3. **Enable call recording** (see backend code)
4. **Add conference calls** (Twilio feature)
5. **Deploy to cloud** (permanent solution)

---

## ✅ Summary

**What you need:**
1. ✅ Twilio account + phone number (~$1)
2. ✅ OpenAI API key ($5-10 credit)
3. ✅ ngrok running (free)
4. ✅ Backend with correct .env settings
5. ✅ Twilio webhook configured

**Then:**
- Call Twilio number from any phone
- Real-time voice translation works!
- People in different countries can talk!

---

**Total setup time: ~15 minutes**
**Total cost to start: ~$6-11**

---

## 📞 Ready?

Follow steps 1-10 above, then:

**Call your Twilio number and test!** 🎉

---

## 🆘 Need Help?

Check backend logs:
```powershell
# In backend terminal, you'll see:
INFO: Incoming call received
INFO: Language selected: ur
INFO: Translating: [text]
```

If errors, read the error messages - they tell you what's wrong!

---

**Your backend code is already ready. Just need Twilio + OpenAI + ngrok setup!**
