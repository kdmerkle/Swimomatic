namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _RoleManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 08/26/2010] - Generated by LAAF CodeGen
    // </history>
    public class _RoleManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _RoleManager()
        {
        }
        
        public _RoleManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int RoleSave(Swimomatic.Entity.Role Role)
        {
            return ((int)(ServiceProvider.RoleSave(Role.Description, Role.IsActive, Role.RoleID, Role.RoleName)));
        }
        
        public virtual void RoleDelete(int RoleID)
        {
            ServiceProvider.RoleDelete(RoleID);
        }
        
        public virtual Swimomatic.Entity.Role RoleGet(int RoleID)
        {
            return ((Swimomatic.Entity.Role)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.Role(), ServiceProvider.RoleGet(RoleID))));
        }
        
        public virtual Swimomatic.Entity.RoleCollection RoleGetAll()
        {
            return ((Swimomatic.Entity.RoleCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.Role), typeof(Swimomatic.Entity.RoleCollection), ServiceProvider.RoleGetAll())));
        }
    }
}
