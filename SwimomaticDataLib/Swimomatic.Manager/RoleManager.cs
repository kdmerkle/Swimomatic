namespace Swimomatic.Manager
{
    
    
    public class RoleManager : _RoleManager
    {
        
        #region  Constructor 
        public RoleManager()
        {
        }
        
        public RoleManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
