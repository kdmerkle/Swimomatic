namespace Swimomatic.Manager
{
    
    
    public class RoleSystemUserManager : _RoleSystemUserManager
    {
        
        #region  Constructor 
        public RoleSystemUserManager()
        {
        }
        
        public RoleSystemUserManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
