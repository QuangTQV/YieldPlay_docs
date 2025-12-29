---
description: Complete API reference for YieldPlay SDK
---

# API Reference

## Base URL

```
Production: https://api.yieldplay.io
Sandbox: https://sandbox-api.yieldplay.io
```

## Authentication

All API requests require a Builder API Key in the header:

```
X-API-Key: your_builder_api_key
```

## API Groups

- [Users API](users/) - Manage players
- [Pools API](pools/) - Create and manage prize pools
- [Transactions API](transactions/) - Handle stakes and claims
- [Winners API](winners/) - Select winners and distribute prizes

## Response Format

Success responses return the requested data:

```json
{
  "id": "550e8400-e29b-41d4-a716-446655440000",
  "name": "Example",
  ...
}
```

Error responses include a detail field:

```json
{
  "detail": "Error message here"
}
```

## Common HTTP Status Codes

- `200 OK` - Request successful
- `201 Created` - Resource created
- `400 Bad Request` - Invalid input
- `401 Unauthorized` - Invalid API key
- `403 Forbidden` - No permission
- `404 Not Found` - Resource not found
- `422 Unprocessable Entity` - Validation error
- `500 Internal Server Error` - Server error
