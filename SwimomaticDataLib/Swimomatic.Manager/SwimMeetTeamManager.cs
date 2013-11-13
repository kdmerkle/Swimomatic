namespace Swimomatic.Manager
{
    
    
    public class SwimMeetTeamManager : _SwimMeetTeamManager
    {
        
        #region  Constructor 
        public SwimMeetTeamManager()
        {
        }
        
        public SwimMeetTeamManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
