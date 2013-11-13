namespace Swimomatic.Manager
{
    
    
    public class PoolManager : _PoolManager
    {
        
        #region  Constructor 
        public PoolManager()
        {
        }
        
        public PoolManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
