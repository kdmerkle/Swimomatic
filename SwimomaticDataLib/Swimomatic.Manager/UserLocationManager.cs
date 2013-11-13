namespace Swimomatic.Manager
{
    
    
    public class UserLocationManager : _UserLocationManager
    {
        
        #region  Constructor 
        public UserLocationManager()
        {
        }
        
        public UserLocationManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
