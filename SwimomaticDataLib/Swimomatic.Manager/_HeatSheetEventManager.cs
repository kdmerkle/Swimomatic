namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _HeatSheetEventManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 05/16/2011] - Generated by LAAF CodeGen
    // </history>
    public class _HeatSheetEventManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _HeatSheetEventManager()
        {
        }
        
        public _HeatSheetEventManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int HeatSheetEventSave(Swimomatic.Entity.HeatSheetEvent HeatSheetEvent)
        {
            return ((int)(ServiceProvider.HeatSheetEventSave(HeatSheetEvent.Distance, HeatSheetEvent.HeatSheetEventID, HeatSheetEvent.HeatSheetID, HeatSheetEvent.Sequence, HeatSheetEvent.SwimEventID)));
        }
        
        public virtual void HeatSheetEventDelete(int HeatSheetEventID)
        {
            ServiceProvider.HeatSheetEventDelete(HeatSheetEventID);
        }
        
        public virtual Swimomatic.Entity.HeatSheetEvent HeatSheetEventGet(int HeatSheetEventID)
        {
            return ((Swimomatic.Entity.HeatSheetEvent)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.HeatSheetEvent(), ServiceProvider.HeatSheetEventGet(HeatSheetEventID))));
        }
        
        public virtual Swimomatic.Entity.HeatSheetEventCollection HeatSheetEventGetAll()
        {
            return ((Swimomatic.Entity.HeatSheetEventCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.HeatSheetEvent), typeof(Swimomatic.Entity.HeatSheetEventCollection), ServiceProvider.HeatSheetEventGetAll())));
        }
        
        public virtual Swimomatic.Entity.HeatSheetEvent HeatSheetEventGetByHeatSwimmerID(int HeatSwimmerID)
        {
            return ((Swimomatic.Entity.HeatSheetEvent)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.HeatSheetEvent(), ServiceProvider.HeatSheetEventGetByHeatSwimmerID(HeatSwimmerID))));
        }
        
        public virtual Swimomatic.Entity.HeatSheetEvent HeatSheetEventGetByHeatID(int HeatID)
        {
            return ((Swimomatic.Entity.HeatSheetEvent)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.HeatSheetEvent(), ServiceProvider.HeatSheetEventGetByHeatID(HeatID))));
        }
        
        public virtual Swimomatic.Entity.HeatSheetEvent HeatSheetEventGetByDistanceSwimEventIDHeatSheetID(int Distance, int HeatSheetID, int SwimEventID)
        {
            return ((Swimomatic.Entity.HeatSheetEvent)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.HeatSheetEvent(), ServiceProvider.HeatSheetEventGetByDistanceSwimEventIDHeatSheetID(Distance, HeatSheetID, SwimEventID))));
        }
        
        public virtual Swimomatic.Entity.HeatSheetEventCollection HeatSheetEventGetAllByHeatSheetID(int HeatSheetID)
        {
            return ((Swimomatic.Entity.HeatSheetEventCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.HeatSheetEvent), typeof(Swimomatic.Entity.HeatSheetEventCollection), ServiceProvider.HeatSheetEventGetAllByHeatSheetID(HeatSheetID))));
        }
        
        public virtual Swimomatic.Entity.HeatSheetEventCollection HeatSheetEventGetAllByHeatSheetIDSystemUserID(int HeatSheetID, int SystemUserID)
        {
            return ((Swimomatic.Entity.HeatSheetEventCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.HeatSheetEvent), typeof(Swimomatic.Entity.HeatSheetEventCollection), ServiceProvider.HeatSheetEventGetAllByHeatSheetIDSystemUserID(HeatSheetID, SystemUserID))));
        }
    }
}