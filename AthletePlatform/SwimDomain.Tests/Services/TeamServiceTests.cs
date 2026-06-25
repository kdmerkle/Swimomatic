using Moq;
using Platform.Core.Models;
using Platform.Core.Repositories;

namespace SwimDomain.Tests.Services;

public class TeamServiceTests
{
    [Fact]
    public async Task GetAllAsync_ReturnsTeams()
    {
        var mockRepo = new Mock<ITeamRepository>();
        mockRepo.Setup(r => r.GetAllAsync()).ReturnsAsync([new Team { TeamId = 1, Name = "Swim Team A" }]);

        var result = await mockRepo.Object.GetAllAsync();

        Assert.Single(result);
    }
}
