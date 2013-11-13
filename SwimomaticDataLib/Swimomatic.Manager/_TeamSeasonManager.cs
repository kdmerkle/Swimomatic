namespace Swimomatic.Manager
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _TeamSeasonManager class is the base manager class.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 05/15/2011] - Generated by LAAF CodeGen
    // </history>
    public class _TeamSeasonManager
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        #region  Constructor 
        public _TeamSeasonManager()
        {
        }
        
        public _TeamSeasonManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider)
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
        
        public virtual int TeamSeasonSave(Swimomatic.Entity.TeamSeason TeamSeason)
        {
            return ((int)(ServiceProvider.TeamSeasonSave(TeamSeason.AgeClassRuleID, TeamSeason.LeagueID, TeamSeason.SeasonID, TeamSeason.TeamID, TeamSeason.TeamSeasonID)));
        }
        
        public virtual void TeamSeasonDelete(int TeamSeasonID)
        {
            ServiceProvider.TeamSeasonDelete(TeamSeasonID);
        }
        
        public virtual Swimomatic.Entity.TeamSeason TeamSeasonGet(int TeamSeasonID)
        {
            return ((Swimomatic.Entity.TeamSeason)(LAAF.Data.Helper.MapDataToLAEntity(new Swimomatic.Entity.TeamSeason(), ServiceProvider.TeamSeasonGet(TeamSeasonID))));
        }
        
        public virtual Swimomatic.Entity.TeamSeasonCollection TeamSeasonGetAllBySystemUserID(int SystemUserID)
        {
            return ((Swimomatic.Entity.TeamSeasonCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.TeamSeason), typeof(Swimomatic.Entity.TeamSeasonCollection), ServiceProvider.TeamSeasonGetAllBySystemUserID(SystemUserID))));
        }
        
        public virtual Swimomatic.Entity.TeamSeasonCollection TeamSeasonGetAllByHeatSheetEventID(int HeatSheetEventID)
        {
            return ((Swimomatic.Entity.TeamSeasonCollection)(LAAF.Data.Helper.MapDataToLAEntityCollection(typeof(Swimomatic.Entity.TeamSeason), typeof(Swimomatic.Entity.TeamSeasonCollection), ServiceProvider.TeamSeasonGetAllByHeatSheetEventID(HeatSheetEventID))));
        }
    }
}