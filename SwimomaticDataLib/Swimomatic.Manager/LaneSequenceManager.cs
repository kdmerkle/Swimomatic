namespace Swimomatic.Manager
{
    
    
    public class LaneSequenceManager : _LaneSequenceManager
    {
        
        #region  Constructor 
        public LaneSequenceManager()
        {
        }
        
        public LaneSequenceManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
