namespace Swimomatic.Manager
{
    
    
    public class SwimmerManager : _SwimmerManager
    {
        
        #region  Constructor 
        public SwimmerManager()
        {
        }
        
        public SwimmerManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
