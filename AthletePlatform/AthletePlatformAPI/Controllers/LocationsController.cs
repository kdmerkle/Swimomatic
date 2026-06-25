using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using Platform.Core.Models;
using Platform.Core.Repositories;
using Platform.Core.Tenancy;

namespace AthletePlatformAPI.Controllers;

[ApiController]
[Route("api/locations")]
[Authorize]
public class LocationsController(
    ILocationRepository locationRepository,
    ITenantContext tenantContext) : ControllerBase
{
    [HttpGet]
    public async Task<ActionResult<IEnumerable<Location>>> GetLocations()
    {
        return Ok(await locationRepository.GetAllAsync());
    }

    [HttpGet("{id:int}")]
    public async Task<ActionResult<Location>> GetLocation(int id)
    {
        var loc = await locationRepository.GetByIdAsync(id);
        return loc is null ? NotFound() : Ok(loc);
    }

    [HttpPost]
    public async Task<ActionResult<Location>> CreateLocation([FromBody] Location location)
    {
        location.TenantId = tenantContext.TenantId;
        var id = await locationRepository.SaveAsync(location);
        location.LocationId = id;
        return CreatedAtAction(nameof(GetLocation), new { id }, location);
    }
}
