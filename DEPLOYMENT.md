# 🚀 Deployment Guide

Deploy VoiceBridge to production.

## Quick Deploy Options

### Option 1: Railway (Easiest - 5 minutes)

```bash
# Install Railway CLI
npm install -g @railway/cli

# Login
railway login

# Deploy
cd backend
railway init
railway up

# Add environment variables in Railway dashboard
# Get deployment URL and update Twilio webhook
```

### Option 2: Heroku

```bash
# Install Heroku CLI
# Login
heroku login

# Create app
heroku create voicebridge-app

# Add buildpack
heroku buildpacks:set heroku/python

# Deploy
git push heroku main

# Set environment variables
heroku config:set TWILIO_ACCOUNT_SID=ACxxxx
heroku config:set TWILIO_AUTH_TOKEN=xxxxx
# ... add all variables

# Open app
heroku open
```

### Option 3: AWS EC2

```bash
# Launch EC2 instance (Ubuntu 22.04)
# SSH into instance
ssh ubuntu@your-ip

# Install dependencies
sudo apt update
sudo apt install python3.12 python3-pip nginx

# Clone repo
git clone your-repo
cd voicebridge/backend

# Install requirements
pip3 install -r requirements.txt

# Setup systemd service
sudo nano /etc/systemd/system/voicebridge.service
```

Service file:
```ini
[Unit]
Description=VoiceBridge API
After=network.target

[Service]
User=ubuntu
WorkingDirectory=/home/ubuntu/voicebridge/backend
Environment="PATH=/home/ubuntu/.local/bin"
ExecStart=/home/ubuntu/.local/bin/uvicorn app.main:app --host 0.0.0.0 --port 8000

[Install]
WantedBy=multi-user.target
```

```bash
# Start service
sudo systemctl start voicebridge
sudo systemctl enable voicebridge

# Setup Nginx reverse proxy
sudo nano /etc/nginx/sites-available/voicebridge
```

Nginx config:
```nginx
server {
    listen 80;
    server_name your-domain.com;

    location / {
        proxy_pass http://127.0.0.1:8000;
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
    }

    location /voice/stream {
        proxy_pass http://127.0.0.1:8000;
        proxy_http_version 1.1;
        proxy_set_header Upgrade $http_upgrade;
        proxy_set_header Connection "upgrade";
    }
}
```

```bash
sudo ln -s /etc/nginx/sites-available/voicebridge /etc/nginx/sites-enabled/
sudo nginx -t
sudo systemctl restart nginx

# Setup SSL with Let's Encrypt
sudo apt install certbot python3-certbot-nginx
sudo certbot --nginx -d your-domain.com
```

## Environment Variables for Production

```env
# Twilio
TWILIO_ACCOUNT_SID=ACxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_AUTH_TOKEN=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
TWILIO_PHONE_NUMBER=+1234567890

# OpenAI
OPENAI_API_KEY=sk-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx

# Google Cloud
GOOGLE_APPLICATION_CREDENTIALS=/path/to/credentials.json
GOOGLE_PROJECT_ID=your-project-id

# Server
SERVER_URL=https://your-domain.com
PORT=8000
HOST=0.0.0.0

# Database
DATABASE_URL=postgresql://user:pass@host:5432/voicebridge

# Features
USE_WHISPER=true
USE_GPT_TRANSLATION=true
ENABLE_CALL_RECORDING=false

# Security
SECRET_KEY=your-secret-key-here
ALLOWED_ORIGINS=https://your-frontend.com
```

## Production Checklist

- [ ] All API keys configured
- [ ] Database setup and migrated
- [ ] SSL certificate installed
- [ ] Twilio webhook updated
- [ ] Monitoring setup
- [ ] Backup system configured
- [ ] Rate limiting enabled
- [ ] Error tracking (Sentry)
- [ ] Log aggregation
- [ ] Auto-scaling configured

## Monitoring

### Setup Sentry for Error Tracking

```bash
pip install sentry-sdk
```

Add to `main.py`:
```python
import sentry_sdk

sentry_sdk.init(
    dsn="your-sentry-dsn",
    traces_sample_rate=1.0,
)
```

### Setup Logging

Use Papertrail or similar:
```bash
# Install
pip install python-logstash-async

# Configure in code
import logging
from logstash_async.handler import AsynchronousLogstashHandler

handler = AsynchronousLogstashHandler(
    'logs.papertrailapp.com',
    12345,
    database_path='logstash.db'
)
logging.getLogger().addHandler(handler)
```

## Scaling

### Horizontal Scaling

Use Gunicorn with multiple workers:

```bash
pip install gunicorn

gunicorn app.main:app \
  --workers 4 \
  --worker-class uvicorn.workers.UvicornWorker \
  --bind 0.0.0.0:8000
```

### Load Balancing

Setup Nginx load balancer:
```nginx
upstream voicebridge {
    server 127.0.0.1:8000;
    server 127.0.0.1:8001;
    server 127.0.0.1:8002;
    server 127.0.0.1:8003;
}

server {
    listen 80;
    location / {
        proxy_pass http://voicebridge;
    }
}
```

## Database Setup

### PostgreSQL

```bash
# Install PostgreSQL
sudo apt install postgresql postgresql-contrib

# Create database
sudo -u postgres createdb voicebridge
sudo -u postgres createuser voicebridge_user

# Set password
sudo -u postgres psql
ALTER USER voicebridge_user WITH PASSWORD 'your-password';
GRANT ALL PRIVILEGES ON DATABASE voicebridge TO voicebridge_user;
```

### Migrations

```bash
# Install alembic
pip install alembic

# Initialize
alembic init migrations

# Create migration
alembic revision -m "Initial"

# Run migrations
alembic upgrade head
```

## Backup Strategy

### Daily Database Backups

```bash
# Crontab entry
0 2 * * * pg_dump voicebridge > /backups/db_$(date +\%Y\%m\%d).sql
```

### S3 Backup Script

```python
import boto3
from datetime import datetime

s3 = boto3.client('s3')

def backup_to_s3():
    filename = f"backup_{datetime.now().strftime('%Y%m%d')}.sql"
    s3.upload_file(
        f'/backups/{filename}',
        'voicebridge-backups',
        filename
    )
```

## Security Hardening

### Rate Limiting

```bash
pip install slowapi
```

```python
from slowapi import Limiter, _rate_limit_exceeded_handler
from slowapi.util import get_remote_address

limiter = Limiter(key_func=get_remote_address)
app.state.limiter = limiter

@app.post("/voice/incoming")
@limiter.limit("100/minute")
async def voice_incoming(request: Request):
    ...
```

### API Key Rotation

Rotate keys monthly:
1. Generate new keys
2. Update in deployment
3. Test thoroughly
4. Invalidate old keys

## Cost Optimization

### Use Caching

```python
from functools import lru_cache

@lru_cache(maxsize=1000)
def translate_common_phrases(text, source, target):
    # Cache common translations
    pass
```

### Optimize Audio Processing

```python
# Use smaller Whisper model for lower costs
# Use Google Translate instead of GPT for non-critical translations
# Batch TTS requests
# Compress audio before transmission
```

## Troubleshooting Production Issues

### High Latency

1. Check server CPU/memory
2. Enable Redis caching
3. Use CDN for static assets
4. Optimize database queries
5. Use faster STT/TTS models

### Memory Leaks

```bash
# Monitor memory
watch -n 1 free -m

# Profile application
pip install memory_profiler
python -m memory_profiler app/main.py
```

### WebSocket Issues

```bash
# Check nginx timeout settings
proxy_read_timeout 3600;
proxy_connect_timeout 3600;
proxy_send_timeout 3600;
```

## Disaster Recovery

### Incident Response Plan

1. Alert received (Sentry, PagerDuty)
2. Assess impact
3. Rollback if needed
4. Fix issue
5. Deploy fix
6. Post-mortem

### Rollback Procedure

```bash
# Railway
railway rollback

# Heroku
heroku releases:rollback

# Manual
git revert HEAD
git push
```

## Performance Metrics

### Key Metrics to Monitor

- Response time (target: <2s)
- Error rate (target: <0.1%)
- Active calls count
- Translation accuracy
- Audio quality score
- API quota usage
- Server CPU/Memory
- Database connections

### Setup Monitoring

```python
from prometheus_client import Counter, Histogram

calls_total = Counter('calls_total', 'Total calls')
translation_duration = Histogram('translation_duration', 'Translation time')

@app.post("/voice/incoming")
async def voice_incoming():
    calls_total.inc()
    with translation_duration.time():
        # Process call
        pass
```

## Support

After deployment:
- Test thoroughly
- Monitor for 24 hours
- Set up alerts
- Document any issues
- Train support team

---

**Your VoiceBridge is now production-ready! 🎉**
