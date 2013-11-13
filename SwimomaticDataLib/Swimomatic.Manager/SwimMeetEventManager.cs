namespace Swimomatic.Manager
{
    
    
    public class SwimMeetEventManager : _SwimMeetEventManager
    {
        
        #region  Constructor 
        public SwimMeetEventManager()
        {
        }
        
        public SwimMeetEventManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
