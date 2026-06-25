# Grafana Cloud Setup Guide

## Overview

Connect Grafana Cloud (free tier) to Azure Application Insights via the Azure Monitor data source.
This provides tenant-aware observability without an on-premises Grafana instance.

## Step 1: Create a Service Principal

```bash
az ad sp create-for-rbac --name "grafana-monitor-reader" \
  --role "Monitoring Reader" \
  --scopes /subscriptions/<subscription-id>/resourceGroups/<resource-group>
```

Save the output (`appId`, `password`, `tenant`).

## Step 2: Configure Azure Monitor Data Source in Grafana

1. Open Grafana Cloud > **Connections > Add new connection > Azure Monitor**
2. Set **Authentication**: App Registration
3. Fill in:
   - **Directory (tenant) ID**: `<tenant-id>`
   - **Application (client) ID**: `<appId>`
   - **Client secret**: `<password>`
4. Click **Save & Test** — verify "Data source connected and labels found"

## Step 3: Import Dashboard Templates

### Requests Per Second by TenantKey

```json
{
  "title": "Requests/sec by Tenant",
  "type": "timeseries",
  "targets": [{
    "queryType": "Azure Application Insights",
    "query": "requests | summarize count() by bin(timestamp, 1m), tostring(customDimensions['TenantKey']) | order by timestamp desc",
    "resultFormat": "time_series"
  }]
}
```

### API Response Time p50/p95/p99

```json
{
  "title": "API Response Time Percentiles",
  "type": "timeseries",
  "targets": [{
    "queryType": "Azure Application Insights",
    "query": "requests | summarize p50=percentile(duration,50), p95=percentile(duration,95), p99=percentile(duration,99) by bin(timestamp, 5m)",
    "resultFormat": "time_series"
  }]
}
```

### Failed Requests by Endpoint

```json
{
  "title": "Failed Requests by Endpoint",
  "type": "table",
  "targets": [{
    "queryType": "Azure Application Insights",
    "query": "requests | where success == false | summarize count() by name, resultCode | order by count_ desc",
    "resultFormat": "table"
  }]
}
```

### Azure SQL Dependency Duration

```json
{
  "title": "SQL Dependency Duration (ms)",
  "type": "timeseries",
  "targets": [{
    "queryType": "Azure Application Insights",
    "query": "dependencies | where type == 'SQL' | summarize avg(duration), max(duration) by bin(timestamp, 5m)",
    "resultFormat": "time_series"
  }]
}
```

## Step 4: Set Alert Rules (Optional)

- **High p99 latency**: Alert when `p99 > 2000ms` for 5 consecutive minutes
- **Error rate spike**: Alert when failed request rate exceeds 5% over a 1-minute window
- **SQL slow queries**: Alert when avg SQL dependency duration exceeds 500ms
