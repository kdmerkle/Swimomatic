namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _HeatSheetManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 10/06/2010] - Generated by LAAF CodeGen
    // </history>
    public class _HeatSheetManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _HeatSheetManager()
        {
        }
        
        public _HeatSheetManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int HeatSheetSave(Swimomatic.Entity.HeatSheet HeatSheet)
        {
            return ((int)(ServiceProvider.HeatSheetSave(HeatSheet.HeatSheetID, HeatSheet.PoolConfigID, HeatSheet.SwimMeetID)));
        }
        
        public virtual void HeatSheetDelete(int HeatSheetID)
        {
            ServiceProvider.HeatSheetDelete(HeatSheetID);
        }
        
        public virtual Swimomatic.Entity.HeatSheet HeatSheetGet(int HeatSheetID)
        {
            return ((Swimomatic.Entity.HeatSheet)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.HeatSheet(), ServiceProvider.HeatSheetGet(HeatSheetID))));
        }
        
        public virtual Swimomatic.Entity.HeatSheetCollection HeatSheetGetAllBySwimMeetID(int SwimMeetID)
        {
            return ((Swimomatic.Entity.HeatSheetCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.HeatSheet), typeof(Swimomatic.Entity.HeatSheetCollection), ServiceProvider.HeatSheetGetAllBySwimMeetID(SwimMeetID))));
        }
    }
}