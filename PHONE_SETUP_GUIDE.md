# Phone Call Setup Guide

This guide will help you enable real phone calls for your VoiceBridge translation system.

## Prerequisites Checklist
- [ ] Credit card (for Twilio and OpenAI accounts)
- [ ] $20-30 budget (Twilio $15 free + top-up, OpenAI $5-10)
- [ ] Backend and frontend already running locally

## Step 1: Create Twilio Account (15 minutes)

### 1.1 Sign Up
1. Go to: https://www.twilio.com/try-twilio
2. Fill in your details:
   - Email
   - Password
   - Phone number (for verification)
3. Verify your email and phone number

### 1.2 Get Free Trial Credits
- You'll get **$15 free credit** automatically
- This is enough for testing (covers ~150 minutes of calls)

### 1.3 Buy a Phone Number
1. In Twilio Console, go to: **Phone Numbers → Buy a Number**
2. Select your country (Pakistan: +92, US: +1, etc.)
3. Check "Voice" capability
4. Click "Search"
5. Choose a number and click "Buy" (~$1/month)
6. Confirm purchase

### 1.4 Get Your Credentials
1. Go to Twilio Console Dashboard: https://console.twilio.com/
2. Find and copy these values:
   - **Account SID** (starts with "AC...")
   - **Auth Token** (click "show" to reveal)
   - **Phone Number** (the one you just bought, format: +1234567890)

**SAVE THESE SAFELY** - you'll need them in Step 4

---

## Step 2: Get OpenAI API Key (10 minutes)

### 2.1 Create Account
1. Go to: https://platform.openai.com/signup
2. Sign up with email or Google account
3. Verify your email

### 2.2 Add Credits
1. Go to: https://platform.openai.com/settings/organization/billing
2. Click "Add payment method"
3. Add credit card
4. Add **$5-10 credits** (enough for several hours of translation)

### 2.3 Create API Key
1. Go to: https://platform.openai.com/api-keys
2. Click "Create new secret key"
3. Name it: "VoiceBridge Translation"
4. Copy the key (starts with "sk-...")
5. **SAVE IT IMMEDIATELY** - you can't see it again!

---

## Step 3: Install and Run ngrok (5 minutes)

ngrok creates a public URL for your local server so Twilio can reach it.

### 3.1 Download ngrok
1. Go to: https://ngrok.com/download
2. Download Windows version
3. Extract the ZIP file
4. Move `ngrok.exe` to: `C:\ngrok\ngrok.exe`

### 3.2 Sign Up (Optional but Recommended)
1. Create free account at: https://dashboard.ngrok.com/signup
2. Get your auth token from: https://dashboard.ngrok.com/get-started/your-authtoken
3. Run this command:
```powershell
C:\ngrok\ngrok.exe config add-authtoken YOUR_AUTH_TOKEN_HERE
```

### 3.3 Start ngrok
Open a **NEW** terminal/PowerShell and run:
```powershell
C:\ngrok\ngrok.exe http 8000
```

You'll see output like:
```
Forwarding   https://abc123def456.ngrok-free.app -> http://localhost:8000
```

**COPY THE HTTPS URL** - you'll need it in Step 5

**IMPORTANT:** Keep this terminal window open! If you close it, the URL stops working.

---

## Step 4: Update Your Configuration

### 4.1 Edit .env File
1. Open: `backend\.env`
2. Replace the placeholder values with your real credentials:

```env
# Twilio Configuration (from Step 1.4)
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_real_auth_token_here
TWILIO_PHONE_NUMBER=+1234567890

# OpenAI Configuration (from Step 2.3)
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxx

# Server Configuration
HOST=0.0.0.0
PORT=8000
```

### 4.2 Restart Backend
1. Stop the backend server (Ctrl+C in the backend terminal)
2. Start it again:
```powershell
cd backend
python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

---

## Step 5: Configure Twilio Webhook (5 minutes)

This tells Twilio where to send incoming calls.

### 5.1 Set Webhook URL
1. Go to Twilio Console: https://console.twilio.com/
2. Click **Phone Numbers → Manage → Active Numbers**
3. Click on your phone number
4. Scroll down to **Voice Configuration**
5. Under "A CALL COMES IN":
   - Select: **Webhook**
   - Enter: `https://YOUR-NGROK-URL.ngrok-free.app/voice/incoming`
     (Replace YOUR-NGROK-URL with the URL from Step 3.3)
   - Method: **HTTP POST**
6. Click **Save** at the bottom

---

## Step 6: Test Your System

### 6.1 Make a Test Call
1. From your mobile phone, call your Twilio number
2. You should hear: "Welcome to Voice Bridge Translation Service"
3. Follow the prompts to select your language
4. Speak into the phone
5. You should hear the translation!

### 6.2 Test Web-to-Phone
1. Open http://localhost:5173 in browser
2. Select a language
3. Click microphone and speak
4. At the same time, call your Twilio number from a phone
5. Both should be able to communicate!

---

## Troubleshooting

### "Call failed" or "No answer"
- Check ngrok is still running
- Check backend server is running
- Verify webhook URL in Twilio matches your ngrok URL

### "Invalid API key" errors
- Double-check your .env file has correct keys
- Make sure you restarted the backend after updating .env
- Verify OpenAI account has credits

### "No translation happening"
- Check OpenAI API key is valid
- Check you have credits in OpenAI account
- Look at backend terminal for error messages

### ngrok URL changed
- ngrok free tier gives you a new URL each time you restart
- Update Twilio webhook URL with the new ngrok URL
- Or upgrade to ngrok paid plan for permanent URL

---

## Cost Breakdown

### One-Time Setup
- Twilio trial: **FREE** ($15 credit included)
- OpenAI initial credits: **$5-10**

### Monthly Costs
- Twilio phone number: **~$1/month**
- Twilio calls: **~$0.02/minute**
- OpenAI API usage: **~$0.01-0.05 per translation**

**Example:** 100 minutes of calls + 200 translations = ~$7/month

---

## Alternative: Deploy to Cloud (No ngrok needed)

If you don't want to keep ngrok running, you can deploy to:

### Option A: Railway
- Free tier available
- Permanent URL
- Auto-deploys from GitHub
- Guide: https://railway.app/

### Option B: Render
- Free tier available
- Permanent URL
- Guide: https://render.com/

### Option C: Heroku
- $5/month
- Very reliable
- Guide: https://heroku.com/

Would you like help deploying to any of these?

---

## Next Steps

Once phone calls are working:
1. Test with multiple languages
2. Invite others to test
3. Consider adding features:
   - Call recording
   - Multiple participants (conference call)
   - SMS translation
   - WhatsApp integration

---

## Support

If you need help:
1. Check backend logs in terminal
2. Check Twilio logs: https://console.twilio.com/monitor/logs/calls
3. Check OpenAI usage: https://platform.openai.com/usage
4. Ask me for help with specific errors!

---

**Ready to start? Begin with Step 1: Create your Twilio account!**
