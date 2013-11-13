namespace Swimomatic.Manager
{
    
    
    public class UserSwimmerManager : _UserSwimmerManager
    {
        
        #region  Constructor 
        public UserSwimmerManager()
        {
        }
        
        public UserSwimmerManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
