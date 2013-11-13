namespace Swimomatic.Manager
{
    
    
    public class TeamLeagueRequestManager : _TeamLeagueRequestManager
    {
        
        #region  Constructor 
        public TeamLeagueRequestManager()
        {
        }
        
        public TeamLeagueRequestManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
