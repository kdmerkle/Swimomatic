namespace Swimomatic.Manager
{
    
    
    public class RegionManager : _RegionManager
    {
        
        #region  Constructor 
        public RegionManager()
        {
        }
        
        public RegionManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
