<!-- markdownlint-disable-file -->
# Planning Log: Swagger / OpenAPI for AthletePlatformAPI

## Discrepancy Log

### Unaddressed Research Items

* DR-01: XML documentation (`<GenerateDocumentationFile>true</GenerateDocumentationFile>`) would surface controller summaries in Swagger UI
  * Reason: Not requested; adds `#pragma warning disable` noise to all controller files. Listed as follow-on work.
  * Impact: low

* DR-02: `[ProducesResponseType]` attributes on controllers would improve OpenAPI response schema accuracy
  * Reason: Not requested; controllers already return typed `ActionResult<T>` which Swashbuckle infers
  * Impact: low

### Plan Deviations from Research

None.

## Implementation Paths Considered

### Selected: Swashbuckle.AspNetCore 7.x

* Approach: Industry standard for ASP.NET Core Swagger; ships `swagger-ui` bundle; no separate UI host needed
* Rationale: Mature, well-documented, single package covers generation + UI
* Evidence: https://github.com/domaindrivendev/Swashbuckle.AspNetCore

### IP-01: Microsoft.AspNetCore.OpenApi (built-in .NET 9)

* Approach: Native OpenAPI support added in .NET 9 via `builder.Services.AddOpenApi()`
* Trade-offs: Generates `/openapi/v1.json` but does NOT ship a Swagger UI; requires a separate `scalar` or `swagger-ui` package
* Rejection rationale: Requires two packages instead of one; Swashbuckle is more familiar and ships everything needed

## Suggested Follow-on Work

* WI-S01: Enable XML documentation — add `<GenerateDocumentationFile>true</GenerateDocumentationFile>` to csproj and wire `IncludeXmlComments` in `AddSwaggerGen` (low priority)
* WI-S02: Add `[ProducesResponseType]` attributes to controller actions for precise 200/400/404/401 response schemas (low priority)
* WI-S03: Consider `scalar` UI as a modern Swagger UI alternative if preferred over the default Swashbuckle UI
