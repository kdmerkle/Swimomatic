namespace Swimomatic.Manager
{
    
    
    public class ProfileSystemUserManager : _ProfileSystemUserManager
    {
        
        #region  Constructor 
        public ProfileSystemUserManager()
        {
        }
        
        public ProfileSystemUserManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
