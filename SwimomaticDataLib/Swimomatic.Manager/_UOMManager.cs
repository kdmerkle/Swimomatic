namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _UOMManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 08/03/2009] - Generated by LAAF CodeGen
    // </history>
    public class _UOMManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _UOMManager()
        {
        }
        
        public _UOMManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int UOMSave(Swimomatic.Entity.UOM UOM)
        {
            return ((int)(ServiceProvider.UOMSave(UOM.Abbrev, UOM.Description, UOM.UOMID)));
        }
        
        public virtual void UOMDelete(int UOMID)
        {
            ServiceProvider.UOMDelete(UOMID);
        }
        
        public virtual Swimomatic.Entity.UOM UOMGet(int UOMID)
        {
            return ((Swimomatic.Entity.UOM)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.UOM(), ServiceProvider.UOMGet(UOMID))));
        }
        
        public virtual Swimomatic.Entity.UOMCollection UOMGetAll()
        {
            return ((Swimomatic.Entity.UOMCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.UOM), typeof(Swimomatic.Entity.UOMCollection), ServiceProvider.UOMGetAll())));
        }
    }
}
