# Auth0 Setup Guide

## Post-Login Action

Deploy this action in the Auth0 dashboard under **Actions > Flows > Login**:

```javascript
exports.onExecutePostLogin = async (event, api) => {
  const tenantId = event.user.app_metadata?.tenantId;
  if (tenantId) {
    api.accessToken.setCustomClaim(
      'https://athleteplatform.com/tenant_id', tenantId);
  }
};
```

## Setting Tenant for a User

Via Auth0 Management API or dashboard:

- Go to **User Management > Users > [User] > app_metadata**
- Set: `{ "tenantId": "riverside-swim" }`

## API Resource

- Identifier: `https://api.athleteplatform.com`
- Signing: RS256

## SPA Application

- Type: Single Page Application
- Allowed Callback URLs: `http://localhost:5173, https://[your-swa-url]`
- Allowed Logout URLs: same
- Allowed Web Origins: same
