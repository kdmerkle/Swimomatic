using Moq;
using SwimDomain.Models;
using SwimDomain.Repositories;
using SwimDomain.Services;

namespace SwimDomain.Tests.Services;

public class SwimMeetServiceTests
{
    [Fact]
    public async Task GetAllMeetsAsync_ReturnsMeetsList()
    {
        var mockRepo = new Mock<ISwimMeetRepository>();
        mockRepo.Setup(r => r.GetAllAsync()).ReturnsAsync([new SwimMeet { SwimMeetId = 1, Description = "Test Meet" }]);
        var service = new SwimMeetService(mockRepo.Object);

        var result = await service.GetAllMeetsAsync();

        Assert.Single(result);
        Assert.Equal("Test Meet", result.First().Description);
    }

    [Fact]
    public async Task GetMeetAsync_NotFound_ReturnsNull()
    {
        var mockRepo = new Mock<ISwimMeetRepository>();
        mockRepo.Setup(r => r.GetByIdAsync(999)).ReturnsAsync((SwimMeet?)null);
        var service = new SwimMeetService(mockRepo.Object);

        var result = await service.GetMeetAsync(999);

        Assert.Null(result);
    }

    [Fact]
    public async Task UpdateMeetAsync_WithZeroId_ThrowsArgumentException()
    {
        var mockRepo = new Mock<ISwimMeetRepository>();
        var service = new SwimMeetService(mockRepo.Object);

        await Assert.ThrowsAsync<ArgumentException>(() =>
            service.UpdateMeetAsync(new SwimMeet { SwimMeetId = 0 }));
    }
}
