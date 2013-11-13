namespace Swimomatic
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The SwimomaticEntityContext class is the context for the project.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Generated on 02/29/2012] - Generated by LAAF CodeGen
    // </history>
    public class _SwimomaticEntityContext
    {
        
        private Swimomatic.ServiceProvider.SwimomaticServiceProvider _ServiceProvider;
        
        private Swimomatic.Manager.AgeClassManager _AgeClassManager;
        
        private Swimomatic.Manager.AgeClassRuleManager _AgeClassRuleManager;
        
        private Swimomatic.Manager.HeatManager _HeatManager;
        
        private Swimomatic.Manager.HeatSheetEventManager _HeatSheetEventManager;
        
        private Swimomatic.Manager.HeatSheetManager _HeatSheetManager;
        
        private Swimomatic.Manager.HeatSheetTeamManager _HeatSheetTeamManager;
        
        private Swimomatic.Manager.HeatSwimmerManager _HeatSwimmerManager;
        
        private Swimomatic.Manager.LaneSequenceManager _LaneSequenceManager;
        
        private Swimomatic.Manager.LeagueManager _LeagueManager;
        
        private Swimomatic.Manager.LocationManager _LocationManager;
        
        private Swimomatic.Manager.PoolConfigManager _PoolConfigManager;
        
        private Swimomatic.Manager.PoolManager _PoolManager;
        
        private Swimomatic.Manager.ProfileManager _ProfileManager;
        
        private Swimomatic.Manager.ProfileSystemUserManager _ProfileSystemUserManager;
        
        private Swimomatic.Manager.RegionManager _RegionManager;
        
        private Swimomatic.Manager.ReportManager _ReportManager;
        
        private Swimomatic.Manager.ResultManager _ResultManager;
        
        private Swimomatic.Manager.RoleManager _RoleManager;
        
        private Swimomatic.Manager.RoleSystemUserManager _RoleSystemUserManager;
        
        private Swimomatic.Manager.ScoreManager _ScoreManager;
        
        private Swimomatic.Manager.ScoringSchemeManager _ScoringSchemeManager;
        
        private Swimomatic.Manager.SeasonManager _SeasonManager;
        
        private Swimomatic.Manager.SeasonScoringSchemeManager _SeasonScoringSchemeManager;
        
        private Swimomatic.Manager.SplitManager _SplitManager;
        
        private Swimomatic.Manager.StrokeManager _StrokeManager;
        
        private Swimomatic.Manager.SwimEventManager _SwimEventManager;
        
        private Swimomatic.Manager.SwimMeetManager _SwimMeetManager;
        
        private Swimomatic.Manager.SwimMeetTeamManager _SwimMeetTeamManager;
        
        private Swimomatic.Manager.SwimmerManager _SwimmerManager;
        
        private Swimomatic.Manager.SwimmerTeamRequestManager _SwimmerTeamRequestManager;
        
        private Swimomatic.Manager.SwimmerTeamSeasonManager _SwimmerTeamSeasonManager;
        
        private Swimomatic.Manager.SystemUserManager _SystemUserManager;
        
        private Swimomatic.Manager.TeamLeagueRequestManager _TeamLeagueRequestManager;
        
        private Swimomatic.Manager.TeamManager _TeamManager;
        
        private Swimomatic.Manager.TeamSeasonManager _TeamSeasonManager;
        
        private Swimomatic.Manager.UOMManager _UOMManager;
        
        private Swimomatic.Manager.UserLeagueManager _UserLeagueManager;
        
        private Swimomatic.Manager.UserLocationManager _UserLocationManager;
        
        private Swimomatic.Manager.UserSwimMeetManager _UserSwimMeetManager;
        
        private Swimomatic.Manager.UserSwimmerManager _UserSwimmerManager;
        
        private Swimomatic.Manager.UserTeamManager _UserTeamManager;
        
        #region Constructor
        public _SwimomaticEntityContext()
        {
        }
        
        public _SwimomaticEntityContext(string connectionString)
        {
            ConnectionString = connectionString;
        }
        #endregion
        
        public virtual string ConnectionString
        {
            get
            {
                return ServiceProvider.ConnectionString;
            }
            set
            {
                ServiceProvider.ConnectionString = value;
            }
        }
        
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
        
        public virtual Swimomatic.Manager.AgeClassManager AgeClassManager
        {
            get
            {
                if ((_AgeClassManager == null))
                {
                    _AgeClassManager = new Swimomatic.Manager.AgeClassManager(ServiceProvider);
                }
                return _AgeClassManager;
            }
            set
            {
                _AgeClassManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.AgeClassRuleManager AgeClassRuleManager
        {
            get
            {
                if ((_AgeClassRuleManager == null))
                {
                    _AgeClassRuleManager = new Swimomatic.Manager.AgeClassRuleManager(ServiceProvider);
                }
                return _AgeClassRuleManager;
            }
            set
            {
                _AgeClassRuleManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.HeatManager HeatManager
        {
            get
            {
                if ((_HeatManager == null))
                {
                    _HeatManager = new Swimomatic.Manager.HeatManager(ServiceProvider);
                }
                return _HeatManager;
            }
            set
            {
                _HeatManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.HeatSheetEventManager HeatSheetEventManager
        {
            get
            {
                if ((_HeatSheetEventManager == null))
                {
                    _HeatSheetEventManager = new Swimomatic.Manager.HeatSheetEventManager(ServiceProvider);
                }
                return _HeatSheetEventManager;
            }
            set
            {
                _HeatSheetEventManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.HeatSheetManager HeatSheetManager
        {
            get
            {
                if ((_HeatSheetManager == null))
                {
                    _HeatSheetManager = new Swimomatic.Manager.HeatSheetManager(ServiceProvider);
                }
                return _HeatSheetManager;
            }
            set
            {
                _HeatSheetManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.HeatSheetTeamManager HeatSheetTeamManager
        {
            get
            {
                if ((_HeatSheetTeamManager == null))
                {
                    _HeatSheetTeamManager = new Swimomatic.Manager.HeatSheetTeamManager(ServiceProvider);
                }
                return _HeatSheetTeamManager;
            }
            set
            {
                _HeatSheetTeamManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.HeatSwimmerManager HeatSwimmerManager
        {
            get
            {
                if ((_HeatSwimmerManager == null))
                {
                    _HeatSwimmerManager = new Swimomatic.Manager.HeatSwimmerManager(ServiceProvider);
                }
                return _HeatSwimmerManager;
            }
            set
            {
                _HeatSwimmerManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.LaneSequenceManager LaneSequenceManager
        {
            get
            {
                if ((_LaneSequenceManager == null))
                {
                    _LaneSequenceManager = new Swimomatic.Manager.LaneSequenceManager(ServiceProvider);
                }
                return _LaneSequenceManager;
            }
            set
            {
                _LaneSequenceManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.LeagueManager LeagueManager
        {
            get
            {
                if ((_LeagueManager == null))
                {
                    _LeagueManager = new Swimomatic.Manager.LeagueManager(ServiceProvider);
                }
                return _LeagueManager;
            }
            set
            {
                _LeagueManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.LocationManager LocationManager
        {
            get
            {
                if ((_LocationManager == null))
                {
                    _LocationManager = new Swimomatic.Manager.LocationManager(ServiceProvider);
                }
                return _LocationManager;
            }
            set
            {
                _LocationManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.PoolConfigManager PoolConfigManager
        {
            get
            {
                if ((_PoolConfigManager == null))
                {
                    _PoolConfigManager = new Swimomatic.Manager.PoolConfigManager(ServiceProvider);
                }
                return _PoolConfigManager;
            }
            set
            {
                _PoolConfigManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.PoolManager PoolManager
        {
            get
            {
                if ((_PoolManager == null))
                {
                    _PoolManager = new Swimomatic.Manager.PoolManager(ServiceProvider);
                }
                return _PoolManager;
            }
            set
            {
                _PoolManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.ProfileManager ProfileManager
        {
            get
            {
                if ((_ProfileManager == null))
                {
                    _ProfileManager = new Swimomatic.Manager.ProfileManager(ServiceProvider);
                }
                return _ProfileManager;
            }
            set
            {
                _ProfileManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.ProfileSystemUserManager ProfileSystemUserManager
        {
            get
            {
                if ((_ProfileSystemUserManager == null))
                {
                    _ProfileSystemUserManager = new Swimomatic.Manager.ProfileSystemUserManager(ServiceProvider);
                }
                return _ProfileSystemUserManager;
            }
            set
            {
                _ProfileSystemUserManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.RegionManager RegionManager
        {
            get
            {
                if ((_RegionManager == null))
                {
                    _RegionManager = new Swimomatic.Manager.RegionManager(ServiceProvider);
                }
                return _RegionManager;
            }
            set
            {
                _RegionManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.ReportManager ReportManager
        {
            get
            {
                if ((_ReportManager == null))
                {
                    _ReportManager = new Swimomatic.Manager.ReportManager(ServiceProvider);
                }
                return _ReportManager;
            }
            set
            {
                _ReportManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.ResultManager ResultManager
        {
            get
            {
                if ((_ResultManager == null))
                {
                    _ResultManager = new Swimomatic.Manager.ResultManager(ServiceProvider);
                }
                return _ResultManager;
            }
            set
            {
                _ResultManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.RoleManager RoleManager
        {
            get
            {
                if ((_RoleManager == null))
                {
                    _RoleManager = new Swimomatic.Manager.RoleManager(ServiceProvider);
                }
                return _RoleManager;
            }
            set
            {
                _RoleManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.RoleSystemUserManager RoleSystemUserManager
        {
            get
            {
                if ((_RoleSystemUserManager == null))
                {
                    _RoleSystemUserManager = new Swimomatic.Manager.RoleSystemUserManager(ServiceProvider);
                }
                return _RoleSystemUserManager;
            }
            set
            {
                _RoleSystemUserManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.ScoreManager ScoreManager
        {
            get
            {
                if ((_ScoreManager == null))
                {
                    _ScoreManager = new Swimomatic.Manager.ScoreManager(ServiceProvider);
                }
                return _ScoreManager;
            }
            set
            {
                _ScoreManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.ScoringSchemeManager ScoringSchemeManager
        {
            get
            {
                if ((_ScoringSchemeManager == null))
                {
                    _ScoringSchemeManager = new Swimomatic.Manager.ScoringSchemeManager(ServiceProvider);
                }
                return _ScoringSchemeManager;
            }
            set
            {
                _ScoringSchemeManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.SeasonManager SeasonManager
        {
            get
            {
                if ((_SeasonManager == null))
                {
                    _SeasonManager = new Swimomatic.Manager.SeasonManager(ServiceProvider);
                }
                return _SeasonManager;
            }
            set
            {
                _SeasonManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.SeasonScoringSchemeManager SeasonScoringSchemeManager
        {
            get
            {
                if ((_SeasonScoringSchemeManager == null))
                {
                    _SeasonScoringSchemeManager = new Swimomatic.Manager.SeasonScoringSchemeManager(ServiceProvider);
                }
                return _SeasonScoringSchemeManager;
            }
            set
            {
                _SeasonScoringSchemeManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.SplitManager SplitManager
        {
            get
            {
                if ((_SplitManager == null))
                {
                    _SplitManager = new Swimomatic.Manager.SplitManager(ServiceProvider);
                }
                return _SplitManager;
            }
            set
            {
                _SplitManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.StrokeManager StrokeManager
        {
            get
            {
                if ((_StrokeManager == null))
                {
                    _StrokeManager = new Swimomatic.Manager.StrokeManager(ServiceProvider);
                }
                return _StrokeManager;
            }
            set
            {
                _StrokeManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.SwimEventManager SwimEventManager
        {
            get
            {
                if ((_SwimEventManager == null))
                {
                    _SwimEventManager = new Swimomatic.Manager.SwimEventManager(ServiceProvider);
                }
                return _SwimEventManager;
            }
            set
            {
                _SwimEventManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.SwimMeetManager SwimMeetManager
        {
            get
            {
                if ((_SwimMeetManager == null))
                {
                    _SwimMeetManager = new Swimomatic.Manager.SwimMeetManager(ServiceProvider);
                }
                return _SwimMeetManager;
            }
            set
            {
                _SwimMeetManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.SwimMeetTeamManager SwimMeetTeamManager
        {
            get
            {
                if ((_SwimMeetTeamManager == null))
                {
                    _SwimMeetTeamManager = new Swimomatic.Manager.SwimMeetTeamManager(ServiceProvider);
                }
                return _SwimMeetTeamManager;
            }
            set
            {
                _SwimMeetTeamManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.SwimmerManager SwimmerManager
        {
            get
            {
                if ((_SwimmerManager == null))
                {
                    _SwimmerManager = new Swimomatic.Manager.SwimmerManager(ServiceProvider);
                }
                return _SwimmerManager;
            }
            set
            {
                _SwimmerManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.SwimmerTeamRequestManager SwimmerTeamRequestManager
        {
            get
            {
                if ((_SwimmerTeamRequestManager == null))
                {
                    _SwimmerTeamRequestManager = new Swimomatic.Manager.SwimmerTeamRequestManager(ServiceProvider);
                }
                return _SwimmerTeamRequestManager;
            }
            set
            {
                _SwimmerTeamRequestManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.SwimmerTeamSeasonManager SwimmerTeamSeasonManager
        {
            get
            {
                if ((_SwimmerTeamSeasonManager == null))
                {
                    _SwimmerTeamSeasonManager = new Swimomatic.Manager.SwimmerTeamSeasonManager(ServiceProvider);
                }
                return _SwimmerTeamSeasonManager;
            }
            set
            {
                _SwimmerTeamSeasonManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.SystemUserManager SystemUserManager
        {
            get
            {
                if ((_SystemUserManager == null))
                {
                    _SystemUserManager = new Swimomatic.Manager.SystemUserManager(ServiceProvider);
                }
                return _SystemUserManager;
            }
            set
            {
                _SystemUserManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.TeamLeagueRequestManager TeamLeagueRequestManager
        {
            get
            {
                if ((_TeamLeagueRequestManager == null))
                {
                    _TeamLeagueRequestManager = new Swimomatic.Manager.TeamLeagueRequestManager(ServiceProvider);
                }
                return _TeamLeagueRequestManager;
            }
            set
            {
                _TeamLeagueRequestManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.TeamManager TeamManager
        {
            get
            {
                if ((_TeamManager == null))
                {
                    _TeamManager = new Swimomatic.Manager.TeamManager(ServiceProvider);
                }
                return _TeamManager;
            }
            set
            {
                _TeamManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.TeamSeasonManager TeamSeasonManager
        {
            get
            {
                if ((_TeamSeasonManager == null))
                {
                    _TeamSeasonManager = new Swimomatic.Manager.TeamSeasonManager(ServiceProvider);
                }
                return _TeamSeasonManager;
            }
            set
            {
                _TeamSeasonManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.UOMManager UOMManager
        {
            get
            {
                if ((_UOMManager == null))
                {
                    _UOMManager = new Swimomatic.Manager.UOMManager(ServiceProvider);
                }
                return _UOMManager;
            }
            set
            {
                _UOMManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.UserLeagueManager UserLeagueManager
        {
            get
            {
                if ((_UserLeagueManager == null))
                {
                    _UserLeagueManager = new Swimomatic.Manager.UserLeagueManager(ServiceProvider);
                }
                return _UserLeagueManager;
            }
            set
            {
                _UserLeagueManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.UserLocationManager UserLocationManager
        {
            get
            {
                if ((_UserLocationManager == null))
                {
                    _UserLocationManager = new Swimomatic.Manager.UserLocationManager(ServiceProvider);
                }
                return _UserLocationManager;
            }
            set
            {
                _UserLocationManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.UserSwimMeetManager UserSwimMeetManager
        {
            get
            {
                if ((_UserSwimMeetManager == null))
                {
                    _UserSwimMeetManager = new Swimomatic.Manager.UserSwimMeetManager(ServiceProvider);
                }
                return _UserSwimMeetManager;
            }
            set
            {
                _UserSwimMeetManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.UserSwimmerManager UserSwimmerManager
        {
            get
            {
                if ((_UserSwimmerManager == null))
                {
                    _UserSwimmerManager = new Swimomatic.Manager.UserSwimmerManager(ServiceProvider);
                }
                return _UserSwimmerManager;
            }
            set
            {
                _UserSwimmerManager = value;
            }
        }
        
        public virtual Swimomatic.Manager.UserTeamManager UserTeamManager
        {
            get
            {
                if ((_UserTeamManager == null))
                {
                    _UserTeamManager = new Swimomatic.Manager.UserTeamManager(ServiceProvider);
                }
                return _UserTeamManager;
            }
            set
            {
                _UserTeamManager = value;
            }
        }
        
        #region Begin Transaction Methods
        public virtual void BeginTransaction()
        {
            ServiceProvider.BeginTransaction();
        }
        
        public virtual void CommitTransaction()
        {
            ServiceProvider.CommitTransaction();
        }
        
        public virtual void RollbackTransaction()
        {
            ServiceProvider.RollbackTransaction();
        }
        #endregion
    }
}