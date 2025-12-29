---
description: Create a new user for your game
---

# Create User

Create a new user associated with your game (builder account).

## Endpoint

```
POST /api/v1/users
```

## Authentication

Requires **Builder API Key** in header:

```
X-API-Key: your_builder_api_key
```

## Request Body

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `wallet_address` | string | ✅ Yes | Valid Solana wallet address |
| `username` | string | ❌ No | User's display name |

### Example Request

```javascript
const response = await fetch('https://api.yieldplay.io/api/v1/users', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': 'your_builder_api_key'
  },
  body: JSON.stringify({
    wallet_address: '7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU',
    username: 'player1'
  })
});

const user = await response.json();
```

## Response

**Status Code:** `201 Created`

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "wallet_address": "7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU",
  "username": "player1",
  "total_staked": 0,
  "created_at": "2025-01-15T10:30:00Z"
}
```

## Error Responses

### 400 Bad Request - Invalid Wallet

```json
{
  "detail": "Please register with a valid solana address"
}
```

### 400 Bad Request - Duplicate User

```json
{
  "detail": "Wallet already registered for this builder"
}
```
