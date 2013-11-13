namespace Swimomatic.Manager
{
    
    
    public class UserSwimMeetManager : _UserSwimMeetManager
    {
        
        #region  Constructor 
        public UserSwimMeetManager()
        {
        }
        
        public UserSwimMeetManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
