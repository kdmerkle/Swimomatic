namespace Swimomatic.Manager
{
    
    
    public class StrokeManager : _StrokeManager
    {
        
        #region  Constructor 
        public StrokeManager()
        {
        }
        
        public StrokeManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
