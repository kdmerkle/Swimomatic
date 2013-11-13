namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _ProfileManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 08/26/2010] - Generated by LAAF CodeGen
    // </history>
    public class _ProfileManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _ProfileManager()
        {
        }
        
        public _ProfileManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int ProfileSave(Swimomatic.Entity.Profile Profile)
        {
            return ((int)(ServiceProvider.ProfileSave(Profile.Description, Profile.IsActive, Profile.ProfileID, Profile.ProfileName)));
        }
        
        public virtual void ProfileDelete(int ProfileID)
        {
            ServiceProvider.ProfileDelete(ProfileID);
        }
        
        public virtual Swimomatic.Entity.Profile ProfileGet(int ProfileID)
        {
            return ((Swimomatic.Entity.Profile)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.Profile(), ServiceProvider.ProfileGet(ProfileID))));
        }
        
        public virtual Swimomatic.Entity.ProfileCollection ProfileGetAll()
        {
            return ((Swimomatic.Entity.ProfileCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.Profile), typeof(Swimomatic.Entity.ProfileCollection), ServiceProvider.ProfileGetAll())));
        }
    }
}
