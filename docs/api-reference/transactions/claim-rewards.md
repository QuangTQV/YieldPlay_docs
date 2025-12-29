# Claim Rewards

Create a claim transaction to withdraw winnings.

## Endpoint

```
POST /api/v1/transactions/claim
```

## Request Body

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user_id` | UUID | ✅ Yes | User's unique identifier |
| `pool_id` | UUID | ✅ Yes | Pool to claim from |
| `amount` | decimal | ✅ Yes | Amount to claim |

## Response

```json
{
  "data": {
    "signature": "3Zr5...",
    "serialized_transaction": "..."
  }
}
```
