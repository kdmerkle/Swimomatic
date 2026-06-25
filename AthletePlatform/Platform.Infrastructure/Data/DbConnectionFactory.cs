using Dapper;
using Microsoft.Data.SqlClient;
using Platform.Core.Data;
using Platform.Core.Tenancy;

namespace Platform.Infrastructure.Data;

public sealed class DbConnectionFactory(
    string connectionString,
    ITenantContext tenantContext) : IDbConnectionFactory
{
    public async Task<SqlConnection> OpenAsync(bool bypassRls = false)
    {
        var conn = new SqlConnection(connectionString);
        await conn.OpenAsync();
        if (!bypassRls && tenantContext.IsResolved)
        {
            await conn.ExecuteAsync(
                "EXEC sp_set_session_context @key=N'TenantId', @value=@id, @read_only=1",
                new { id = tenantContext.TenantId });
        }
        return conn;
    }
}
