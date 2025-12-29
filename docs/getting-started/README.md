---
description: Get started with YieldPlay SDK
---

# Getting Started

Welcome to YieldPlay SDK! This guide will help you integrate prize pools into your game in minutes.

## What You'll Learn

* [What is YieldPlay?](what-is-yieldplay.md) - Understand the platform
* [How It Works](how-it-works.md) - Learn the architecture
* [Quick Start](quick-start.md) - Build your first integration (5 minutes)
* [Installation](installation.md) - Set up the SDK

## Prerequisites

Before you begin, you'll need:

* ✅ API Key from [YieldPlay Dashboard](https://dashboard.yieldplay.io)
* ✅ Node.js 16+ or Python 3.8+
* ✅ Basic understanding of REST APIs

## Your First Prize Pool in 5 Minutes

```javascript
const YieldPlay = require('@yieldplay/sdk');

const sdk = new YieldPlay({
  apiKey: process.env.YIELDPLAY_API_KEY
});

// Create pool
const pool = await sdk.pools.create({
  name: "Daily Tournament",
  ticketBasePrice: 10,
  ticketPriceJump: 0.1
});

// Player enters
await sdk.transactions.enter({
  userId: user.id,
  poolId: pool.id,
  amount: 100
});

// Choose winners (after pool ends)
await sdk.winners.choose({ poolId: pool.id });
```

That's it! You're earning platform fees.

## Next Steps

* [Quick Start Guide](quick-start.md) - Detailed walkthrough
* [API Reference](../api-reference/) - Complete API docs
* [Examples](../examples/) - Sample code
