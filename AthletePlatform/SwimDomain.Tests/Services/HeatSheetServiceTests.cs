using Moq;
using SwimDomain.Models;
using SwimDomain.Repositories;
using SwimDomain.Services;

namespace SwimDomain.Tests.Services;

public class HeatSheetServiceTests
{
    private readonly Mock<IHeatSheetRepository> _mockHeatRepo = new();

    private HeatSheetService CreateService() => new(_mockHeatRepo.Object);

    [Fact]
    public async Task GenerateHeats_12SwimmersWith6Lanes_Creates2Heats()
    {
        // Arrange
        var swimmers = Enumerable.Range(1, 12)
            .Select(i => new HeatSwimmer { AthleteId = i, TenantId = 1, SeedTime = (decimal)(i * 10) })
            .ToList();
        _mockHeatRepo.Setup(r => r.GetSwimmersBySeedTimeAsync(It.IsAny<int>())).ReturnsAsync(swimmers);
        _mockHeatRepo.Setup(r => r.ClearSwimmersAsync(It.IsAny<int>())).Returns(Task.CompletedTask);
        _mockHeatRepo.Setup(r => r.SaveHeatAsync(It.IsAny<Heat>())).ReturnsAsync((Heat h) => h.HeatNumber);
        _mockHeatRepo.Setup(r => r.SaveHeatSwimmerAsync(It.IsAny<HeatSwimmer>())).ReturnsAsync(1);
        var service = CreateService();

        // Act
        await service.GenerateHeatsAsync(1, laneCount: 6, SeedType.MostRecent);

        // Assert — SaveHeatAsync called exactly 2 times (2 heats)
        _mockHeatRepo.Verify(r => r.SaveHeatAsync(It.IsAny<Heat>()), Times.Exactly(2));
    }

    [Fact]
    public async Task GenerateHeats_7SwimmersWith6Lanes_Creates2Heats()
    {
        var swimmers = Enumerable.Range(1, 7)
            .Select(i => new HeatSwimmer { AthleteId = i, TenantId = 1, SeedTime = (decimal)(i * 10) })
            .ToList();
        _mockHeatRepo.Setup(r => r.GetSwimmersBySeedTimeAsync(It.IsAny<int>())).ReturnsAsync(swimmers);
        _mockHeatRepo.Setup(r => r.ClearSwimmersAsync(It.IsAny<int>())).Returns(Task.CompletedTask);
        _mockHeatRepo.Setup(r => r.SaveHeatAsync(It.IsAny<Heat>())).ReturnsAsync((Heat h) => h.HeatNumber);
        _mockHeatRepo.Setup(r => r.SaveHeatSwimmerAsync(It.IsAny<HeatSwimmer>())).ReturnsAsync(1);
        var service = CreateService();

        await service.GenerateHeatsAsync(1, laneCount: 6, SeedType.MostRecent);

        _mockHeatRepo.Verify(r => r.SaveHeatAsync(It.IsAny<Heat>()), Times.Exactly(2));
    }

    [Fact]
    public async Task GenerateHeats_0Swimmers_Creates0Heats()
    {
        _mockHeatRepo.Setup(r => r.GetSwimmersBySeedTimeAsync(It.IsAny<int>()))
            .ReturnsAsync(Enumerable.Empty<HeatSwimmer>());
        _mockHeatRepo.Setup(r => r.ClearSwimmersAsync(It.IsAny<int>())).Returns(Task.CompletedTask);
        var service = CreateService();

        await service.GenerateHeatsAsync(1, laneCount: 6, SeedType.MostRecent);

        _mockHeatRepo.Verify(r => r.SaveHeatAsync(It.IsAny<Heat>()), Times.Never);
    }
}
