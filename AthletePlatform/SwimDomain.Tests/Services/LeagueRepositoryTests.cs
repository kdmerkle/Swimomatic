using Moq;
using Platform.Core.Models;
using Platform.Core.Repositories;

namespace SwimDomain.Tests.Services;

public class LeagueServiceTests
{
    [Fact]
    public async Task GetAllAsync_ReturnsLeagues()
    {
        var mockRepo = new Mock<ILeagueRepository>();
        mockRepo.Setup(r => r.GetAllAsync(null)).ReturnsAsync([new League { LeagueId = 1, Name = "Test League" }]);

        var result = await mockRepo.Object.GetAllAsync(null);

        Assert.Single(result);
        Assert.Equal("Test League", result.First().Name);
    }

    [Fact]
    public async Task GetByIdAsync_NotFound_ReturnsNull()
    {
        var mockRepo = new Mock<ILeagueRepository>();
        mockRepo.Setup(r => r.GetByIdAsync(999)).ReturnsAsync((League?)null);

        var result = await mockRepo.Object.GetByIdAsync(999);

        Assert.Null(result);
    }
}
