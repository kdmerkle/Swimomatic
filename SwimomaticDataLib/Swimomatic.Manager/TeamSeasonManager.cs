namespace Swimomatic.Manager
{
    
    
    public class TeamSeasonManager : _TeamSeasonManager
    {
        
        #region  Constructor 
        public TeamSeasonManager()
        {
        }
        
        public TeamSeasonManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
