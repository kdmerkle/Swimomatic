namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _SwimmerTeamSeasonManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 08/03/2009] - Generated by LAAF CodeGen
    // </history>
    public class _SwimmerTeamSeasonManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _SwimmerTeamSeasonManager()
        {
        }
        
        public _SwimmerTeamSeasonManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int SwimmerTeamSeasonSave(Swimomatic.Entity.SwimmerTeamSeason SwimmerTeamSeason)
        {
            return ((int)(ServiceProvider.SwimmerTeamSeasonSave(SwimmerTeamSeason.EndDate, SwimmerTeamSeason.StartDate, SwimmerTeamSeason.SwimmerID, SwimmerTeamSeason.SwimmerTeamSeasonID, SwimmerTeamSeason.TeamSeasonID)));
        }
        
        public virtual void SwimmerTeamSeasonDelete(int SwimmerTeamSeasonID)
        {
            ServiceProvider.SwimmerTeamSeasonDelete(SwimmerTeamSeasonID);
        }
        
        public virtual Swimomatic.Entity.SwimmerTeamSeason SwimmerTeamSeasonGet(int SwimmerTeamSeasonID)
        {
            return ((Swimomatic.Entity.SwimmerTeamSeason)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.SwimmerTeamSeason(), ServiceProvider.SwimmerTeamSeasonGet(SwimmerTeamSeasonID))));
        }
        
        public virtual Swimomatic.Entity.SwimmerTeamSeasonCollection SwimmerTeamSeasonGetAllBySwimmerID(int SwimmerID)
        {
            return ((Swimomatic.Entity.SwimmerTeamSeasonCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.SwimmerTeamSeason), typeof(Swimomatic.Entity.SwimmerTeamSeasonCollection), ServiceProvider.SwimmerTeamSeasonGetAllBySwimmerID(SwimmerID))));
        }
    }
}
