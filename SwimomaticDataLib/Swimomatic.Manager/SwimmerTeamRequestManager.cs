namespace Swimomatic.Manager
{
    
    
    public class SwimmerTeamRequestManager : _SwimmerTeamRequestManager
    {
        
        #region  Constructor 
        public SwimmerTeamRequestManager()
        {
        }
        
        public SwimmerTeamRequestManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
