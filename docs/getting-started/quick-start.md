---
description: Get started with YieldPlay SDK in 5 minutes
---

# Quick Start

Get your first prize pool running in 5 minutes.

## Prerequisites

* API Key (get from [dashboard](https://dashboard.yieldplay.io))
* Node.js 16+ or Python 3.8+

## Installation

{% tabs %}
{% tab title="JavaScript" %}
```bash
npm install @yieldplay/sdk
```
{% endtab %}

{% tab title="Python" %}
```bash
pip install yieldplay-sdk
```
{% endtab %}
{% endtabs %}

## Initialize SDK

{% tabs %}
{% tab title="JavaScript" %}
```javascript
const YieldPlay = require('@yieldplay/sdk');

const sdk = new YieldPlay({
  apiKey: process.env.YIELDPLAY_API_KEY,
  environment: 'production' // or 'sandbox'
});
```
{% endtab %}

{% tab title="Python" %}
```python
from yieldplay import YieldPlay

sdk = YieldPlay(
    api_key=os.getenv('YIELDPLAY_API_KEY'),
    environment='production'  # or 'sandbox'
)
```
{% endtab %}
{% endtabs %}

## Basic Flow

### 1. Create a User

```javascript
const user = await sdk.users.create({
  walletAddress: "7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU",
  username: "player1"
});

console.log('User created:', user.id);
```

### 2. Create a Pool

```javascript
const pool = await sdk.pools.create({
  name: "Daily Tournament",
  ticketBasePrice: 10,
  ticketPriceJump: 0.1,
  startTime: Math.floor(Date.now() / 1000) + 3600, // 1 hour from now
  endTime: Math.floor(Date.now() / 1000) + 86400   // 24 hours from now
});

console.log('Pool created:', pool.id);
```

### 3. Player Stakes

```javascript
// User enters the pool
const stakeResult = await sdk.transactions.enter({
  userId: user.id,
  poolId: pool.id,
  amount: 100 // USDC
});

// Client must sign this transaction
console.log('Stake transaction:', stakeResult.serialized_transaction);
```

### 4. Your Game Runs

```javascript
// Your game logic here (unchanged)
const gameResults = playYourGame();
const winners = gameResults.topPlayers;
```

### 5. Check Leaderboard

```javascript
const leaderboard = await sdk.pools.getLeaderboard({
  poolId: pool.id,
  limit: 10
});

console.log('Top players:', leaderboard.users);
```

### 6. Pool Ends - Choose Winners

```javascript
// Step 1: Request VRF randomness
await sdk.winners.requestRandomness({ poolId: pool.id });

// Step 2: Wait for oracle (~30 seconds)
await new Promise(resolve => setTimeout(resolve, 30000));

// Step 3: Fulfill randomness  
await sdk.winners.fulfillRandomness({ poolId: pool.id });

// Step 4: Choose winners
const result = await sdk.winners.choose({ poolId: pool.id });

console.log('Winners chosen!', result);
```

### 7. Winners Claim Rewards

```javascript
// Winner claims their prize
const claimResult = await sdk.transactions.claim({
  userId: winner.id,
  poolId: pool.id,
  amount: prizeAmount
});

console.log('Prize claimed:', claimResult);
```

## Complete Example

Here's a complete example with error handling:

```javascript
const YieldPlay = require('@yieldplay/sdk');

async function runTournament() {
  const sdk = new YieldPlay({
    apiKey: process.env.YIELDPLAY_API_KEY
  });

  try {
    // 1. Create user
    const user = await sdk.users.create({
      walletAddress: "7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU",
      username: "player1"
    });
    console.log('✓ User created:', user.id);

    // 2. Create pool
    const pool = await sdk.pools.create({
      name: "Evening Tournament",
      ticketBasePrice: 10,
      ticketPriceJump: 0.1,
      startTime: Math.floor(Date.now() / 1000) + 300,
      endTime: Math.floor(Date.now() / 1000) + 3600
    });
    console.log('✓ Pool created:', pool.id);

    // 3. Player enters
    const stakeResult = await sdk.transactions.enter({
      userId: user.id,
      poolId: pool.id,
      amount: 10
    });
    console.log('✓ Stake transaction created');
    
    // In real app: client signs and submits this transaction
    // await wallet.signAndSend(stakeResult.serialized_transaction);

    // 4. Your game logic runs here
    console.log('✓ Game running...');

    // 5. Wait for pool to end
    console.log('✓ Waiting for pool to end...');
    const waitTime = (pool.endTime * 1000) - Date.now();
    if (waitTime > 0) {
      await new Promise(resolve => setTimeout(resolve, waitTime));
    }

    // 6. Choose winners (3-step process)
    console.log('✓ Requesting randomness...');
    await sdk.winners.requestRandomness({ poolId: pool.id });
    
    console.log('✓ Waiting for oracle...');
    await new Promise(resolve => setTimeout(resolve, 30000));
    
    console.log('✓ Fulfilling randomness...');
    await sdk.winners.fulfillRandomness({ poolId: pool.id });
    
    console.log('✓ Choosing winners...');
    await sdk.winners.choose({ poolId: pool.id });

    console.log('🎉 Tournament complete!');

  } catch (error) {
    console.error('❌ Error:', error.message);
  }
}

runTournament();
```

## Testing in Sandbox

Use sandbox environment for testing:

```javascript
const sdk = new YieldPlay({
  apiKey: process.env.YIELDPLAY_SANDBOX_KEY,
  environment: 'sandbox'
});
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

## Common Patterns

### Creating Multiple Users

```javascript
const users = await Promise.all([
  sdk.users.create({ walletAddress: wallet1, username: "player1" }),
  sdk.users.create({ walletAddress: wallet2, username: "player2" }),
  sdk.users.create({ walletAddress: wallet3, username: "player3" })
]);
```

### Getting Pool Statistics

```javascript
const stats = await sdk.pools.getStatistics({ poolId: pool.id });
console.log({
  totalStaked: stats.total_staked,
  participants: stats.total_participants,
  tickets: stats.total_tickets
});
```

### Checking User's Position

```javascript
const userInfo = await sdk.pools.getUserInfo({
  poolId: pool.id,
  userId: user.id
});

console.log({
  rank: userInfo.rank,
  tickets: userInfo.tickets,
  winProbability: userInfo.win_probability
});
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
