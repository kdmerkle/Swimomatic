namespace Swimomatic.Manager
{
    
    
    public class SwimEventManager : _SwimEventManager
    {
        
        #region  Constructor 
        public SwimEventManager()
        {
        }
        
        public SwimEventManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
