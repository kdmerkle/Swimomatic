namespace SwimDomain.Models;

public class SwimResult
{
    public int ResultId { get; set; }
    public int TenantId { get; set; }
    public int HeatSwimmerId { get; set; }
    public decimal? ElapsedTime { get; set; }
    public bool IsDQ { get; set; }
    public decimal? Score { get; set; }
    public string MeasurementType { get; set; } = "Time";
    public decimal? MeasurementValue { get; set; }
    public DateTime CreatedDate { get; set; }
}
