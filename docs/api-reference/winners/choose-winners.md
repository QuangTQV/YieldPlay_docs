# Choose Winners

Select top 3 winners and distribute prizes (Step 3 of winner selection).

## Endpoint

```
POST /api/v1/pools/winners/choose
```

## Request Body

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `pool_id` | UUID | ✅ Yes | Pool to choose winners for |

## Response

```json
{
  "pool_id": "660e8400-e29b-41d4-a716-446655440001",
  "round_id": "round_abc123",
  "transaction_signature": "9Rn4...",
  "message": "Winners chosen successfully and pool marked as completed",
  "pool_status": "COMPLETED"
}
```

## Complete Flow

```javascript
// Step 1
await sdk.winners.requestRandomness({ poolId });

// Step 2: Wait for oracle
await sleep(30000);

// Step 3
await sdk.winners.fulfillRandomness({ poolId });

// Step 4
await sdk.winners.choose({ poolId });
```
