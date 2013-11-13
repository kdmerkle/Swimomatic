namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _SplitManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 01/29/2011] - Generated by LAAF CodeGen
    // </history>
    public class _SplitManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _SplitManager()
        {
        }
        
        public _SplitManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int SplitSave(Swimomatic.Entity.Split Split)
        {
            return ((int)(ServiceProvider.SplitSave(Split.ResultID, Split.SplitID, Split.SplitTime)));
        }
        
        public virtual void SplitDelete(int SplitID)
        {
            ServiceProvider.SplitDelete(SplitID);
        }
        
        public virtual Swimomatic.Entity.Split SplitGet(int SplitID)
        {
            return ((Swimomatic.Entity.Split)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.Split(), ServiceProvider.SplitGet(SplitID))));
        }
        
        public virtual Swimomatic.Entity.SplitCollection SplitGetAll()
        {
            return ((Swimomatic.Entity.SplitCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.Split), typeof(Swimomatic.Entity.SplitCollection), ServiceProvider.SplitGetAll())));
        }
    }
}
