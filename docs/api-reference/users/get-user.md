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
  "created_at": "2025-01-15T10:30:00Z"
}
```
