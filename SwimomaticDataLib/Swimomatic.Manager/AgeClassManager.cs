namespace Swimomatic.Manager
{
    
    
    public class AgeClassManager : _AgeClassManager
    {
        
        #region  Constructor 
        public AgeClassManager()
        {
        }
        
        public AgeClassManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
