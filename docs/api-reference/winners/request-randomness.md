# Request Randomness

Request VRF randomness from oracle (Step 1 of winner selection).

## Endpoint

```
POST /api/v1/pools/winners/request-randomness
```

## Request Body

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `pool_id` | UUID | ✅ Yes | Pool to request randomness for |

## Response

```json
{
  "pool_id": "660e8400-e29b-41d4-a716-446655440001",
  "round_id": "round_abc123",
  "transaction_signature": "5Kp2...",
  "message": "VRF randomness requested successfully"
}
```
