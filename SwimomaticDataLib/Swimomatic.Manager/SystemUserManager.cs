namespace Swimomatic.Manager
{
    
    
    public class SystemUserManager : _SystemUserManager
    {
        
        #region  Constructor 
        public SystemUserManager()
        {
        }
        
        public SystemUserManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
