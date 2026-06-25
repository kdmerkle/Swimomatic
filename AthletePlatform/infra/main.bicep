targetScope = 'resourceGroup'

@description('Base name for all resources (e.g. athleteplatform-prod)')
param appName string

@description('Azure region. Defaults to resource group location.')
param location string = resourceGroup().location

@description('SQL Server administrator password')
@secure()
param sqlAdminPassword string

@description('Auth0 tenant domain (e.g. your-tenant.auth0.com)')
param auth0Domain string

@description('Auth0 API audience identifier')
param auth0Audience string

// ── Application Insights ─────────────────────────────────────────────────────
module appInsights 'modules/app-insights.bicep' = {
  name: 'appInsights'
  params: {
    appName: appName
    location: location
  }
}

// ── Azure SQL ────────────────────────────────────────────────────────────────
module sql 'modules/sql.bicep' = {
  name: 'sql'
  params: {
    appName: appName
    location: location
    sqlAdminPassword: sqlAdminPassword
  }
}

// ── App Service ──────────────────────────────────────────────────────────────
module appService 'modules/app-service.bicep' = {
  name: 'appService'
  params: {
    appName: appName
    location: location
    keyVaultName: '${appName}-kv'
    appInsightsConnectionString: appInsights.outputs.connectionString
  }
}

// ── Key Vault ────────────────────────────────────────────────────────────────
module keyVault 'modules/key-vault.bicep' = {
  name: 'keyVault'
  params: {
    appName: appName
    location: location
    appServicePrincipalId: appService.outputs.appServicePrincipalId
    sqlConnectionString: 'Server=tcp:${sql.outputs.fullyQualifiedDomainName},1433;Initial Catalog=${sql.outputs.databaseName};Persist Security Info=False;User ID=${sql.outputs.sqlAdminLogin};Password=${sqlAdminPassword};MultipleActiveResultSets=False;Encrypt=True;TrustServerCertificate=False;Connection Timeout=30;'
    auth0Domain: auth0Domain
    auth0Audience: auth0Audience
  }
}

// ── Static Web App ────────────────────────────────────────────────────────────
module staticWebApp 'modules/static-web-apps.bicep' = {
  name: 'staticWebApp'
  params: {
    appName: appName
    location: location
  }
}

// ── Outputs ──────────────────────────────────────────────────────────────────
output appServiceUrl string = appService.outputs.appServiceUrl
output staticWebAppUrl string = staticWebApp.outputs.staticWebAppUrl
output appInsightsConnectionString string = appInsights.outputs.connectionString
output keyVaultName string = keyVault.outputs.keyVaultName
