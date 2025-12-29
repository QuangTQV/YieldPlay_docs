---
description: Create a stake transaction for entering a prize pool
---

# Enter Round

Create a stake (deposit) transaction for a user to enter an active prize pool.

## Endpoint

```
POST /api/v1/transactions/enter
```

## Request Body

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user_id` | UUID | ✅ Yes | User's unique identifier |
| `pool_id` | UUID | ✅ Yes | Pool to enter |
| `amount` | decimal | ✅ Yes | Stake amount in USDC |

### Example Request

```javascript
const response = await fetch('https://api.yieldplay.io/api/v1/transactions/enter', {
  method: 'POST',
  headers: {
    'Content-Type': 'application/json',
    'X-API-Key': 'your_builder_api_key'
  },
  body: JSON.stringify({
    user_id: '550e8400-e29b-41d4-a716-446655440000',
    pool_id: '660e8400-e29b-41d4-a716-446655440001',
    amount: 100.00
  })
});

const result = await response.json();
```

## Response

**Status Code:** `201 Created`

```json
{
  "data": {
    "signature": "3Zr5...",
    "serialized_transaction": "AQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAACAAQAHDQoLDA0ODwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA..."
  }
}
```

## How It Works

This endpoint follows a **pre-commit pattern**:

1. Transaction Saved to DB (Status: `PENDING`)
2. On-chain Transaction Built and serialized
3. Client Signs & Submits transaction
4. Transaction Confirmed (Status: `CONFIRMED`)

## Client-Side Flow

```javascript
import { Connection, Transaction } from '@solana/web3.js';

// 1. Receive serialized transaction from API
const { serialized_transaction } = await enterRound();

// 2. Decode transaction
const transaction = Transaction.from(
  Buffer.from(serialized_transaction, 'base64')
);

// 3. User signs with wallet
const signed = await wallet.signTransaction(transaction);

// 4. Submit to Solana
const connection = new Connection('https://api.mainnet-beta.solana.com');
const signature = await connection.sendRawTransaction(signed.serialize());

// 5. Confirm transaction
await connection.confirmTransaction(signature);
```

## Error Responses

### 404 Not Found - User

```json
{
  "detail": "User not found"
}
```

### 404 Not Found - Pool

```json
{
  "detail": "Pool not found"
}
```

### 400 Bad Request - Pool Not Active

```json
{
  "detail": "Pool is not active"
}
```
