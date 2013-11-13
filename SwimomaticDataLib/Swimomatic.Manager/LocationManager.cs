namespace Swimomatic.Manager
{
    
    
    public class LocationManager : _LocationManager
    {
        
        #region  Constructor 
        public LocationManager()
        {
        }
        
        public LocationManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
