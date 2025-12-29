---
description: Learn what YieldPlay SDK is and how it helps game developers
---

# What is YieldPlay?

YieldPlay SDK is a **prize pool infrastructure** for game developers. It allows you to add sustainable prize pools to any game without changing your game logic.

## The Problem

Traditional prize pools require:
- ❌ Upfront prize funding from your treasury
- ❌ Complex smart contract development
- ❌ DeFi integration expertise
- ❌ Prize calculation and distribution logic
- ❌ Compliance and legal overhead

## The Solution

YieldPlay SDK handles everything:
- ✅ Accept player stakes automatically
- ✅ Farm DeFi yield to fund prizes
- ✅ Calculate fair prize distribution
- ✅ Distribute prizes to winners
- ✅ You just send game results

## How It's Different

### Traditional Prize Pools
```
You fund prizes → Players compete → You lose money
```

### YieldPlay SDK
```
Players stake → DeFi generates yield → Yield becomes prizes
                                     ↓
                        You earn 2-5% platform fee
```

## Key Benefits

### For Developers

**💸 New Revenue Stream**
- Earn 2-5% on every prize pool
- No ads, no aggressive IAP

**⚡ Fast Integration**
- 3 simple APIs
- Launch in days, not months

**🎯 Works With Any Game**
- Card, puzzle, racing, shooter, strategy, casual
- Your game logic stays unchanged

**🔧 Zero Maintenance**
- We handle DeFi, crypto, on-chain transactions
- You focus on your game

### For Players

**💰 Fair Prizes**
- Transparent, provably random
- No house edge manipulation

**🎮 Low Risk**
- Stake is mostly refunded if they lose
- Optional boost fees for better odds

**⚡ Instant Payouts**
- Claim rewards immediately after pool ends

## What You Can Build

- **Random Draw Games** - Lucky draws, raffles, sweepstakes
- **Prediction Markets** - Sports betting, event outcomes
- **Skill Competitions** - Leaderboards, tournaments
- **Prize Savings** - Gamified finance apps
- **Hybrid Games** - Mix any mechanics

## How It Works

```
┌─────────────────────────────────────────────┐
│ Step 1: YieldPlay Handles Stakes            │
│                                             │
│  Player → Stake $100 → YieldPlay SDK        │
│                                             │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│ Step 2: DeFi Generates Yield                │
│                                             │
│  $100 → lending protocol → Generates $5 yield  │
│                                             │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│ Step 3: Your Game Runs (Unchanged)          │
│                                             │
│  Your code → Determine winners              │
│                                             │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│ Step 4: You Send Results                    │
│                                             │
│  SDK.submitResults(winners)                 │
│                                             │
└─────────────────────────────────────────────┘
                    ↓
┌─────────────────────────────────────────────┐
│ Step 5: YieldPlay Distributes               │
│                                             │
│  Winners: Get prizes from yield pool        │
│  Losers: Get most of stake back             │
│  You: Get 2-5% platform fee                 │
│                                             │
└─────────────────────────────────────────────┘
```

## Technical Architecture

YieldPlay SDK is:
- **Stateless** - We manage all state
- **Chain-agnostic** - Works with Solana, EVM chains
- **Language-agnostic** - REST API works with any backend
- **Platform-agnostic** - Web, mobile, desktop, game engines

## Who Uses YieldPlay?

- 🎮 Mobile game studios
- 🏦 FinTech startups (prize savings)
- 🎯 Web3 gaming companies
- ⚽ Sports prediction platforms
- 🃏 Social casino games

## Next Steps

- [How It Works](how-it-works.md) - Detailed architecture
- [Quick Start](quick-start.md) - Build your first integration
- [API Reference](../api-reference/) - Explore the API
