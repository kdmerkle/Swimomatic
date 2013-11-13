namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _RoleSystemUserManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 08/26/2010] - Generated by LAAF CodeGen
    // </history>
    public class _RoleSystemUserManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _RoleSystemUserManager()
        {
        }
        
        public _RoleSystemUserManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int RoleSystemUserSave(Swimomatic.Entity.RoleSystemUser RoleSystemUser)
        {
            return ((int)(ServiceProvider.RoleSystemUserSave(RoleSystemUser.RoleID, RoleSystemUser.RoleSystemUserID, RoleSystemUser.SystemUserID)));
        }
        
        public virtual void RoleSystemUserDelete(int RoleSystemUserID)
        {
            ServiceProvider.RoleSystemUserDelete(RoleSystemUserID);
        }
        
        public virtual Swimomatic.Entity.RoleSystemUser RoleSystemUserGet(int RoleSystemUserID)
        {
            return ((Swimomatic.Entity.RoleSystemUser)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.RoleSystemUser(), ServiceProvider.RoleSystemUserGet(RoleSystemUserID))));
        }
        
        public virtual Swimomatic.Entity.RoleSystemUserCollection RoleSystemUserGetAll()
        {
            return ((Swimomatic.Entity.RoleSystemUserCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.RoleSystemUser), typeof(Swimomatic.Entity.RoleSystemUserCollection), ServiceProvider.RoleSystemUserGetAll())));
        }
    }
}