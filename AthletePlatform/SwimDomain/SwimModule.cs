using Microsoft.AspNetCore.Builder;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Platform.Core;
using SwimDomain.Repositories;
using SwimDomain.Services;

namespace SwimDomain;

public sealed class SwimModule : ISportModule
{
    public string SportCode => "swim";

    public void RegisterServices(IServiceCollection services, IConfiguration config)
    {
        services.AddScoped<ISwimMeetRepository, SwimMeetRepository>();
        services.AddScoped<IHeatSheetRepository, HeatSheetRepository>();
        services.AddScoped<IResultRepository, ResultRepository>();
        services.AddScoped<ISwimMeetService, SwimMeetService>();
        services.AddScoped<IHeatSheetService, HeatSheetService>();
        services.AddScoped<IResultService, ResultService>();
    }
}
