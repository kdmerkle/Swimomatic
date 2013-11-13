namespace Swimomatic.Manager
{
    
    
    public class ScoringSchemeManager : _ScoringSchemeManager
    {
        
        #region  Constructor 
        public ScoringSchemeManager()
        {
        }
        
        public ScoringSchemeManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
