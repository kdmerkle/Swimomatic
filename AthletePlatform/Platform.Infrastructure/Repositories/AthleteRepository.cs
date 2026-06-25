using System.Data;
using Dapper;
using Platform.Core.Data;
using Platform.Core.Models;
using Platform.Core.Repositories;

namespace Platform.Infrastructure.Repositories;

public class AthleteRepository(IDbConnectionFactory connFactory) : IAthleteRepository
{
    public async Task<IEnumerable<Athlete>> GetAllAsync()
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QueryAsync<Athlete>("spAthleteGetAll", commandType: CommandType.StoredProcedure);
    }

    public async Task<Athlete?> GetByIdAsync(int id)
    {
        using var conn = await connFactory.OpenAsync();
        return await conn.QuerySingleOrDefaultAsync<Athlete>(
            "spAthleteGetById", new { AthleteId = id }, commandType: CommandType.StoredProcedure);
    }

    public async Task<int> SaveAsync(Athlete athlete)
    {
        var p = new DynamicParameters();
        p.Add("@AthleteId", athlete.AthleteId, direction: ParameterDirection.InputOutput);
        p.Add("@TenantId", athlete.TenantId);
        p.Add("@FirstName", athlete.FirstName);
        p.Add("@LastName", athlete.LastName);
        p.Add("@BirthDate", athlete.BirthDate);
        p.Add("@Gender", athlete.Gender);
        using var conn = await connFactory.OpenAsync();
        await conn.ExecuteAsync("spAthleteSave", p, commandType: CommandType.StoredProcedure);
        return p.Get<int>("@AthleteId");
    }
}
