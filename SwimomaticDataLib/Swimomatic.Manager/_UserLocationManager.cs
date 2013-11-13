namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _UserLocationManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 09/29/2010] - Generated by LAAF CodeGen
    // </history>
    public class _UserLocationManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _UserLocationManager()
        {
        }
        
        public _UserLocationManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
        {
            _ServiceProvider = serviceProvider;
        }
        #endregion
        
        #region  Service Provider 
        public virtual Swimomatic.ServiceProvider.SwimomaticServiceProvider ServiceProvider
        {
            get
            {
                if ((_ServiceProvider == null))
                {
                    _ServiceProvider = Swimomatic.ServiceProvider.SwimomaticServiceProvider.GetInstance();
                }
                return _ServiceProvider;
            }
        }
        #endregion
        
        public virtual int UserLocationSave(Swimomatic.Entity.UserLocation UserLocation)
        {
            return ((int)(ServiceProvider.UserLocationSave(UserLocation.LocationID, UserLocation.SystemUserID, UserLocation.UserLocationID)));
        }
        
        public virtual void UserLocationDelete(int UserLocationID)
        {
            ServiceProvider.UserLocationDelete(UserLocationID);
        }
        
        public virtual Swimomatic.Entity.UserLocation UserLocationGet(int UserLocationID)
        {
            return ((Swimomatic.Entity.UserLocation)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.UserLocation(), ServiceProvider.UserLocationGet(UserLocationID))));
        }
    }
}