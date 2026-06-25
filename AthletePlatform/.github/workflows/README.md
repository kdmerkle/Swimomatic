# GitHub Actions Workflows

## Workflows

| Workflow | File | Trigger |
|---|---|---|
| API CI/CD | `api-cd.yml` | Push to `main` affecting API or domain projects |
| SPA CI/CD | `spa-cd.yml` | Push to `main` affecting `athlete-platform-spa/` |

## Required GitHub Secrets

Set these in **Settings → Secrets and variables → Actions → Secrets**:

| Secret Name | Description |
|---|---|
| `AZURE_APP_SERVICE_PUBLISH_PROFILE` | Download from Azure Portal → App Service → Get publish profile |
| `AZURE_STATIC_WEB_APPS_API_TOKEN` | Deployment token from Azure Static Web Apps resource |
| `VITE_AUTH0_DOMAIN` | Auth0 tenant domain (e.g. `your-tenant.auth0.com`) |
| `VITE_AUTH0_CLIENT_ID` | Auth0 SPA client ID |
| `VITE_AUTH0_AUDIENCE` | Auth0 API audience (e.g. `https://api.athleteplatform.com`) |

## Required GitHub Variables

Set these in **Settings → Secrets and variables → Actions → Variables**:

| Variable Name | Description |
|---|---|
| `AZURE_APP_SERVICE_NAME` | Name of the Azure App Service resource |
| `VITE_API_BASE_URL` | Public URL of the deployed API (e.g. `https://athleteplatform-api.azurewebsites.net`) |

## Local Development

For local development, set environment variables in a `.env.local` file in `athlete-platform-spa/` (git-ignored):

```
VITE_AUTH0_DOMAIN=your-tenant.auth0.com
VITE_AUTH0_CLIENT_ID=your-client-id
VITE_AUTH0_AUDIENCE=https://api.athleteplatform.com
VITE_API_BASE_URL=http://localhost:5000
```
