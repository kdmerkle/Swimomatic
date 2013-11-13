namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _ProfileSystemUserManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 08/26/2010] - Generated by LAAF CodeGen
    // </history>
    public class _ProfileSystemUserManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _ProfileSystemUserManager()
        {
        }
        
        public _ProfileSystemUserManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int ProfileSystemUserSave(Swimomatic.Entity.ProfileSystemUser ProfileSystemUser)
        {
            return ((int)(ServiceProvider.ProfileSystemUserSave(ProfileSystemUser.ProfileID, ProfileSystemUser.ProfileSystemUserID, ProfileSystemUser.SystemUserID)));
        }
        
        public virtual void ProfileSystemUserDelete(int ProfileSystemUserID)
        {
            ServiceProvider.ProfileSystemUserDelete(ProfileSystemUserID);
        }
        
        public virtual Swimomatic.Entity.ProfileSystemUser ProfileSystemUserGet(int ProfileSystemUserID)
        {
            return ((Swimomatic.Entity.ProfileSystemUser)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.ProfileSystemUser(), ServiceProvider.ProfileSystemUserGet(ProfileSystemUserID))));
        }
        
        public virtual Swimomatic.Entity.ProfileSystemUserCollection ProfileSystemUserGetAll()
        {
            return ((Swimomatic.Entity.ProfileSystemUserCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.ProfileSystemUser), typeof(Swimomatic.Entity.ProfileSystemUserCollection), ServiceProvider.ProfileSystemUserGetAll())));
        }
    }
}
