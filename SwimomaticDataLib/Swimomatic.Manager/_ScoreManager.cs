namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _ScoreManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 04/04/2011] - Generated by LAAF CodeGen
    // </history>
    public class _ScoreManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _ScoreManager()
        {
        }
        
        public _ScoreManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual Swimomatic.Entity.ScoreCollection ScoreGetAllBySwimMeetID(int SwimMeetID)
        {
            return ((Swimomatic.Entity.ScoreCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.Score), typeof(Swimomatic.Entity.ScoreCollection), ServiceProvider.ScoreGetAllBySwimMeetID(SwimMeetID))));
        }
        
        public virtual Swimomatic.Entity.ScoreCollection ScoreGetAllBySwimmerIDSwimMeetID(int SwimmerID, int SwimMeetID)
        {
            return ((Swimomatic.Entity.ScoreCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.Score), typeof(Swimomatic.Entity.ScoreCollection), ServiceProvider.ScoreGetAllBySwimmerIDSwimMeetID(SwimmerID, SwimMeetID))));
        }
        
        public virtual Swimomatic.Entity.ScoreCollection ScoreGetTotalBySwimMeetID(int SwimMeetID)
        {
            return ((Swimomatic.Entity.ScoreCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.Score), typeof(Swimomatic.Entity.ScoreCollection), ServiceProvider.ScoreGetTotalBySwimMeetID(SwimMeetID))));
        }
        
        public virtual Swimomatic.Entity.ScoreCollection ScoreGetAllBySystemUserIDAsSwimmer(int SystemUserID)
        {
            return ((Swimomatic.Entity.ScoreCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.Score), typeof(Swimomatic.Entity.ScoreCollection), ServiceProvider.ScoreGetAllBySystemUserIDAsSwimmer(SystemUserID))));
        }
        
        public virtual Swimomatic.Entity.ScoreCollection ScoreGetAllBySwimMeetIDSystemUserID(int SwimMeetID, int SystemUserID)
        {
            return ((Swimomatic.Entity.ScoreCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.Score), typeof(Swimomatic.Entity.ScoreCollection), ServiceProvider.ScoreGetAllBySwimMeetIDSystemUserID(SwimMeetID, SystemUserID))));
        }
    }
}
