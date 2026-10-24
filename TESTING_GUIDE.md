# VoiceBridge Testing Guide

## ✅ What's Working Now

### Languages Supported
Now you have **15 languages**:
1. 🇬🇧 English
2. 🇵🇰 Urdu / اردو
3. 🇵🇰 Punjabi / ਪੰਜਾਬੀ
4. 🇸🇦 Arabic / العربية
5. 🇮🇳 Hindi / हिन्दी
6. 🇨🇳 Chinese / 中文
7. 🇪🇸 Spanish / Español
8. 🇩🇪 German / Deutsch
9. 🇫🇷 French / Français
10. 🇯🇵 Japanese / 日本語
11. 🇰🇷 Korean / 한국어
12. 🇵🇹 Portuguese / Português
13. 🇷🇺 Russian / Русский
14. 🇹🇷 Turkish / Türkçe
15. 🇮🇹 Italian / Italiano

### Translation Features
- ✅ Voice input (Speech-to-Text)
- ✅ Voice output (Text-to-Speech)
- ✅ 10+ common phrases in all languages
- ✅ Backend API integration for full translation
- ✅ Real-time conversation history

---

## 🎯 Test Scenarios

### Scenario 1: Chinese ↔ Urdu Conversation

**Setup:**
1. Open http://localhost:5173
2. Person A: Select "I speak: Chinese", "They hear: Urdu"
3. Person B (on another device): Select "I speak: Urdu", "They hear: Chinese"

**Test:**
- Person A says in Chinese: "你好" (Hello)
- System translates to Urdu: "ہیلو / السلام علیکم"
- Person B hears Urdu translation
- Person B replies in Urdu: "شکریہ" (Thank you)
- System translates to Chinese: "谢谢"
- Person A hears Chinese translation

**✅ Expected Result:**
- Both hear translations in their own language
- Voice output plays automatically
- Conversation history shows both sides

---

### Scenario 2: German ↔ English Conversation

**Setup:**
1. Person A: "I speak: German", "They hear: English"
2. Person B: "I speak: English", "They hear: German"

**Test Phrases:**
```
Person A (German) → Person B hears (English)
"Hallo"          → "Hello"
"Wie geht es dir?" → "How are you?"
"Danke"          → "Thank you"

Person B (English) → Person A hears (German)
"Good morning"   → "Guten Morgen"
"Yes"            → "Ja"
"No"             → "Nein"
```

---

### Scenario 3: Spanish ↔ Urdu Conversation

**Setup:**
1. Person A: "I speak: Spanish", "They hear: Urdu"
2. Person B: "I speak: Urdu", "They hear: Spanish"

**Test Phrases:**
```
Spanish → Urdu
"Hola"          → "ہیلو / السلام علیکم"
"Gracias"       → "شکریہ"
"Buenos días"   → "صبح بخیر"

Urdu → Spanish
"آپ کیسے ہیں؟"  → "¿Cómo estás?"
"جی ہاں"        → "Sí"
"نہیں"          → "No"
```

---

## 🔥 Quick Test - Common Phrases

These phrases work in **ALL 15 languages**:

| English | Works In All Languages |
|---------|----------------------|
| Hello | ✅ Translates + Speaks |
| How are you | ✅ Translates + Speaks |
| Thank you | ✅ Translates + Speaks |
| Yes | ✅ Translates + Speaks |
| No | ✅ Translates + Speaks |
| Good morning | ✅ Translates + Speaks |
| Goodbye | ✅ Translates + Speaks |
| Please | ✅ Translates + Speaks |
| Welcome | ✅ Translates + Speaks |
| I love you | ✅ Translates + Speaks |

---

## 🛠️ How to Test

### Method 1: Single Device (Quick Test)
1. Open http://localhost:5173
2. Select any two languages
3. Click microphone button
4. Say one of the common phrases
5. Listen to translation

### Method 2: Two Devices (Real Conversation)
1. **Device 1:** Open http://localhost:5173
   - Select "I speak: Urdu", "They hear: Chinese"
2. **Device 2:** Open http://localhost:5173 (same URL)
   - Select "I speak: Chinese", "They hear: Urdu"
3. Take turns speaking
4. Both devices will translate for each other

### Method 3: Phone Calls (Advanced)
- See PHONE_SETUP_GUIDE.md
- Requires Twilio account + OpenAI API key
- Works with real phone numbers

---

## 🐛 Known Issues & Solutions

### Issue 1: "Recognition error: network"
**Problem:** Browser speech recognition needs internet
**Solution:** 
- Check internet connection
- Try refreshing page
- Use Chrome browser (best support)

### Issue 2: Translation shows "[Translation: xyz]"
**Problem:** Backend API not responding
**Solution:**
- Check backend is running: http://localhost:8000/health
- If backend down, only common phrases will work
- Restart backend: `python -m uvicorn app.main:app --reload`

### Issue 3: No voice output
**Problem:** Browser TTS not working
**Solution:**
- Check speaker volume
- Try different browser (Chrome recommended)
- Some languages may not have voice support in all browsers

### Issue 4: Wrong language recognized
**Problem:** Browser confused about language
**Solution:**
- Speak more clearly
- Check correct language selected in dropdown
- Try common phrases first

### Issue 5: Chinese/Japanese/Korean not speaking
**Problem:** Browser might not have Asian language voices installed
**Solution:**
- In Windows: Settings → Time & Language → Language → Add Language
- Add Chinese (Simplified), Japanese, or Korean
- Restart browser

---

## 📊 Backend API Translation

For longer sentences or custom phrases:

### When Backend Works:
- Backend running at http://localhost:8000
- OpenAI API key configured in `backend/.env`
- System will translate **ANY** text you speak
- Works for all 15 languages

### Test Backend:
```bash
# Check if backend is alive
curl http://localhost:8000/health

# Expected response:
# {"status":"healthy","service":"voicebridge","active_calls":0}
```

### If Backend Not Working:
- Only 10 common phrases will translate
- Other text shows as "[text]"
- Web interface still works for common phrases

---

## 🎤 Browser Compatibility

### Best Support:
- ✅ Chrome (Desktop & Android)
- ✅ Edge (Desktop)
- ✅ Safari (iOS/Mac) - some limitations

### Limited Support:
- ⚠️ Firefox - TTS works, STT limited
- ⚠️ Mobile browsers - varies by device

### Language Support by Browser:
| Language | Chrome | Safari | Edge |
|----------|--------|--------|------|
| English | ✅ | ✅ | ✅ |
| Urdu | ✅ | ⚠️ | ✅ |
| Chinese | ✅ | ✅ | ✅ |
| Spanish | ✅ | ✅ | ✅ |
| German | ✅ | ✅ | ✅ |
| Arabic | ✅ | ⚠️ | ✅ |
| Hindi | ✅ | ⚠️ | ✅ |

---

## 🚀 Next Steps

### To Enable Full Translation:
1. Get OpenAI API key (see PHONE_SETUP_GUIDE.md Step 2)
2. Add to `backend/.env`:
   ```
   OPENAI_API_KEY=sk-your-real-key-here
   ```
3. Restart backend
4. Now ALL sentences will translate (not just common phrases)

### To Enable Phone Calls:
- Follow PHONE_SETUP_GUIDE.md
- Get Twilio account
- Configure webhooks
- Call from real phones!

---

## 💡 Pro Tips

### For Best Results:
1. **Speak clearly** and at normal pace
2. **Use headphones** to avoid echo
3. **Test with common phrases first**
4. **Allow microphone permission** when prompted
5. **Use Chrome browser** for best experience

### For Testing Translation Quality:
1. Start with "Hello" and "Thank you"
2. Try "How are you?"
3. Then test longer phrases
4. Check conversation history to see what was recognized

### For Multi-Person Conversations:
1. Each person opens the web app
2. Each selects their own language
3. Take turns speaking (don't overlap)
4. Use "They hear" to select other person's language

---

## 📝 Example Test Script

### Quick 2-Minute Test:

```
1. Open http://localhost:5173
2. Select: I speak: English, They hear: Chinese
3. Click microphone
4. Say "Hello"
5. ✅ Should hear: "你好" in Chinese voice
6. Say "Thank you"
7. ✅ Should hear: "谢谢" in Chinese voice
8. Say "Good morning"
9. ✅ Should hear: "早上好" in Chinese voice
10. Check history - all 3 translations visible
```

**✅ If all work = System is working perfectly!**

---

## 🆘 Need Help?

### Check Logs:
- Frontend: Open browser DevTools (F12) → Console
- Backend: Look at terminal where `uvicorn` is running

### Common Console Messages:
```
"Listening..." = ✅ Microphone active
"Final: hello" = ✅ Speech recognized
"Recognition error: network" = ❌ Check internet
"Backend translation unavailable" = ⚠️ Using fallback
```

### Still Having Issues?
1. Restart browser
2. Restart backend (`Ctrl+C`, then restart)
3. Check QUICK_START.md for setup
4. Ask for help with specific error message

---

**Ready to test? Start with the Quick 2-Minute Test above!**
