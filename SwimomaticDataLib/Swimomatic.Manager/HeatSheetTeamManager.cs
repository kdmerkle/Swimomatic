namespace Swimomatic.Manager
{
    
    
    public class HeatSheetTeamManager : _HeatSheetTeamManager
    {
        
        #region  Constructor 
        public HeatSheetTeamManager()
        {
        }
        
        public HeatSheetTeamManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
