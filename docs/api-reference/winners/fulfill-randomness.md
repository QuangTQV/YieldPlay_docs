# Fulfill Randomness

Retrieve VRF random number from oracle (Step 2 of winner selection).

## Endpoint

```
POST /api/v1/pools/winners/fulfill-randomness
```

## Request Body

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `pool_id` | UUID | ✅ Yes | Pool to fulfill randomness for |

## Response

```json
{
  "pool_id": "660e8400-e29b-41d4-a716-446655440001",
  "round_id": "round_abc123",
  "transaction_signature": "7Qm3...",
  "message": "VRF randomness fulfilled successfully"
}
```

## Notes

- Must wait ~30 seconds after request-randomness
- Oracle needs time to generate random number
