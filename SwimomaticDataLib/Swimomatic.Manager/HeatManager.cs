namespace Swimomatic.Manager
{
    
    
    public class HeatManager : _HeatManager
    {
        
        #region  Constructor 
        public HeatManager()
        {
        }
        
        public HeatManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion
    }
}
