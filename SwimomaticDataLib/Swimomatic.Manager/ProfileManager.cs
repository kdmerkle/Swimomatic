namespace Swimomatic.Manager
{
    
    
    public class ProfileManager : _ProfileManager
    {
        
        #region  Constructor 
        public ProfileManager()
        {
        }
        
        public ProfileManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
