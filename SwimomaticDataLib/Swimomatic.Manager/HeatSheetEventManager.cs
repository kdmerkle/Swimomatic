namespace Swimomatic.Manager
{
    
    
    public class HeatSheetEventManager : _HeatSheetEventManager
    {
        
        #region  Constructor 
        public HeatSheetEventManager()
        {
        }
        
        public HeatSheetEventManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
