namespace Swimomatic.Manager
{
    
    
    public class AgeClassRuleManager : _AgeClassRuleManager
    {
        
        #region  Constructor 
        public AgeClassRuleManager()
        {
        }
        
        public AgeClassRuleManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
