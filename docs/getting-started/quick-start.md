---
description: Get started with YieldPlay API in 5 minutes
---

# Quick Start

Get your first prize pool running in 5 minutes using the REST API.

## Prerequisites

* API Key (get from [dashboard](https://dashboard.yieldplay.io))
* HTTP client (fetch, axios, requests, etc.)

## API Setup

### Base URL

```
Production: https://api.yieldplay.io
Sandbox: https://sandbox-api.yieldplay.io
```

### Authentication

All requests require your Builder API Key:

```
X-API-Key: your_builder_api_key
```

## Basic Flow

### 1. Create a User

```javascript
const response = await fetch('https://api.yieldplay.io/api/v1/users', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': process.env.YIELDPLAY_API_KEY
  },
  body: JSON.stringify({
    wallet_address: "7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU",
    username: "player1"
  })
});

const user = await response.json();
console.log('User created:', user.id);
```

### 2. Create a Pool

```javascript
const response = await fetch('https://api.yieldplay.io/api/v1/pools', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': process.env.YIELDPLAY_API_KEY
  },
  body: JSON.stringify({
    name: "Daily Tournament",
    ticket_base_price: 10,
    ticket_price_jump: 0.1,
    start_time: Math.floor(Date.now() / 1000) + 3600,
    end_time: Math.floor(Date.now() / 1000) + 86400
  })
});

const pool = await response.json();
console.log('Pool created:', pool.id);
```

### 3. Player Stakes

```javascript
const response = await fetch('https://api.yieldplay.io/api/v1/transactions/enter', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': process.env.YIELDPLAY_API_KEY
  },
  body: JSON.stringify({
    user_id: user.id,
    pool_id: pool.id,
    amount: 100
  })
});

const stakeResult = await response.json();
console.log('Stake transaction:', stakeResult.data.serialized_transaction);
// Client must sign and submit this transaction on-chain
```

### 4. Your Game Runs

```javascript
// Your game logic here (unchanged)
const gameResults = playYourGame();
const winners = gameResults.topPlayers;
```

### 5. Check Leaderboard

```javascript
const response = await fetch(
  `https://api.yieldplay.io/api/v1/pools/${pool.id}/leaderboard?limit=10`,
  {
    headers: {
      'X-API-Key': process.env.YIELDPLAY_API_KEY
    }
  }
);

const leaderboard = await response.json();
console.log('Top players:', leaderboard.users);
```

### 6. Pool Ends - Choose Winners

```javascript
// Step 1: Request VRF randomness
await fetch('https://api.yieldplay.io/api/v1/pools/winners/request-randomness', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': process.env.YIELDPLAY_API_KEY
  },
  body: JSON.stringify({ pool_id: pool.id })
});

// Step 2: Wait for oracle (~30 seconds)
await new Promise(resolve => setTimeout(resolve, 30000));

// Step 3: Fulfill randomness  
await fetch('https://api.yieldplay.io/api/v1/pools/winners/fulfill-randomness', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': process.env.YIELDPLAY_API_KEY
  },
  body: JSON.stringify({ pool_id: pool.id })
});

// Step 4: Choose winners
const response = await fetch('https://api.yieldplay.io/api/v1/pools/winners/choose', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': process.env.YIELDPLAY_API_KEY
  },
  body: JSON.stringify({ pool_id: pool.id })
});

const result = await response.json();
console.log('Winners chosen!', result);
```

### 7. Winners Claim Rewards

```javascript
const response = await fetch('https://api.yieldplay.io/api/v1/transactions/claim', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': process.env.YIELDPLAY_API_KEY
  },
  body: JSON.stringify({
    user_id: winner.id,
    pool_id: pool.id,
    amount: prizeAmount
  })
});

const claimResult = await response.json();
console.log('Prize claimed:', claimResult);
```

## Complete Example

Here's a complete example with error handling:

```javascript
const YIELDPLAY_API = 'https://api.yieldplay.io';
const API_KEY = process.env.YIELDPLAY_API_KEY;

async function apiCall(endpoint, method = 'GET', body = null) {
  const options = {
    method,
    headers: {
      'Content-Type': 'application/json',
      'X-API-Key': API_KEY
    }
  };
  
  if (body) {
    options.body = JSON.stringify(body);
  }
  
  const response = await fetch(`${YIELDPLAY_API}${endpoint}`, options);
  
  if (!response.ok) {
    const error = await response.json();
    throw new Error(error.detail || 'API request failed');
  }
  
  return response.json();
}

async function runTournament() {
  try {
    // 1. Create user
    const user = await apiCall('/api/v1/users', 'POST', {
      wallet_address: "7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU",
      username: "player1"
    });
    console.log('✓ User created:', user.id);

    // 2. Create pool
    const pool = await apiCall('/api/v1/pools', 'POST', {
      name: "Evening Tournament",
      ticket_base_price: 10,
      ticket_price_jump: 0.1,
      start_time: Math.floor(Date.now() / 1000) + 300,
      end_time: Math.floor(Date.now() / 1000) + 3600
    });
    console.log('✓ Pool created:', pool.id);

    // 3. Player enters
    const stakeResult = await apiCall('/api/v1/transactions/enter', 'POST', {
      user_id: user.id,
      pool_id: pool.id,
      amount: 10
    });
    console.log('✓ Stake transaction created');

    // 4. Your game logic runs here
    console.log('✓ Game running...');

    // 5. Wait for pool to end
    console.log('✓ Waiting for pool to end...');
    const waitTime = (pool.end_time * 1000) - Date.now();
    if (waitTime > 0) {
      await new Promise(resolve => setTimeout(resolve, waitTime));
    }

    // 6. Choose winners (3-step process)
    console.log('✓ Requesting randomness...');
    await apiCall('/api/v1/pools/winners/request-randomness', 'POST', {
      pool_id: pool.id
    });
    
    console.log('✓ Waiting for oracle...');
    await new Promise(resolve => setTimeout(resolve, 30000));
    
    console.log('✓ Fulfilling randomness...');
    await apiCall('/api/v1/pools/winners/fulfill-randomness', 'POST', {
      pool_id: pool.id
    });
    
    console.log('✓ Choosing winners...');
    await apiCall('/api/v1/pools/winners/choose', 'POST', {
      pool_id: pool.id
    });

    console.log('🎉 Tournament complete!');

  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

runTournament();
```

## Python Example

```python
import requests
import os
import time

YIELDPLAY_API = 'https://api.yieldplay.io'
API_KEY = os.getenv('YIELDPLAY_API_KEY')

def api_call(endpoint, method='GET', json=None):
    headers = {
        'Content-Type': 'application/json',
        'X-API-Key': API_KEY
    }
    
    url = f'{YIELDPLAY_API}{endpoint}'
    response = requests.request(method, url, headers=headers, json=json)
    
    if not response.ok:
        error = response.json()
        raise Exception(error.get('detail', 'API request failed'))
    
    return response.json()

# Create user
user = api_call('/api/v1/users', 'POST', {
    'wallet_address': '7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU',
    'username': 'player1'
})

# Create pool
pool = api_call('/api/v1/pools', 'POST', {
    'name': 'Daily Tournament',
    'ticket_base_price': 10,
    'ticket_price_jump': 0.1,
    'start_time': int(time.time()) + 3600,
    'end_time': int(time.time()) + 86400
})

print(f'Pool created: {pool["id"]}')
```

## Testing in Sandbox

Use sandbox environment for testing:

```javascript
const YIELDPLAY_API = 'https://sandbox-api.yieldplay.io';
```

Sandbox features:
- ✅ Free test tokens
- ✅ Faster block times
- ✅ No real money
- ✅ Same API as production

## API Response Format

All API responses follow this structure:

```javascript
// Success
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "name": "Daily Tournament",
  "status": "ACTIVE",
  // ... other fields
}

// Error
{
  "detail": "Pool not found"
}
```

## Next Steps

* [Learn about Prize Distribution](../core-concepts/prize-distribution.md)
* [Explore Full API Reference](../api-reference/)
* [See Complete Examples](../examples/)
* [Join Discord Community](https://discord.gg/yieldplay)

## Need Help?

* 💬 [Discord](https://discord.gg/yieldplay)
* 📧 [Email Support](mailto:support@yieldplay.io)
* 🐛 [Report Issues](https://github.com/yieldplay/sdk/issues)
