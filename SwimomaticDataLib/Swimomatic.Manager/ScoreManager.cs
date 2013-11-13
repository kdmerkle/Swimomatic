namespace Swimomatic.Manager
{
    
    
    public class ScoreManager : _ScoreManager
    {
        
        #region  Constructor 
        public ScoreManager()
        {
        }
        
        public ScoreManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
