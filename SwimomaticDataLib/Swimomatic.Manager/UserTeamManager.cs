namespace Swimomatic.Manager
{
    
    
    public class UserTeamManager : _UserTeamManager
    {
        
        #region  Constructor 
        public UserTeamManager()
        {
        }
        
        public UserTeamManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
