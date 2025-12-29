---
description: Get started with YieldPlay API
---

# Installation

## Requirements

- Any programming language with HTTP client support
- API Key from [YieldPlay Dashboard](https://dashboard.yieldplay.io)

## API Access

YieldPlay currently provides a **REST API**. You can use it with any programming language:

- JavaScript/TypeScript (fetch, axios)
- Python (requests, httpx)
- Go (net/http)
- Java (HttpClient)
- C# (HttpClient)
- Any language with HTTP support

## Base URL

```
Production: https://api.yieldplay.io
Sandbox: https://sandbox-api.yieldplay.io
```

## Get API Key

1. Sign up at [dashboard.yieldplay.io](https://dashboard.yieldplay.io)
2. Create a new builder account
3. Copy your Builder API Key
4. Store in environment variable:

```bash
export YIELDPLAY_API_KEY="your_builder_api_key_here"
```

## Making Your First Request

### JavaScript/TypeScript

```javascript
const response = await fetch('https://api.yieldplay.io/api/v1/users', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': process.env.YIELDPLAY_API_KEY
  },
  body: JSON.stringify({
    wallet_address: '7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU',
    username: 'player1'
  })
});

const user = await response.json();
console.log('User created:', user);
```

### Python

```python
import requests
import os

response = requests.post(
    'https://api.yieldplay.io/api/v1/users',
    headers={
        'Content-Type': 'application/json',
        'X-API-Key': os.getenv('YIELDPLAY_API_KEY')
    },
    json={
        'wallet_address': '7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU',
        'username': 'player1'
    }
)

user = response.json()
print('User created:', user)
```

### cURL

```bash
curl -X POST https://api.yieldplay.io/api/v1/users \
  -H "Content-Type: application/json" \
  -H "X-API-Key: your_builder_api_key" \
  -d '{
    "wallet_address": "7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU",
    "username": "player1"
  }'
```

## Coming Soon

Official SDKs for:
- 📦 JavaScript/TypeScript NPM package
- 📦 Python PyPI package
- 📦 Go module
- 📦 Unity package

## Next Steps

- [Quick Start](quick-start.md) - Build your first integration
- [API Reference](../api-reference/) - Complete API documentation
- [Authentication](../api-reference/authentication.md) - API key usage
