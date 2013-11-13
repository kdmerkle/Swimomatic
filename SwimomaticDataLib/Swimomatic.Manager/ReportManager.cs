namespace Swimomatic.Manager
{
    
    
    public class ReportManager : _ReportManager
    {
        
        #region  Constructor 
        public ReportManager()
        {
        }
        
        public ReportManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
