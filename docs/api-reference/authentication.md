# Authentication

All API requests require authentication using a Builder API Key.

## Getting Your API Key

1. Sign up at [dashboard.yieldplay.io](https://dashboard.yieldplay.io)
2. Create a new project
3. Copy your API key from the dashboard

## Using Your API Key

Include your API key in the `X-API-Key` header:

```
X-API-Key: your_builder_api_key
```

### Example

```javascript
const response = await fetch('https://api.yieldplay.io/api/v1/users', {
  headers: {
    'X-API-Key': 'your_builder_api_key',
    'Content-Type': 'application/json'
  }
});
```

## Security Best Practices

- ✅ Store API keys in environment variables
- ✅ Never commit keys to version control
- ✅ Use different keys for dev/staging/production
- ❌ Never expose keys in client-side code

## Environments

- **Production**: `https://api.yieldplay.io`
- **Sandbox**: `https://sandbox-api.yieldplay.io`
