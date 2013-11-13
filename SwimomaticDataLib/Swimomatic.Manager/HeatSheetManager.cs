namespace Swimomatic.Manager
{
    
    
    public class HeatSheetManager : _HeatSheetManager
    {
        
        #region  Constructor 
        public HeatSheetManager()
        {
        }
        
        public HeatSheetManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
