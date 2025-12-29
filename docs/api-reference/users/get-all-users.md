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
