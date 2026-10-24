# 📁 Project Structure

Complete overview of the VoiceBridge codebase.

```
voicebridge/
│
├── backend/                         # Python FastAPI backend
│   ├── app/
│   │   ├── __init__.py
│   │   ├── main.py                 # FastAPI app & Twilio webhooks
│   │   ├── config.py               # Settings & environment config
│   │   │
│   │   ├── voice/                  # Voice processing modules
│   │   │   ├── __init__.py
│   │   │   ├── stt.py             # Speech-to-Text (Whisper)
│   │   │   ├── tts.py             # Text-to-Speech (Google TTS)
│   │   │   └── call_handler.py    # Call session management
│   │   │
│   │   ├── translation/           # Translation engine
│   │   │   ├── __init__.py
│   │   │   └── translator.py     # GPT/Google Translate
│   │   │
│   │   └── db/                    # Database (optional)
│   │       ├── __init__.py
│   │       └── models.py         # SQLAlchemy models
│   │
│   ├── test_system.py            # System test script
│   ├── requirements.txt          # Python dependencies
│   ├── .env                     # Environment variables (git-ignored)
│   └── .env.example             # Example environment file
│
├── docs/                          # Documentation
│   ├── QUICK_START.md
│   ├── SETUP_GUIDE.md
│   └── API_REFERENCE.md
│
├── README.md                      # Main project README
├── QUICK_START.md                 # 10-minute setup guide
├── SETUP_GUIDE.md                 # Detailed setup instructions
└── PROJECT_STRUCTURE.md           # This file
```

## Key Files Explained

### `/backend/app/main.py`
- FastAPI application entry point
- Twilio webhook handlers
- WebSocket endpoint for audio streaming
- Call initiation endpoints

### `/backend/app/config.py`
- Environment configuration
- Language mappings
- Voice names for TTS
- System settings

### `/backend/app/voice/call_handler.py`
- Manages individual call sessions
- Orchestrates STT → Translation → TTS pipeline
- Handles audio buffering and streaming

### `/backend/app/voice/stt.py`
- Speech-to-Text using OpenAI Whisper
- Audio format conversion (mulaw → WAV)
- Alternative: Google Cloud Speech

### `/backend/app/voice/tts.py`
- Text-to-Speech using Google Cloud TTS
- Audio format conversion (WAV → mulaw)
- Multi-language voice selection

### `/backend/app/translation/translator.py`
- Translation engine using GPT-4
- Context-aware translation
- Fallback to Google Translate

## Data Flow

```
Phone Call
    ↓
Twilio Number
    ↓ (webhook)
main.py: /voice/incoming
    ↓
IVR Menu (language selection)
    ↓ (WebSocket)
main.py: /voice/stream
    ↓
call_handler.py
    ↓
    ├─→ stt.py (audio → text)
    ├─→ translator.py (text → translated text)
    └─→ tts.py (translated text → audio)
    ↓
WebSocket back to Twilio
    ↓
Caller hears translated audio
```

## Module Responsibilities

### Main Application (`main.py`)
- HTTP endpoints
- WebSocket connection management
- Twilio integration
- Session coordination

### Voice Module
- **STT**: Audio input → Text
- **TTS**: Text → Audio output
- **CallHandler**: Session lifecycle

### Translation Module
- Text translation with context
- Multiple provider support
- Language detection

### Configuration
- Environment variables
- Language settings
- API credentials

## API Endpoints

### HTTP Endpoints
```
GET  /                     - System info
POST /voice/incoming       - Twilio webhook (call start)
POST /voice/language       - Language selection handler
GET  /voice/start-stream   - Initialize media stream
POST /voice/make-call      - Initiate outbound call
GET  /health               - Health check
GET  /demo                 - Web demo page
```

### WebSocket Endpoints
```
WS /voice/stream          - Bidirectional audio stream
```

## Environment Variables

### Required
```
TWILIO_ACCOUNT_SID        - Twilio account ID
TWILIO_AUTH_TOKEN         - Twilio auth token
TWILIO_PHONE_NUMBER       - Your Twilio number
OPENAI_API_KEY            - OpenAI API key
SERVER_URL                - Public webhook URL (ngrok)
```

### Optional
```
GOOGLE_APPLICATION_CREDENTIALS  - Google Cloud credentials
GOOGLE_PROJECT_ID              - Google Cloud project
USE_WHISPER                    - Use Whisper for STT
USE_GPT_TRANSLATION            - Use GPT for translation
ENABLE_CALL_RECORDING          - Record calls
```

## Dependencies

### Core
- **FastAPI**: Web framework
- **Uvicorn**: ASGI server
- **Twilio**: Phone call handling
- **OpenAI**: Whisper STT + GPT translation
- **Google Cloud**: TTS & Speech

### Audio Processing
- **pydub**: Audio manipulation
- **soundfile**: Audio I/O
- **numpy**: Numerical operations

### Utilities
- **loguru**: Logging
- **python-dotenv**: Environment variables
- **pydantic**: Configuration management

## Testing

### Unit Tests
```bash
# Test translation only
python -c "from app.translation.translator import TranslationEngine; ..."

# Test TTS only
python -c "from app.voice.tts import TextToSpeech; ..."
```

### System Test
```bash
cd backend
python test_system.py
```

### Integration Test
```bash
# Call your Twilio number
# Verify audio quality and latency
```

## Development Workflow

### 1. Local Development
```bash
# Terminal 1: Backend
cd backend
python -m uvicorn app.main:app --reload

# Terminal 2: ngrok
ngrok http 8000

# Update .env with ngrok URL
# Configure Twilio webhook
```

### 2. Testing Changes
```bash
# Run system test
python test_system.py

# Test with phone call
# Monitor logs in real-time
```

### 3. Debugging
```bash
# Check logs for errors
# Verify audio format conversions
# Monitor WebSocket messages
# Test each component individually
```

## Deployment

### Production Checklist
- [ ] Remove debug logging
- [ ] Set production URLs
- [ ] Configure proper database
- [ ] Enable call recording (if needed)
- [ ] Set up monitoring
- [ ] Configure auto-scaling
- [ ] Add rate limiting
- [ ] Enable HTTPS
- [ ] Set up CDN for assets
- [ ] Configure backup system

### Recommended Stack
- **Backend**: Railway / Heroku / AWS
- **Database**: PostgreSQL / MongoDB
- **Monitoring**: Datadog / New Relic
- **Logs**: Papertrail / Loggly

## Performance Optimization

### Reduce Latency
1. Use faster STT model (Whisper tiny)
2. Cache common translations
3. Pre-generate TTS for phrases
4. Optimize audio buffer size

### Scale for Traffic
1. Use Redis for session storage
2. Implement connection pooling
3. Add CDN for static assets
4. Deploy multiple regions

## Security Considerations

### API Keys
- Never commit `.env` to git
- Rotate keys regularly
- Use environment-specific keys

### Audio Data
- Don't store audio permanently
- Encrypt WebSocket connections
- Comply with GDPR/privacy laws

### Rate Limiting
- Limit calls per user
- Prevent abuse
- Monitor usage patterns

## Troubleshooting

### Common Issues

**No audio:**
- Check ngrok is running
- Verify webhook URL in Twilio
- Inspect WebSocket connection

**Poor translation:**
- Switch to GPT-4
- Add conversation context
- Fine-tune prompts

**High latency:**
- Reduce audio buffer
- Use faster models
- Optimize network

**API errors:**
- Verify all API keys
- Check rate limits
- Monitor quotas

## Contributing

### Code Style
- Follow PEP 8
- Use type hints
- Add docstrings
- Write tests

### Pull Request Process
1. Fork repository
2. Create feature branch
3. Make changes
4. Run tests
5. Submit PR

## License

MIT License - See LICENSE file

## Support

- GitHub Issues
- Discord Community
- Email: support@voicebridge.com

---

**Understanding the structure helps you:**
- Navigate the codebase quickly
- Debug issues effectively
- Add new features easily
- Deploy with confidence
