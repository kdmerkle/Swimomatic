using Microsoft.AspNetCore.Authorization;

namespace AthletePlatformAPI.Infrastructure.Auth;

public record AdminRequirement(string ResourceType) : IAuthorizationRequirement;
