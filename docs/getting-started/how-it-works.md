---
description: Understand how YieldPlay SDK works under the hood
---

# How It Works

Learn the architecture and flow of YieldPlay SDK.

## Architecture Overview

```
┌──────────────────────────────────────────────────┐
│              Your Game                           │
│  (Web, Mobile, Desktop, Game Engine)             │
└───────────────────┬──────────────────────────────┘
                    │
                    │ REST API
                    │
┌───────────────────▼──────────────────────────────┐
│           YieldPlay SDK Backend                  │
│                                                  │
│  ┌────────────┐  ┌────────────┐  ┌───────────┐ │
│  │   Users    │  │   Pools    │  │Transaction│ │
│  │    API     │  │    API     │  │    API    │ │
│  └────────────┘  └────────────┘  └───────────┘ │
│                                                  │
│  ┌────────────────────────────────────────────┐ │
│  │        Prize Distribution Engine           │ │
│  └────────────────────────────────────────────┘ │
└───────────────────┬──────────────────────────────┘
                    │
                    │ Smart Contracts
                    │
┌───────────────────▼──────────────────────────────┐
│              Blockchain Layer                    │
│                                                  │
│  ┌────────────┐  ┌────────────┐  ┌───────────┐ │
│  │  Staking   │  │  DeFi      │  │  Random   │ │
│  │ Contracts  │  │  Yield     │  │  VRF      │ │
│  └────────────┘  └────────────┘  └───────────┘ │
└──────────────────────────────────────────────────┘
```

## Complete Flow

### 1. Pool Creation

**Your Code:**
```javascript
const pool = await sdk.pools.create({
  name: "Daily Tournament",
  ticketBasePrice: 10,
  ticketPriceJump: 0.1,
  startTime: timestamp,
  endTime: timestamp + 86400
});
```

**What Happens:**
1. ✅ Pool record created in database
2. ✅ On-chain round created on Solana
3. ✅ Round ID returned and linked to pool
4. ✅ Pool status set to `ACTIVE`

### 2. Player Stakes

**Your Code:**
```javascript
const result = await sdk.transactions.enter({
  userId: user.id,
  poolId: pool.id,
  amount: 100
});

// Client signs and submits transaction
await wallet.signAndSend(result.serialized_transaction);
```

**What Happens:**
1. ✅ Transaction saved to DB (status: `PENDING`)
2. ✅ Serialized transaction returned to client
3. ✅ Client signs with wallet
4. ✅ Transaction submitted to blockchain
5. ✅ Funds deposited to pool contract
6. ✅ DeFi yield farming starts automatically
7. ✅ Transaction status updated to `CONFIRMED`

### 3. Your Game Runs

**Your Code:**
```javascript
// Your game logic (unchanged)
const gameResults = await playYourGame();
const winners = gameResults.topPlayers.slice(0, 3);
```

**What Happens:**
- 🎮 Your game runs normally
- 🎮 You determine winners using your logic
- 🎮 No interaction with YieldPlay yet

### 4. Pool Ends & Winner Selection

**Your Code:**
```javascript
// Step 1: Request VRF randomness
await sdk.winners.requestRandomness({ poolId: pool.id });

// Step 2: Wait for oracle (~30 seconds)
await sleep(30000);

// Step 3: Fulfill randomness
await sdk.winners.fulfillRandomness({ poolId: pool.id });

// Step 4: Choose winners
await sdk.winners.choose({ poolId: pool.id });
```

**What Happens:**
1. ✅ VRF randomness requested from ORAO oracle
2. ✅ Oracle generates provably random number
3. ✅ Random number retrieved
4. ✅ Top 3 winners selected on-chain
5. ✅ Prize distribution calculated:
   - 1st place: 50% of yield pool
   - 2nd place: 30% of yield pool
   - 3rd place: 20% of yield pool
6. ✅ Pool status updated to `COMPLETED`

### 5. Prize Distribution

**Your Code:**
```javascript
// Winners claim their rewards
await sdk.transactions.claim({
  userId: winner.id,
  poolId: pool.id,
  amount: prizeAmount
});
```

**What Happens:**
1. ✅ Winner's prize calculated (stake + yield share)
2. ✅ Loser's refund calculated (stake - boost fee)
3. ✅ Platform fee deducted (2-5%)
4. ✅ Funds transferred on-chain
5. ✅ Transaction recorded in database

## Prize Calculation Example

### Pool Details
- Total Staked: $10,000 (100 players × $100)
- DeFi Yield Generated: $500 (5% APY for 1 week)
- Platform Fee: 3% = $15
- Prize Pool: $500 - $15 = $485

### Winner Payouts
- **1st Place**: $100 (stake) + $242.50 (50% of $485) = **$342.50**
- **2nd Place**: $100 (stake) + $145.50 (30% of $485) = **$245.50**
- **3rd Place**: $100 (stake) + $97.00 (20% of $485) = **$197.00**

### Loser Refunds
- Each loser: $100 (stake) - $2 (optional boost fee) = **$98.00**

### Your Revenue
- Platform fee: **$15.00**

## Data Flow

```
┌─────────────────────────────────────────────────┐
│ 1. CREATE POOL                                  │
│                                                 │
│  Client → SDK → Database → Blockchain           │
│                              ↓                  │
│                         Round Created           │
│                              ↓                  │
│                      Return Pool ID             │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│ 2. PLAYER STAKES                                │
│                                                 │
│  Client → SDK → Database (PENDING)              │
│            ↓                                    │
│     Serialized TX                               │
│            ↓                                    │
│  Client → Blockchain → Confirmed                │
│                           ↓                     │
│              Database (CONFIRMED)               │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│ 3. YIELD FARMING (Automatic)                    │
│                                                 │
│  Staked Funds → Aave/Compound → Generate Yield  │
│                                      ↓          │
│                              Prize Pool Grows   │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│ 4. WINNER SELECTION                             │
│                                                 │
│  SDK → VRF Oracle → Random Number               │
│                         ↓                       │
│              Blockchain Smart Contract          │
│                         ↓                       │
│              Select Top 3 Winners               │
│                         ↓                       │
│              Calculate Prizes                   │
│                         ↓                       │
│         Database (Pool = COMPLETED)             │
└─────────────────────────────────────────────────┘

┌─────────────────────────────────────────────────┐
│ 5. CLAIM REWARDS                                │
│                                                 │
│  Client → SDK → Database (PENDING)              │
│            ↓                                    │
│     Serialized TX                               │
│            ↓                                    │
│  Client → Blockchain → Transfer Funds           │
│                           ↓                     │
│              Database (CONFIRMED)               │
└─────────────────────────────────────────────────┘
```

## State Management

YieldPlay SDK is **stateless** - all state is managed:
- **Off-chain**: PostgreSQL database for metadata
- **On-chain**: Solana smart contracts for funds and logic

### What's Stored Off-chain
- User profiles
- Pool metadata
- Transaction history
- Leaderboards (cached)

### What's Stored On-chain
- User deposits
- Pool rounds
- VRF randomness
- Winner selection
- Prize distribution

## Security Model

1. **No Custody** - We never hold user funds
2. **Transparent** - All transactions on-chain
3. **Provably Random** - VRF from Chainlink/ORAO
4. **Audited** - Smart contracts professionally audited

## Next Steps

- [Quick Start](quick-start.md) - Build your first integration
- [Core Concepts](../core-concepts/) - Deep dive into concepts
- [API Reference](../api-reference/) - Explore the API
