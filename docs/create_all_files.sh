#!/bin/bash

# API Reference - Users
cat > api-reference/users/README.md << 'EOF'
# Users API

Manage players in your game.

## Endpoints

- [Create User](create-user.md) - Register a new player
- [Get User](get-user.md) - Retrieve user information
- [Get All Users](get-all-users.md) - List all players
EOF

cat > api-reference/users/get-user.md << 'EOF'
# Get User

Retrieve a user by ID, username, or wallet address.

## Endpoint

```
GET /api/v1/users
```

## Query Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user_id` | UUID | No | User's unique identifier |
| `username` | string | No | User's username |
| `wallet_address` | string | No | User's wallet address |

At least one parameter must be provided.

## Response

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "wallet_address": "7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU",
  "username": "player1",
  "total_staked": 1250.50,
  "created_at": "2025-01-15T10:30:00Z",
  "builder_id": "123e4567-e89b-12d3-a456-426614174000"
}
```
EOF

cat > api-reference/users/get-all-users.md << 'EOF'
# Get All Users

Retrieve all users for your builder account.

## Endpoint

```
GET /api/v1/users/get-all
```

## Query Parameters

| Parameter | Type | Default | Description |
|-----------|------|---------|-------------|
| `skip` | int | 0 | Records to skip |
| `limit` | int | 100 | Max records to return |

## Response

```json
[
  {
    "id": "550e8400-e29b-41d4-a716-446655440000",
    "wallet_address": "7xKXtg2CW87d97TXJSDpbD5jBkheTqA83TZRuJosgAsU",
    "username": "player1",
    "total_staked": 1250.50,
    "created_at": "2025-01-15T10:30:00Z"
  }
]
```
EOF

# API Reference - Pools
cat > api-reference/pools/README.md << 'EOF'
# Pools API

Create and manage prize pools.

## Endpoints

- [Create Pool](create-pool.md) - Create a new prize pool
- [Get Pool](get-pool.md) - Retrieve pool information
- [Get Round State](get-round-state.md) - Get user's state in pool
- [Get Leaderboard](get-leaderboard.md) - View pool rankings
- [Get Statistics](get-statistics.md) - Pool metrics
- [Get User Info](get-user-info.md) - User details in pool
EOF

# API Reference - Transactions
cat > api-reference/transactions/README.md << 'EOF'
# Transactions API

Handle stakes and rewards.

## Endpoints

- [Enter Round](enter-round.md) - Stake into a pool
- [Claim Rewards](claim-rewards.md) - Withdraw winnings
- [Get Transactions](get-transactions.md) - Transaction history
EOF

# API Reference - Winners
cat > api-reference/winners/README.md << 'EOF'
# Winners API

Select winners and distribute prizes.

## Complete Winner Selection Flow

1. [Request Randomness](request-randomness.md) - Request VRF from oracle
2. [Fulfill Randomness](fulfill-randomness.md) - Retrieve random number
3. [Choose Winners](choose-winners.md) - Select top 3 winners

Each step must be completed in order.
EOF

# Core Concepts
cat > core-concepts/README.md << 'EOF'
# Core Concepts

Understand the key concepts behind YieldPlay SDK.

## Topics

- [Prize Pools](prize-pools.md) - How prize pools work
- [DeFi Yield](defi-yield.md) - Yield generation explained
- [Prize Distribution](prize-distribution.md) - How prizes are calculated
- [Platform Fees](platform-fees.md) - Revenue model
EOF

# Guides
cat > guides/README.md << 'EOF'
# Guides

Step-by-step integration guides.

## Integration Guides

- [Web Application](integration/web-app.md)
- [Mobile Application](integration/mobile-app.md)
- [Game Engine](integration/game-engine.md)

## Game Type Guides

- [Card Games](game-types/card-games.md)
- [Puzzle Games](game-types/puzzle-games.md)
- [Racing Games](game-types/racing-games.md)

## Best Practices

- [Error Handling](best-practices/error-handling.md)
- [Security](best-practices/security.md)
- [Testing](best-practices/testing.md)
EOF

# Examples
cat > examples/README.md << 'EOF'
# Examples

Sample code and complete examples.

## Language Examples

- [JavaScript/TypeScript](javascript.md)
- [Python](python.md)

## Complete Examples

- [Complete Game Example](complete-game.md)
EOF

# Monetization
cat > monetization/README.md << 'EOF'
# Monetization

Learn how to generate revenue with YieldPlay SDK.

## Topics

- [Revenue Model](revenue-model.md) - How you earn money
- [Platform Fees](platform-fees.md) - Fee structure
- [Revenue Calculator](revenue-calculator.md) - Estimate your earnings
EOF

# Security
cat > security/README.md << 'EOF'
# Security

Security best practices and guidelines.

## Topics

- [Authentication](authentication.md) - API key management
- [API Keys](api-keys.md) - Secure key storage
- [Rate Limiting](rate-limiting.md) - Request limits
EOF

# FAQ
cat > faq/README.md << 'EOF'
# Frequently Asked Questions

## General

**Q: What is YieldPlay SDK?**
A: YieldPlay SDK is a prize pool infrastructure for game developers. It handles stakes, yield farming, and prize distribution automatically.

**Q: How much does it cost?**
A: You earn 2-5% platform fees on every prize pool. No upfront costs.

**Q: What games can I build?**
A: Any game where you can determine winners - card games, puzzle games, racing, prediction markets, etc.

## Technical

**Q: What blockchains are supported?**
A: Currently Solana. EVM chains coming soon.

**Q: Do I need to know smart contracts?**
A: No. YieldPlay SDK handles all blockchain interactions.

**Q: How long does integration take?**
A: Most developers integrate in 1-4 days.

## Need More Help?

- 💬 [Discord](https://discord.gg/yieldplay)
- 📧 [Email Support](mailto:support@yieldplay.io)
EOF

# Support
cat > support/README.md << 'EOF'
# Support

Get help with YieldPlay SDK.

## Community

- 💬 [Discord](https://discord.gg/yieldplay)
- 🐦 [Twitter](https://twitter.com/yieldplay)
- 📧 [Email](mailto:support@yieldplay.io)

## Resources

- [Documentation](https://docs.yieldplay.io)
- [GitHub](https://github.com/yieldplay/sdk)
- [Changelog](changelog.md)

## Report Issues

- 🐛 [GitHub Issues](https://github.com/yieldplay/sdk/issues)
- 📧 [Email Support](mailto:support@yieldplay.io)
EOF

cat > support/changelog.md << 'EOF'
# Changelog

## [1.0.0] - 2025-01-15

### Added
- Initial release
- Users API
- Pools API
- Transactions API
- Winners API
- Solana blockchain support

### Features
- DeFi yield farming
- VRF random winner selection
- Prize distribution
- Platform fee system
EOF

echo "All files created successfully!"
