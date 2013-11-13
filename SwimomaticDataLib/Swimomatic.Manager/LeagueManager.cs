namespace Swimomatic.Manager
{
    
    
    public class LeagueManager : _LeagueManager
    {
        
        #region  Constructor 
        public LeagueManager()
        {
        }
        
        public LeagueManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
