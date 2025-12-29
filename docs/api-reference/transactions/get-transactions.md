# Get Transactions

Retrieve transaction history.

## Endpoint

```
GET /api/v1/transactions
```

## Query Parameters

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `user_id` | UUID | No | Filter by user |
| `pool_id` | UUID | No | Filter by pool |

At least one parameter required.

## Response

```json
[
  {
    "id": "tx_123",
    "user_id": "550e8400-e29b-41d4-a716-446655440000",
    "pool_id": "660e8400-e29b-41d4-a716-446655440001",
    "amount": 100.00,
    "transaction_type": "STAKE",
    "status": "CONFIRMED",
    "created_at": "2025-01-15T10:30:00Z"
  }
]
```
