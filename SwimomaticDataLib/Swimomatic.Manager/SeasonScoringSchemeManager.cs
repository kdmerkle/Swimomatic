namespace Swimomatic.Manager
{
    
    
    public class SeasonScoringSchemeManager : _SeasonScoringSchemeManager
    {
        
        #region  Constructor 
        public SeasonScoringSchemeManager()
        {
        }
        
        public SeasonScoringSchemeManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
