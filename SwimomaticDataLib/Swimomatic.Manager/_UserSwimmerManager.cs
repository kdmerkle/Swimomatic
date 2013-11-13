namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _UserSwimmerManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 09/09/2010] - Generated by LAAF CodeGen
    // </history>
    public class _UserSwimmerManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _UserSwimmerManager()
        {
        }
        
        public _UserSwimmerManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int UserSwimmerSave(Swimomatic.Entity.UserSwimmer UserSwimmer)
        {
            return ((int)(ServiceProvider.UserSwimmerSave(UserSwimmer.SwimmerID, UserSwimmer.SystemUserID, UserSwimmer.UserSwimmerID)));
        }
        
        public virtual void UserSwimmerDelete(int UserSwimmerID)
        {
            ServiceProvider.UserSwimmerDelete(UserSwimmerID);
        }
        
        public virtual Swimomatic.Entity.UserSwimmer UserSwimmerGet(int UserSwimmerID)
        {
            return ((Swimomatic.Entity.UserSwimmer)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.UserSwimmer(), ServiceProvider.UserSwimmerGet(UserSwimmerID))));
        }
        
        public virtual Swimomatic.Entity.UserSwimmerCollection UserSwimmerGetAll()
        {
            return ((Swimomatic.Entity.UserSwimmerCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.UserSwimmer), typeof(Swimomatic.Entity.UserSwimmerCollection), ServiceProvider.UserSwimmerGetAll())));
        }
        
        public virtual Swimomatic.Entity.UserSwimmerCollection UserSwimmerGetAllBySystemUserID(int SystemUserID)
        {
            return ((Swimomatic.Entity.UserSwimmerCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.UserSwimmer), typeof(Swimomatic.Entity.UserSwimmerCollection), ServiceProvider.UserSwimmerGetAllBySystemUserID(SystemUserID))));
        }
    }
}