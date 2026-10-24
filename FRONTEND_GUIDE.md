# 🌐 Frontend Website Kaise Run Karein

## Method 1: Automatic Script (Easiest!)

### Step 1: Node.js Install Karein (Agar nahi hai)

```
1. https://nodejs.org/ pe jao
2. LTS version download karein (recommended)
3. Install karein (default settings)
4. Computer restart karein
```

### Step 2: Script Run Karein

```
Simply double-click: START_FRONTEND.bat

Script automatically:
- Node.js check karega
- Dependencies install karega (npm install)
- Development server start karega
- Browser mein website khol dega
```

### Step 3: Browser Mein Dekho

```
Automatically khulega: http://localhost:5173

Agar nahi khula toh manually jao:
Browser mein type karein: http://localhost:5173
```

---

## Method 2: Manual Commands

### Terminal Mein Ye Commands Run Karein:

```powershell
# Step 1: Frontend folder mein jao
cd frontend

# Step 2: Dependencies install (first time only)
npm install

# Step 3: Development server start
npm run dev
```

---

## 🎨 Website Features

Website pe aapko ye milega:

1. **Language Selection**
   - Apni language choose karein (English, Urdu, etc.)
   - Dusre person ki language choose karein

2. **Big Call Button**
   - Green button click karein call start karne ke liye
   - Red button se end karein

3. **Live Captions**
   - Jo bol rahe hain wo dikhega
   - Translation bhi dikhega

4. **Call History**
   - Previous conversations dekh sakte hain

---

## 🔗 Backend Se Connect Karna

Frontend ko backend se connect karne ke liye:

### Option 1: Backend Local Pe Chal Raha Hai

```javascript
// frontend/vite.config.js already configured hai:
proxy: {
  '/voice': 'http://localhost:8000',
  '/api': 'http://localhost:8000'
}

// Bas backend bhi chalu hona chahiye!
```

### Option 2: Backend Production Pe Hai

```javascript
// frontend/src/App.jsx mein change karein:

const API_URL = 'https://your-production-url.com'

// Instead of just '/'
axios.get(`${API_URL}/`)
```

---

## 📱 Complete System Run Karne Ka Order

### 3 Terminals Chahiye:

**Terminal 1: Backend**
```powershell
cd backend
python -m uvicorn app.main:app --reload
```

**Terminal 2: ngrok (for phone calls)**
```powershell
ngrok http 8000
```

**Terminal 3: Frontend**
```powershell
cd frontend
npm run dev
```

---

## 🎯 Quick Test

Website open hone ke baad:

1. ✅ Languages select karein (e.g., English → Urdu)
2. ✅ Green call button click karein
3. ✅ Microphone permission allow karein
4. ✅ Baat karein
5. ✅ Translation dekho screen pe!

---

## 🐛 Common Problems

### "Node.js not found"
```
Solution: 
1. Download: https://nodejs.org/
2. Install LTS version
3. Restart computer
4. Try again
```

### "npm install fails"
```
Solution:
# Try with force:
npm install --force

# Or clear cache:
npm cache clean --force
npm install
```

### "Port 5173 already in use"
```
Solution:
# Kill the process:
npx kill-port 5173

# Or use different port:
npm run dev -- --port 3000
```

### "Microphone not working"
```
Solution:
1. Browser mein microphone permission check karein
2. System settings mein microphone enabled hai?
3. Chrome/Edge use karein (better support)
4. HTTPS ya localhost pe hi kaam karta hai
```

### "Backend connection failed"
```
Solution:
1. Backend running hai? (port 8000)
2. Check: http://localhost:8000
3. vite.config.js mein proxy correct hai?
```

---

## 🎨 UI Preview

Website aise dikhegi:

```
┌─────────────────────────────────────┐
│      🌍 VoiceBridge                 │
│  Bolo, aur duniya samjhe            │
└─────────────────────────────────────┘

┌─────────────────────────────────────┐
│  I speak:     [English ▼]          │
│  They speak:  [Urdu ▼]             │
└─────────────────────────────────────┘

        ┌───────────────┐
        │               │
        │   🎤 START    │
        │     CALL      │
        │               │
        └───────────────┘

┌─────────────────────────────────────┐
│  How it works:                      │
│  1. Select languages                │
│  2. Click button                    │
│  3. Speak naturally                 │
│  4. Translation happens!            │
└─────────────────────────────────────┘
```

---

## 💡 Pro Tips

1. **Use Chrome/Edge** - Better WebRTC support
2. **Allow Microphone** - Browser will ask permission
3. **Use Headphones** - Prevents echo
4. **Backend Must Be Running** - Frontend alone won't work
5. **Check Console** - Press F12 for error logs

---

## 📊 Development Tools

```powershell
# Hot reload (automatic refresh on changes)
npm run dev

# Build for production
npm run build

# Preview production build
npm run preview

# Install new package
npm install package-name
```

---

## 🎯 Next Steps

After website runs successfully:

1. ✅ Test with backend
2. ✅ Try different languages
3. ✅ Customize UI colors/styling
4. ✅ Add new features
5. ✅ Deploy to production (Vercel/Netlify)

---

## 🚀 Ready to Run?

```powershell
# Just run this:
cd frontend
npm install
npm run dev

# Then open:
http://localhost:5173
```

**Website khul jayegi! 🎉**
