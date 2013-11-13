namespace Swimomatic.Manager
{
    
    
    public class SwimmerTeamSeasonManager : _SwimmerTeamSeasonManager
    {
        
        #region  Constructor 
        public SwimmerTeamSeasonManager()
        {
        }
        
        public SwimmerTeamSeasonManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
