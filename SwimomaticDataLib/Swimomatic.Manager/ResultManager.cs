namespace Swimomatic.Manager
{
    
    
    public class ResultManager : _ResultManager
    {
        
        #region  Constructor 
        public ResultManager()
        {
        }
        
        public ResultManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
