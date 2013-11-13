namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _AgeClassRuleManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 08/05/2010] - Generated by LAAF CodeGen
    // </history>
    public class _AgeClassRuleManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _AgeClassRuleManager()
        {
        }
        
        public _AgeClassRuleManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual Swimomatic.Entity.AgeClassRule AgeClassRuleGet(int AgeClassRuleID)
        {
            return ((Swimomatic.Entity.AgeClassRule)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.AgeClassRule(), ServiceProvider.AgeClassRuleGet(AgeClassRuleID))));
        }
        
        public virtual Swimomatic.Entity.AgeClassRuleCollection AgeClassRuleGetAll()
        {
            return ((Swimomatic.Entity.AgeClassRuleCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.AgeClassRule), typeof(Swimomatic.Entity.AgeClassRuleCollection), ServiceProvider.AgeClassRuleGetAll())));
        }
    }
}
