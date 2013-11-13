namespace Swimomatic.Manager
{
    
    
    public class SwimMeetManager : _SwimMeetManager
    {
        
        #region  Constructor 
        public SwimMeetManager()
        {
        }
        
        public SwimMeetManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
