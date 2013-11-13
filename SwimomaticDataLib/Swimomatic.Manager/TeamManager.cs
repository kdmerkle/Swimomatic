namespace Swimomatic.Manager
{
    
    
    public class TeamManager : _TeamManager
    {
        
        #region  Constructor 
        public TeamManager()
        {
        }
        
        public TeamManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
