namespace Swimomatic.Manager
{
    
    
    public class UserLeagueManager : _UserLeagueManager
    {
        
        #region  Constructor 
        public UserLeagueManager()
        {
        }
        
        public UserLeagueManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
