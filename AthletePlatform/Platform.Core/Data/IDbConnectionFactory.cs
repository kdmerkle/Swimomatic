using Microsoft.Data.SqlClient;

namespace Platform.Core.Data;

public interface IDbConnectionFactory
{
    Task<SqlConnection> OpenAsync(bool bypassRls = false);
}
