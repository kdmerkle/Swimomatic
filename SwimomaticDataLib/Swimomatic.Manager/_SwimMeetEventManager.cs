namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _SwimMeetEventManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Generated on 10/01/2010] - Generated by LAAF CodeGen
    // </history>
    public class _SwimMeetEventManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _SwimMeetEventManager()
        {
        }
        
        public _SwimMeetEventManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int SwimMeetEventSave(Swimomatic.Entity.SwimMeetEvent SwimMeetEvent)
        {
            return ((int)(ServiceProvider.SwimMeetEventSave(SwimMeetEvent.Distance, SwimMeetEvent.Sequence, SwimMeetEvent.SwimEventID, SwimMeetEvent.SwimMeetEventID, SwimMeetEvent.SwimMeetID)));
        }
        
        public virtual void SwimMeetEventDelete(int SwimMeetEventID)
        {
            ServiceProvider.SwimMeetEventDelete(SwimMeetEventID);
        }
        
        public virtual Swimomatic.Entity.SwimMeetEvent SwimMeetEventGet(int SwimMeetEventID)
        {
            return ((Swimomatic.Entity.SwimMeetEvent)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.SwimMeetEvent(), ServiceProvider.SwimMeetEventGet(SwimMeetEventID))));
        }
        
        public virtual Swimomatic.Entity.SwimMeetEventCollection SwimMeetEventGetAll()
        {
            return ((Swimomatic.Entity.SwimMeetEventCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.SwimMeetEvent), typeof(Swimomatic.Entity.SwimMeetEventCollection), ServiceProvider.SwimMeetEventGetAll())));
        }
        
        public virtual Swimomatic.Entity.SwimMeetEventCollection SwimMeetEventGetAllByPoolPoolConfigIDSwimMeetID(int PoolPoolConfigID, int SwimMeetID)
        {
            return ((Swimomatic.Entity.SwimMeetEventCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.SwimMeetEvent), typeof(Swimomatic.Entity.SwimMeetEventCollection), ServiceProvider.SwimMeetEventGetAllByPoolPoolConfigIDSwimMeetID(PoolPoolConfigID, SwimMeetID))));
        }
        
        public virtual Swimomatic.Entity.SwimMeetEvent SwimMeetEventGetByHeatSwimmerID(int HeatSwimmerID)
        {
            return ((Swimomatic.Entity.SwimMeetEvent)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.SwimMeetEvent(), ServiceProvider.SwimMeetEventGetByHeatSwimmerID(HeatSwimmerID))));
        }
        
        public virtual Swimomatic.Entity.SwimMeetEvent SwimMeetEventGetByHeatID(int HeatID)
        {
            return ((Swimomatic.Entity.SwimMeetEvent)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.SwimMeetEvent(), ServiceProvider.SwimMeetEventGetByHeatID(HeatID))));
        }
        
        public virtual Swimomatic.Entity.SwimMeetEvent SwimMeetEventGetByDistanceSwimEventIDSwimMeetID(int Distance, int SwimEventID, int SwimMeetID)
        {
            return ((Swimomatic.Entity.SwimMeetEvent)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.SwimMeetEvent(), ServiceProvider.SwimMeetEventGetByDistanceSwimEventIDSwimMeetID(Distance, SwimEventID, SwimMeetID))));
        }
    }
}