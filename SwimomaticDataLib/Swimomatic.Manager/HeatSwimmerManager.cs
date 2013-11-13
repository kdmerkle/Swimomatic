namespace Swimomatic.Manager
{
    
    
    public class HeatSwimmerManager : _HeatSwimmerManager
    {
        
        #region  Constructor 
        public HeatSwimmerManager()
        {
        }
        
        public HeatSwimmerManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
