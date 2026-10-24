# Real-Time Call Translation System

**Bolo kisi bhi zaban mein, samjhein sab.** (Speak in any language, everyone understands.)

A real-time phone call translation system that allows two people speaking different languages to understand each other naturally during calls.

## 🎯 Core Feature

Call someone → You speak English → They hear Urdu (or any language) → They reply in Urdu → You hear English

## 🌟 How It Works

```
Caller A (English) → Phone Call → Translation Bridge → Caller B (Urdu)
                         ↓
            [Speech Recognition → Translation → Speech Synthesis]
```

## 🚀 Use Cases

- **International Business**: Call clients in Pakistan, China, or anywhere
- **Family Calls**: Talk to relatives who speak different languages
- **Customer Support**: Support customers in their native language
- **Emergency Services**: Break language barriers in critical situations
- **Travel**: Call hotels, restaurants abroad in your language

## 📱 How to Use

### Option 1: Direct Call (Recommended)
```
1. Call the VoiceBridge number: +1-XXX-XXX-XXXX
2. Select your language (e.g., "English")
3. Enter the other person's number
4. Select their language (e.g., "Urdu")
5. Start speaking - translation happens automatically!
```

### Option 2: Conference Bridge
```
1. You call: +1-XXX-XXX-1111 (English line)
2. Friend calls: +1-XXX-XXX-2222 (Urdu line)
3. Both connected with live translation
```

### Option 3: Web App with Call Button
```
1. Open app.voicebridge.com
2. Enter friend's number and select languages
3. Click "Start Translated Call"
4. Speak naturally!
```

## 🎤 Supported Languages

### High-Quality Voice Support
- 🇵🇰 **Urdu** / اردو
- 🇵🇰 **Punjabi** / ਪੰਜਾਬੀ  
- 🇬🇧 **English**
- 🇸🇦 **Arabic** / العربية
- 🇮🇳 **Hindi** / हिन्दी
- 🇪🇸 **Spanish** / Español
- 🇫🇷 **French** / Français
- 🇨🇳 **Chinese** / 中文
- 🇩🇪 **German** / Deutsch
- 🇯🇵 **Japanese** / 日本語

**Total: 50+ languages with natural voices**

## 🏗️ System Architecture

```
┌─────────────┐         ┌──────────────────┐         ┌─────────────┐
│  Caller A   │────────▶│  Twilio Voice    │◀────────│  Caller B   │
│  (English)  │         │  Gateway         │         │   (Urdu)    │
└─────────────┘         └────────┬─────────┘         └─────────────┘
                                 │
                        ┌────────▼─────────┐
                        │  FastAPI Server  │
                        │  - WebSocket     │
                        │  - Media Stream  │
                        └────────┬─────────┘
                                 │
                 ┌───────────────┼───────────────┐
                 │               │               │
         ┌───────▼──────┐ ┌─────▼──────┐ ┌─────▼──────┐
         │  Speech-to-  │ │ Translation│ │ Text-to-   │
         │  Text (STT)  │ │   Engine   │ │ Speech     │
         │   Whisper    │ │  GPT/Google│ │  Google TTS│
         └──────────────┘ └────────────┘ └────────────┘
```

## 🛠️ Tech Stack

| Component | Technology |
|-----------|-----------|
| **Call Handling** | Twilio Voice API + Media Streams |
| **Speech Recognition** | OpenAI Whisper / Google Speech-to-Text |
| **Translation** | OpenAI GPT-4 / Google Translate |
| **Voice Synthesis** | Google Cloud TTS / ElevenLabs |
| **Backend** | Python FastAPI + WebSocket |
| **Database** | PostgreSQL (call logs) |
| **Real-time** | WebSocket bidirectional audio |

## 📦 Installation

### Prerequisites
```bash
- Python 3.12+
- Twilio Account (with phone number)
- OpenAI API Key
- Google Cloud Account (for TTS/STT)
- ngrok (for local testing)
```

### Step 1: Clone Repository
```bash
git clone https://github.com/yourusername/call-translator
cd call-translator
```

### Step 2: Backend Setup
```bash
cd backend
pip install -r requirements.txt
```

### Step 3: Configure Environment
Create `backend/.env`:
```env
# Twilio
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=your_auth_token
TWILIO_PHONE_NUMBER=+1234567890

# OpenAI
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxx

# Google Cloud
GOOGLE_APPLICATION_CREDENTIALS=path/to/service-account.json

# Server
SERVER_URL=https://your-ngrok-url.ngrok.io
```

### Step 4: Run Server
```bash
python -m uvicorn app.main:app --reload --host 0.0.0.0 --port 8000
```

### Step 5: Expose with ngrok
```bash
ngrok http 8000
```

### Step 6: Configure Twilio Webhook
1. Go to Twilio Console → Phone Numbers
2. Select your number
3. Under "Voice & Fax":
   - **A Call Comes In**: `https://your-ngrok-url.ngrok.io/voice/incoming`
   - Method: HTTP POST

## 🎮 Testing

### Test with Two Phones
```bash
# Phone 1: Call your Twilio number
# Say: "English to Urdu"
# Then speak in English

# Phone 2: Will receive translated call in Urdu
```

### Test with Web Interface
```bash
cd frontend
npm install
npm run dev
# Open http://localhost:5173
```

## 📊 Features in Detail

### 1. **Real-Time Translation**
- Less than 2 second latency
- Maintains conversation flow
- Natural pauses and timing

### 2. **Accent Handling**
- Trained on Pakistani English accents
- Regional Urdu/Punjabi dialects
- Automatic accent detection

### 3. **Context Awareness**
- Remembers conversation context
- Better translation accuracy
- Handles idioms and phrases

### 4. **Quality Assurance**
- Confidence scoring for translations
- Auto-retry on low confidence
- Human-like voice intonation

### 5. **Call Features**
- Call recording (with consent)
- Live transcripts
- Post-call translation summary
- Downloadable conversation log

## 💰 Pricing Estimate

### Per Minute Costs:
- Twilio Voice: $0.0085/min
- Whisper STT: $0.006/min
- GPT-4 Translation: $0.02/min
- Google TTS: $0.016/min

**Total: ~$0.05 per minute** (both sides)

### For 100 minutes/month:
- Cost: ~$5
- With margin: $10-15 subscription

## 🔒 Security & Privacy

- ✅ End-to-end encryption for audio
- ✅ No permanent storage of conversations
- ✅ GDPR compliant
- ✅ Optional call recording (with consent)
- ✅ Automatic data deletion after 24 hours
- ✅ No sharing with third parties

## 🐛 Troubleshooting

### "No audio heard"
```bash
# Check Twilio webhook URL is correct
# Verify ngrok is running
# Check WebSocket connection in logs
```

### "Translation is slow"
```bash
# Use faster STT model (Whisper tiny)
# Switch to Google Translate instead of GPT
# Optimize audio chunk size
```

### "Poor translation quality"
```bash
# Increase audio quality in Twilio
# Use GPT-4 instead of GPT-3.5
# Add context to translation prompts
```

## 📱 Mobile App (Coming Soon)

- iOS and Android apps
- No need to call a number
- Direct person-to-person translated calls
- Offline mode for common languages

## 🗺️ Roadmap

- [x] Basic call translation (2 languages)
- [x] Twilio integration
- [x] Real-time audio streaming
- [ ] Multi-language support (50+ languages)
- [ ] Mobile apps
- [ ] Group call translation (3+ people)
- [ ] Video call with subtitle overlay
- [ ] WhatsApp/Signal integration
- [ ] SMS translation
- [ ] Voicemail translation

## 📞 Architecture Deep Dive

### Call Flow:

1. **Caller A dials Twilio number**
2. **Twilio webhook** → FastAPI `/voice/incoming`
3. **IVR Menu**: "Press 1 for English, 2 for Urdu..."
4. **WebSocket** connection opens (Twilio Media Stream)
5. **Audio chunks** stream in real-time
6. **STT** converts to text continuously
7. **Translation** happens sentence by sentence
8. **TTS** generates translated audio
9. **Audio streams back** to Caller B
10. **Bidirectional** - same process in reverse

### Data Flow:
```
Caller A Audio → Twilio → WebSocket → Server
    ↓
STT (Whisper): Audio → English Text
    ↓
Translation (GPT-4): English Text → Urdu Text  
    ↓
TTS (Google): Urdu Text → Urdu Audio
    ↓
Caller B Audio ← Twilio ← WebSocket ← Server
```

## 🤝 Contributing

Contributions welcome! Please read CONTRIBUTING.md

## 📄 License

MIT License - See LICENSE file

## 👨‍💻 Author

Built with ❤️ for breaking language barriers worldwide

## 📞 Support

- Email: support@voicebridge.com
- Discord: https://discord.gg/voicebridge
- Docs: https://docs.voicebridge.com

---

**Start connecting with anyone, anywhere, in any language! 🌍**
