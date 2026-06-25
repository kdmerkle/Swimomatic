using AthletePlatformAPI.Infrastructure.Tenancy;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Platform.Core.Models;
using Platform.Core.Repositories;
using Platform.Core.Tenancy;

namespace AthletePlatformAPI.Controllers;

[ApiController]
[Route("api/tenant")]
[Authorize]
public class TenantController(ITenantContext tenantContext, ITenantRepository tenantRepo)
    : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<TenantConfig>> GetTenantConfig()
    {
        var config = await tenantRepo.GetConfigAsync(tenantContext.TenantId);
        if (config is null)
            return NotFound();
        return Ok(config);
    }
}
