namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _SystemUserManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 06/24/2011] - Generated by LAAF CodeGen
    // </history>
    public class _SystemUserManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _SystemUserManager()
        {
        }
        
        public _SystemUserManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int SystemUserSave(Swimomatic.Entity.SystemUser SystemUser)
        {
            return ((int)(ServiceProvider.SystemUserSave(SystemUser.City, SystemUser.CreateDate, SystemUser.Email, SystemUser.FirstName, SystemUser.IsActive, SystemUser.LastName, SystemUser.ModifiedDate, SystemUser.Password, SystemUser.RegionID, SystemUser.RegistrationKey, SystemUser.ResetPassword, SystemUser.SystemUserID, SystemUser.TemporaryPassword, SystemUser.UserName)));
        }
        
        public virtual void SystemUserDelete(int SystemUserID)
        {
            ServiceProvider.SystemUserDelete(SystemUserID);
        }
        
        public virtual Swimomatic.Entity.SystemUser SystemUserGet(int SystemUserID)
        {
            return ((Swimomatic.Entity.SystemUser)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.SystemUser(), ServiceProvider.SystemUserGet(SystemUserID))));
        }
        
        public virtual Swimomatic.Entity.SystemUserCollection SystemUserGetAll()
        {
            return ((Swimomatic.Entity.SystemUserCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.SystemUser), typeof(Swimomatic.Entity.SystemUserCollection), ServiceProvider.SystemUserGetAll())));
        }
        
        public virtual Swimomatic.Entity.SystemUser SystemUserGetByUserNamePassword(string UserName, string Password)
        {
            return ((Swimomatic.Entity.SystemUser)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.SystemUser(), ServiceProvider.SystemUserGetByUserNamePassword(UserName, Password))));
        }
        
        public virtual Swimomatic.Entity.SystemUser SystemUserGetByEmail(string Email)
        {
            return ((Swimomatic.Entity.SystemUser)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.SystemUser(), ServiceProvider.SystemUserGetByEmail(Email))));
        }
        
        public virtual Swimomatic.Entity.SystemUser SystemUserGetByRegistrationKey(System.Guid RegistrationKey)
        {
            return ((Swimomatic.Entity.SystemUser)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.SystemUser(), ServiceProvider.SystemUserGetByRegistrationKey(RegistrationKey))));
        }
        
        public virtual Swimomatic.Entity.SystemUser SystemUserGetByUserName(string UserName)
        {
            return ((Swimomatic.Entity.SystemUser)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.SystemUser(), ServiceProvider.SystemUserGetByUserName(UserName))));
        }
        
        public virtual Swimomatic.Entity.SystemUserCollection SystemUserGetAllByResetPassword()
        {
            return ((Swimomatic.Entity.SystemUserCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.SystemUser), typeof(Swimomatic.Entity.SystemUserCollection), ServiceProvider.SystemUserGetAllByResetPassword())));
        }
    }
}
