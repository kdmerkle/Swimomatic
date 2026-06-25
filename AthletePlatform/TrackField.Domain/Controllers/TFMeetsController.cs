using Microsoft.AspNetCore.Mvc;

namespace TrackField.Domain.Controllers;

[ApiController]
[Route("api/tf/meets")]
public class TFMeetsController : ControllerBase
{
    [HttpGet]
    public IActionResult GetMeets() => StatusCode(501, "Track & Field coming soon");
}
