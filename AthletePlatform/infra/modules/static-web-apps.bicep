param appName string
param location string

resource staticWebApp 'Microsoft.Web/staticSites@2023-01-01' = {
  name: '${appName}-spa'
  location: location
  sku: {
    name: 'Free'
    tier: 'Free'
  }
  properties: {}
}

output staticWebAppUrl string = 'https://${staticWebApp.properties.defaultHostname}'
output staticWebAppName string = staticWebApp.name
