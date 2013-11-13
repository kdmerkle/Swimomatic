namespace Swimomatic.ServiceProvider
{
   
   
   // Logical Architect Application Framework
   // Logical Architect (LogArch, Inc)
   // www.logicalarchitect.com
   //  
   // <summary>
   // The SwimomaticServiceProvider class is the abstract service provider.
   // This class should not be modified manually.
   // </summary>
   // <history>
   // 		[Generated on 02/29/2012] - Generated by LAAF CodeGen
   // </history>
   public abstract class SwimomaticServiceProvider
   {
      
      protected string _ConnectionString;
      
      #region Constructor
      public SwimomaticServiceProvider()
      {
      }
      
      public SwimomaticServiceProvider(string connectionString)
      {
         _ConnectionString = connectionString;
      }
      #endregion
      
      public virtual string ConnectionString
      {
         get
         {
            return _ConnectionString;
         }
         set
         {
            _ConnectionString = value;
         }
      }
      
      #region Transaction Methods
      public abstract void BeginTransaction();
      
      public abstract void BeginTransaction(string connectionString);
      
      public abstract void CommitTransaction();
      
      public abstract void RollbackTransaction();
      #endregion
      
      #region Static Methods
      public static Swimomatic.ServiceProvider.SwimomaticServiceProvider GetInstance()
      {
         return ((Swimomatic.ServiceProvider.SwimomaticServiceProvider)(System.Activator.CreateInstance(System.Type.GetType(System.Configuration.ConfigurationManager.AppSettings["Swimomatic.ServiceProvider.ServiceProviderType"]))));
      }
      #endregion
      
      #region AgeClassManager methods
      public abstract int AgeClassSave(int AgeClassID, string Description, bool IsMale, int MaxAge, int MinAge);
      
      public abstract void AgeClassDelete(int AgeClassID);
      
      public abstract System.Data.IDataReader AgeClassGet(int AgeClassID);
      
      public abstract System.Data.IDataReader AgeClassGetAll();
      
      public abstract System.Data.IDataReader AgeClassGetByAgeClassRuleIDBirthDate(int AgeClassRuleID, System.DateTime BirthDate);
      #endregion
      
      #region AgeClassRuleManager methods
      public abstract System.Data.IDataReader AgeClassRuleGet(int AgeClassRuleID);
      
      public abstract System.Data.IDataReader AgeClassRuleGetAll();
      #endregion
      
      #region HeatManager methods
      public abstract int HeatSave(int HeatID, int HeatNumber, int HeatSheetEventID);
      
      public abstract void HeatDelete(int HeatID);
      
      public abstract System.Data.IDataReader HeatGet(int HeatID);
      
      public abstract System.Data.IDataReader HeatGetByHeatSwimmerID(int HeatSwimmerID);
      
      public abstract void HeatDeleteByHeatSheetEventID(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader HeatGetAllByHeatSheetEventID(int HeatSheetEventID);
      #endregion
      
      #region HeatSheetEventManager methods
      public abstract int HeatSheetEventSave(int Distance, int HeatSheetEventID, int HeatSheetID, int Sequence, int SwimEventID);
      
      public abstract void HeatSheetEventDelete(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader HeatSheetEventGet(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader HeatSheetEventGetAll();
      
      public abstract System.Data.IDataReader HeatSheetEventGetByHeatSwimmerID(int HeatSwimmerID);
      
      public abstract System.Data.IDataReader HeatSheetEventGetByHeatID(int HeatID);
      
      public abstract System.Data.IDataReader HeatSheetEventGetByDistanceSwimEventIDHeatSheetID(int Distance, int HeatSheetID, int SwimEventID);
      
      public abstract System.Data.IDataReader HeatSheetEventGetAllByHeatSheetID(int HeatSheetID);
      
      public abstract System.Data.IDataReader HeatSheetEventGetAllByHeatSheetIDSystemUserID(int HeatSheetID, int SystemUserID);
      #endregion
      
      #region HeatSheetManager methods
      public abstract int HeatSheetSave(int HeatSheetID, int PoolConfigID, int SwimMeetID);
      
      public abstract void HeatSheetDelete(int HeatSheetID);
      
      public abstract System.Data.IDataReader HeatSheetGet(int HeatSheetID);
      
      public abstract System.Data.IDataReader HeatSheetGetAllBySwimMeetID(int SwimMeetID);
      #endregion
      
      #region HeatSheetTeamManager methods
      public abstract int HeatSheetTeamSave(int HeatSheetID, int HeatSheetTeamID, string Lanes, int TeamSeasonID);
      
      public abstract void HeatSheetTeamDelete(int HeatSheetTeamID);
      
      public abstract System.Data.IDataReader HeatSheetTeamGet(int HeatSheetTeamID);
      
      public abstract System.Data.IDataReader HeatSheetTeamGetAllByHeatSheetEventID(int HeatSheetEventID);
      #endregion
      
      #region HeatSwimmerManager methods
      public abstract int HeatSwimmerSave(int HeatID, int HeatSwimmerID, int LaneNumber, int Leg, int SeedResultID, int SwimmerTeamSeasonID);
      
      public abstract void HeatSwimmerDelete(int HeatSwimmerID);
      
      public abstract System.Data.IDataReader HeatSwimmerGet(int HeatSwimmerID);
      
      public abstract System.Data.IDataReader HeatSwimmerGetAll();
      
      public abstract System.Data.IDataReader HeatSwimmerGetAllBySwimMeetID(int SwimMeetID);
      
      public abstract System.Data.IDataReader HeatSwimmerGetByLaneNumberHeatID(int LaneNumber, int HeatID);
      
      public abstract System.Data.IDataReader HeatSwimmerGetAllByHeatID(int HeatID);
      
      public abstract void HeatSwimmerDeleteByHeatID(int HeatID);
      
      public abstract void HeatSwimmerDeleteByHeatSheetEventID(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader HeatSwimmerGetAllByHeatIDLaneNumber(int HeatID, int LaneNumber);
      
      public abstract System.Data.IDataReader HeatSwimmerGetAllByHeatSheetEventID(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader HeatSwimmerGetAllRelayTeammatesByHeatSwimmerID(int HeatSwimmerID);
      
      public abstract System.Data.IDataReader HeatSwimmerGetAllByHeatSheetID(int HeatSheetID);
      #endregion
      
      #region LaneSequenceManager methods
      public abstract System.Data.IDataReader LaneSequenceGetAllByLaneCount(int LaneCount);
      #endregion
      
      #region LeagueManager methods
      public abstract int LeagueSave(string Description, int LeagueID, string LeagueName, int RegionID);
      
      public abstract void LeagueDelete(int LeagueID);
      
      public abstract System.Data.IDataReader LeagueGet(int LeagueID);
      
      public abstract System.Data.IDataReader LeagueGetAllBySystemUserID(int SystemUserID);
      
      public abstract System.Data.IDataReader LeagueGetAllCurrentSeasonBySystemUserID(int SystemUserID);
      
      public abstract System.Data.IDataReader LeagueGetBySeasonID(int SeasonID);
      #endregion
      
      #region LocationManager methods
      public abstract int LocationSave(string Address, string City, int CreatedByUserID, System.DateTime CreatedDate, decimal Latitude, int LocationID, decimal Longitude, int ModifiedByUserID, System.DateTime ModifiedDate, string Name, string PostalCode, int RegionID);
      
      public abstract void LocationDelete(int LocationID);
      
      public abstract System.Data.IDataReader LocationGet(int LocationID);
      
      public abstract System.Data.IDataReader LocationGetAll();
      
      public abstract System.Data.IDataReader LocationGetBySwimMeetID(int SwimMeetID);
      
      public abstract System.Data.IDataReader LocationGetAllByRegionID(int RegionID);
      
      public abstract System.Data.IDataReader LocationGetAllByCityRegionID(string City, int RegionID);
      
      public abstract System.Data.IDataReader LocationGetAllBySystemUserID(int SystemUserID);
      #endregion
      
      #region PoolConfigManager methods
      public abstract int PoolConfigSave(int CreatedByUserID, System.DateTime CreatedDate, string Description, int LaneCount, double LaneLength, int ModifiedByUserID, System.DateTime ModifiedDate, int PoolConfigID, int PoolID, int UOMID);
      
      public abstract void PoolConfigDelete(int PoolConfigID);
      
      public abstract System.Data.IDataReader PoolConfigGet(int PoolConfigID);
      
      public abstract System.Data.IDataReader PoolConfigGetAll();
      
      public abstract System.Data.IDataReader PoolConfigGetAllBySwimMeetID(int SwimMeetID);
      
      public abstract System.Data.IDataReader PoolConfigGetByHeatID(int HeatID);
      
      public abstract System.Data.IDataReader PoolConfigGetByHeatSheetID(int HeatSheetID);
      
      public abstract System.Data.IDataReader PoolConfigGetByHeatSheetEventID(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader PoolConfigGetAllByLocationIDList(string LocationIDList);
      
      public abstract System.Data.IDataReader PoolConfigGetAllByLocationID(int LocationID);
      
      public abstract System.Data.IDataReader PoolConfigGetAllByCityRegionID(string City, int RegionID);
      
      public abstract System.Data.IDataReader PoolConfigGetAllByRegionID(int RegionID);
      
      public abstract System.Data.IDataReader PoolConfigGetAllByUserTeamID(int UserTeamID);
      
      public abstract System.Data.IDataReader PoolConfigGetByUserTeamID(int UserTeamID);
      #endregion
      
      #region PoolManager methods
      public abstract int PoolSave(int CreatedByUserID, System.DateTime CreatedDate, string Description, int LocationID, int ModifiedByUserID, System.DateTime ModifiedDate, int PoolID);
      
      public abstract void PoolDelete(int PoolID);
      
      public abstract System.Data.IDataReader PoolGet(int PoolID);
      
      public abstract System.Data.IDataReader PoolGetAll();
      
      public abstract System.Data.IDataReader PoolGetAllBySwimMeetID(int SwimMeetID);
      
      public abstract System.Data.IDataReader PoolGetByPoolConfigID(int PoolConfigID);
      #endregion
      
      #region ProfileManager methods
      public abstract int ProfileSave(string Description, bool IsActive, int ProfileID, string ProfileName);
      
      public abstract void ProfileDelete(int ProfileID);
      
      public abstract System.Data.IDataReader ProfileGet(int ProfileID);
      
      public abstract System.Data.IDataReader ProfileGetAll();
      #endregion
      
      #region ProfileSystemUserManager methods
      public abstract int ProfileSystemUserSave(int ProfileID, int ProfileSystemUserID, int SystemUserID);
      
      public abstract void ProfileSystemUserDelete(int ProfileSystemUserID);
      
      public abstract System.Data.IDataReader ProfileSystemUserGet(int ProfileSystemUserID);
      
      public abstract System.Data.IDataReader ProfileSystemUserGetAll();
      #endregion
      
      #region RegionManager methods
      public abstract int RegionSave(string RegionAbbrev, int RegionID, string RegionName);
      
      public abstract void RegionDelete(int RegionID);
      
      public abstract System.Data.IDataReader RegionGet(int RegionID);
      
      public abstract System.Data.IDataReader RegionGetAll();
      #endregion
      
      #region ReportManager methods
      public abstract System.Data.IDataReader RptHeatSheetEventGetByHeatSheetEventID(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader RptHeatSheetEventGetByHeatID(int HeatID);
      
      public abstract System.Data.IDataReader RptHeatSheetEventGetByHeatSheetID(int HeatSheetID);
      #endregion
      
      #region ResultManager methods
      public abstract int ResultSave(
               int AgeClassID, 
               int CreatedByUserID, 
               System.DateTime CreatedDate, 
               bool Disqualified, 
               int Distance, 
               double ElapsedTime, 
               System.DateTime EventDate, 
               int HeatSwimmerID, 
               bool IsCertified, 
               bool IsProtested, 
               double LaneLength, 
               int ModifiedByUserID, 
               System.DateTime ModifiedDate, 
               int Place, 
               double Points, 
               int ResultID, 
               int ScoringSchemeID, 
               double Split, 
               int StrokeID, 
               int SwimmerID, 
               int SwimmerTeamSeasonID, 
               int TeamSeasonID, 
               int UOMID);
      
      public abstract void ResultDelete(int ResultID);
      
      public abstract System.Data.IDataReader ResultGet(int ResultID);
      
      public abstract System.Data.IDataReader ResultGetAllBySwimMeetID(int SwimMeetID);
      
      public abstract System.Data.IDataReader ResultGetByHeatSwimmerID(int HeatSwimmerID);
      
      public abstract System.Data.IDataReader ResultGetAllByHeatSheetEventID(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader ResultGetAllByHeatSheetEventIDSwimmerID(int HeatSheetEventID, int SwimmerID);
      #endregion
      
      #region RoleManager methods
      public abstract int RoleSave(string Description, bool IsActive, int RoleID, string RoleName);
      
      public abstract void RoleDelete(int RoleID);
      
      public abstract System.Data.IDataReader RoleGet(int RoleID);
      
      public abstract System.Data.IDataReader RoleGetAll();
      #endregion
      
      #region RoleSystemUserManager methods
      public abstract int RoleSystemUserSave(int RoleID, int RoleSystemUserID, int SystemUserID);
      
      public abstract void RoleSystemUserDelete(int RoleSystemUserID);
      
      public abstract System.Data.IDataReader RoleSystemUserGet(int RoleSystemUserID);
      
      public abstract System.Data.IDataReader RoleSystemUserGetAll();
      #endregion
      
      #region ScoreManager methods
      public abstract System.Data.IDataReader ScoreGetAllBySwimMeetID(int SwimMeetID);
      
      public abstract System.Data.IDataReader ScoreGetAllBySwimmerIDSwimMeetID(int SwimmerID, int SwimMeetID);
      
      public abstract System.Data.IDataReader ScoreGetTotalBySwimMeetID(int SwimMeetID);
      
      public abstract System.Data.IDataReader ScoreGetAllBySystemUserIDAsSwimmer(int SystemUserID);
      
      public abstract System.Data.IDataReader ScoreGetAllBySwimMeetIDSystemUserID(int SwimMeetID, int SystemUserID);
      #endregion
      
      #region ScoringSchemeManager methods
      public abstract int ScoringSchemeSave(string Description, string IndividualPoints, bool IsUSASwimming, int LaneCount, string RelayPoints, int ScoringEventTypeID, int ScoringSchemeID);
      
      public abstract void ScoringSchemeDelete(int ScoringSchemeID);
      
      public abstract System.Data.IDataReader ScoringSchemeGet(int ScoringSchemeID);
      
      public abstract System.Data.IDataReader ScoringSchemeGetAllByUSASwimmingScoringEventTypeID(bool IsUSASwimming, int ScoringEventTypeID);
      
      public abstract System.Data.IDataReader ScoringSchemeGetAllBySeasonID(int SeasonID);
      
      public abstract System.Data.IDataReader ScoringSchemeGetAllByHeatSheetEventID(int HeatSheetEventID);
      #endregion
      
      #region SeasonManager methods
      public abstract int SeasonSave(System.DateTime AgeClassRuleCustomDate, int AgeClassRuleID, string Description, System.DateTime EndDate, int LeagueID, int SeasonID, System.DateTime StartDate);
      
      public abstract void SeasonDelete(int SeasonID);
      
      public abstract System.Data.IDataReader SeasonGet(int SeasonID);
      
      public abstract System.Data.IDataReader SeasonGetAllByTeamID(int TeamID);
      
      public abstract System.Data.IDataReader SeasonGetByHeatSheetEventID(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader SeasonGetAllCurrentByLeagueID(int LeagueID);
      
      public abstract System.Data.IDataReader SeasonGetByTeamSeasonID(int TeamSeasonID);
      
      public abstract System.Data.IDataReader SeasonGetAllBySearch(string LeagueName, int RegionID);
      
      public abstract System.Data.IDataReader SeasonGetAllByLeagueID(int LeagueID);
      
      public abstract System.Data.IDataReader SeasonGetBySeasonIDSystemUserID(int SeasonID, int SystemUserID);
      
      public abstract System.Data.IDataReader SeasonGetAllByLeagueIDSystemUserID(int LeagueID, int SystemUserID);
      #endregion
      
      #region SeasonScoringSchemeManager methods
      public abstract int SeasonScoringSchemeSave(int ScoringSchemeID, int SeasonID, int SeasonScoringSchemeID, int SwimMeetTypeID);
      
      public abstract void SeasonScoringSchemeDeleteBySeasonID(int SeasonID);
      
      public abstract System.Data.IDataReader SeasonScoringSchemeGet(int SeasonScoringSchemeID);
      
      public abstract System.Data.IDataReader SeasonScoringSchemeGetAll();
      #endregion
      
      #region SplitManager methods
      public abstract int SplitSave(int ResultID, int SplitID, decimal SplitTime);
      
      public abstract void SplitDelete(int SplitID);
      
      public abstract System.Data.IDataReader SplitGet(int SplitID);
      
      public abstract System.Data.IDataReader SplitGetAll();
      #endregion
      
      #region StrokeManager methods
      public abstract int StrokeSave(string Description, bool IsRelay, int StrokeID);
      
      public abstract void StrokeDelete(int StrokeID);
      
      public abstract System.Data.IDataReader StrokeGet(int StrokeID);
      
      public abstract System.Data.IDataReader StrokeGetAll();
      
      public abstract System.Data.IDataReader StrokeGetByHeatID(int HeatID);
      
      public abstract System.Data.IDataReader StrokeGetByHeatSheetEventID(int HeatSheetEventID);
      #endregion
      
      #region SwimEventManager methods
      public abstract int SwimEventSave(int AgeClassID, string Description, int StrokeID, int SwimEventID);
      
      public abstract void SwimEventDelete(int SwimEventID);
      
      public abstract System.Data.IDataReader SwimEventGet(int SwimEventID);
      
      public abstract System.Data.IDataReader SwimEventGetAll();
      
      public abstract System.Data.IDataReader SwimEventGetByAgeClassIDStrokeID(int AgeClassID, int StrokeID);
      #endregion
      
      #region SwimMeetManager methods
      public abstract int SwimMeetSave(string Description, System.DateTime EndDate, int LocationID, int SeasonID, System.DateTime StartDate, int SwimMeetID, int SwimMeetTypeID);
      
      public abstract void SwimMeetDelete(int SwimMeetID);
      
      public abstract System.Data.IDataReader SwimMeetGet(int SwimMeetID);
      
      public abstract System.Data.IDataReader SwimMeetGetAllBySwimMeetID(int SwimMeetID);
      
      public abstract System.Data.IDataReader SwimMeetGetByHeatSheetEventID(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader SwimMeetGetAllBySystemUserID(int SystemUserID);
      
      public abstract System.Data.IDataReader SwimMeetGetAllBySystemUserIDAsSwimmer(int SystemUserID);
      #endregion
      
      #region SwimMeetTeamManager methods
      public abstract int SwimMeetTeamSave(bool IsHomeTeam, int SwimMeetID, int SwimMeetTeamID, int TeamSeasonID);
      
      public abstract void SwimMeetTeamDelete(int SwimMeetTeamID);
      
      public abstract System.Data.IDataReader SwimMeetTeamGet(int SwimMeetTeamID);
      
      public abstract System.Data.IDataReader SwimMeetTeamGetAll();
      
      public abstract System.Data.IDataReader SwimMeetTeamGetAllBySwimMeetID(int SwimMeetID);
      
      public abstract void SwimMeetTeamDeleteBySwimMeetID(int SwimMeetID);
      #endregion
      
      #region SwimmerManager methods
      public abstract int SwimmerSave(System.DateTime BirthDate, string FirstName, bool IsMale, string LastName, int SwimmerID);
      
      public abstract void SwimmerDelete(int SwimmerID);
      
      public abstract System.Data.IDataReader SwimmerGet(int SwimmerID);
      
      public abstract System.Data.IDataReader SwimmerGetAllBySystemUserID(int SystemUserID);
      
      public abstract System.Data.IDataReader SwimmerGetAllAvailableByHeatID(int HeatID);
      
      public abstract System.Data.IDataReader SwimmerGetAllEligibleByHeatSheetEventID(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader SwimmerGetAllByTeamSeasonID(int TeamSeasonID);
      
      public abstract System.Data.IDataReader SwimmerTeamRequestGetAllByTeamSeasonID(int TeamSeasonID);
      
      public abstract System.Data.IDataReader SwimmerGetAllAvailableByHeatSheetEventID(int HeatSheetEventID);
      
      public abstract System.Data.IDataReader SwimmerTeamRequestGetAllBySystemUserIDTeamSeasonID(int SystemUserID, int TeamSeasonID);
      #endregion
      
      #region SwimmerTeamRequestManager methods
      public abstract int SwimmerTeamRequestSave(System.DateTime ApprovalDate, int ApprovalUserID, bool IsApproved, System.DateTime RequestDate, int SwimmerTeamRequestID, int TeamSeasonID, int UserSwimmerID);
      
      public abstract void SwimmerTeamRequestDelete(int SwimmerTeamRequestID);
      
      public abstract System.Data.IDataReader SwimmerTeamRequestGet(int SwimmerTeamRequestID);
      
      public abstract System.Data.IDataReader SwimmerTeamRequestGetAll();
      
      public abstract int SwimmerTeamRequestIsPermitted(int TeamSeasonID, int UserSwimmerID);
      #endregion
      
      #region SwimmerTeamSeasonManager methods
      public abstract int SwimmerTeamSeasonSave(System.DateTime EndDate, System.DateTime StartDate, int SwimmerID, int SwimmerTeamSeasonID, int TeamSeasonID);
      
      public abstract void SwimmerTeamSeasonDelete(int SwimmerTeamSeasonID);
      
      public abstract System.Data.IDataReader SwimmerTeamSeasonGet(int SwimmerTeamSeasonID);
      
      public abstract System.Data.IDataReader SwimmerTeamSeasonGetAllBySwimmerID(int SwimmerID);
      #endregion
      
      #region SystemUserManager methods
      public abstract int SystemUserSave(string City, System.DateTime CreateDate, string Email, string FirstName, bool IsActive, string LastName, System.DateTime ModifiedDate, string Password, int RegionID, System.Guid RegistrationKey, bool ResetPassword, int SystemUserID, string TemporaryPassword, string UserName);
      
      public abstract void SystemUserDelete(int SystemUserID);
      
      public abstract System.Data.IDataReader SystemUserGet(int SystemUserID);
      
      public abstract System.Data.IDataReader SystemUserGetAll();
      
      public abstract System.Data.IDataReader SystemUserGetByUserNamePassword(string UserName, string Password);
      
      public abstract System.Data.IDataReader SystemUserGetByEmail(string Email);
      
      public abstract System.Data.IDataReader SystemUserGetByRegistrationKey(System.Guid RegistrationKey);
      
      public abstract System.Data.IDataReader SystemUserGetByUserName(string UserName);
      
      public abstract System.Data.IDataReader SystemUserGetAllByResetPassword();
      #endregion
      
      #region TeamLeagueRequestManager methods
      public abstract int TeamLeagueRequestSave(System.DateTime ApprovalDate, int ApprovalUserID, bool IsApproved, System.DateTime RequestDate, int SeasonID, int TeamLeagueRequestID, int UserTeamID);
      
      public abstract void TeamLeagueRequestDelete(int TeamLeagueRequestID);
      
      public abstract System.Data.IDataReader TeamLeagueRequestGet(int TeamLeagueRequestID);
      
      public abstract System.Data.IDataReader TeamLeagueRequestGetAll();
      #endregion
      
      #region TeamManager methods
      public abstract int TeamSave(string Abbrev, int HomePoolConfigID, int TeamID, string TeamName);
      
      public abstract void TeamDelete(int TeamID);
      
      public abstract System.Data.IDataReader TeamGet(int TeamID);
      
      public abstract System.Data.IDataReader TeamGetAll();
      
      public abstract System.Data.IDataReader TeamGetAllBySwimMeetID(int SwimMeetID);
      
      public abstract System.Data.IDataReader TeamGetByHeatSwimmerID(int HeatSwimmerID);
      
      public abstract System.Data.IDataReader TeamGetAllCurrentSeasonByLeagueID(int LeagueID);
      
      public abstract System.Data.IDataReader TeamGetAllBySeasonID(int SeasonID);
      
      public abstract System.Data.IDataReader TeamGetAllBySystemUserID(int SystemUserID);
      
      public abstract System.Data.IDataReader TeamGetAllBySearch(string Address, string City, string PostalCode, int RegionID, string TeamName);
      
      public abstract System.Data.IDataReader TeamGetByUserTeamID(int UserTeamID);
      
      public abstract System.Data.IDataReader TeamLeagueRequestGetAllBySeasonID(int SeasonID);
      
      public abstract System.Data.IDataReader TeamGetByTeamSeasonID(int TeamSeasonID);
      
      public abstract System.Data.IDataReader TeamLeagueRequestGetAllBySeasonIDSystemUserID(int SeasonID, int SystemUserID);
      #endregion
      
      #region TeamSeasonManager methods
      public abstract int TeamSeasonSave(int AgeClassRuleID, int LeagueID, int SeasonID, int TeamID, int TeamSeasonID);
      
      public abstract void TeamSeasonDelete(int TeamSeasonID);
      
      public abstract System.Data.IDataReader TeamSeasonGet(int TeamSeasonID);
      
      public abstract System.Data.IDataReader TeamSeasonGetAllBySystemUserID(int SystemUserID);
      
      public abstract System.Data.IDataReader TeamSeasonGetAllByHeatSheetEventID(int HeatSheetEventID);
      #endregion
      
      #region UOMManager methods
      public abstract int UOMSave(string Abbrev, string Description, int UOMID);
      
      public abstract void UOMDelete(int UOMID);
      
      public abstract System.Data.IDataReader UOMGet(int UOMID);
      
      public abstract System.Data.IDataReader UOMGetAll();
      #endregion
      
      #region UserLeagueManager methods
      public abstract int UserLeagueSave(int LeagueID, int SystemUserID, int UserLeagueID);
      
      public abstract void UserLeagueDelete(int UserLeagueID);
      
      public abstract System.Data.IDataReader UserLeagueGet(int UserLeagueID);
      
      public abstract System.Data.IDataReader UserLeagueGetAll();
      
      public abstract System.Data.IDataReader UserLeagueGetAllBySystemUserID(int SystemUserID);
      #endregion
      
      #region UserLocationManager methods
      public abstract int UserLocationSave(int LocationID, int SystemUserID, int UserLocationID);
      
      public abstract void UserLocationDelete(int UserLocationID);
      
      public abstract System.Data.IDataReader UserLocationGet(int UserLocationID);
      #endregion
      
      #region UserSwimMeetManager methods
      public abstract int UserSwimMeetSave(int SwimMeetID, int SystemUserID, int UserSwimMeetID);
      
      public abstract void UserSwimMeetDelete(int UserSwimMeetID);
      
      public abstract System.Data.IDataReader UserSwimMeetGet(int UserSwimMeetID);
      
      public abstract System.Data.IDataReader UserSwimMeetGetAll();
      
      public abstract System.Data.IDataReader UserSwimMeetGetAllBySystemUserID(int SystemUserID);
      #endregion
      
      #region UserSwimmerManager methods
      public abstract int UserSwimmerSave(int SwimmerID, int SystemUserID, int UserSwimmerID);
      
      public abstract void UserSwimmerDelete(int UserSwimmerID);
      
      public abstract System.Data.IDataReader UserSwimmerGet(int UserSwimmerID);
      
      public abstract System.Data.IDataReader UserSwimmerGetAll();
      
      public abstract System.Data.IDataReader UserSwimmerGetAllBySystemUserID(int SystemUserID);
      #endregion
      
      #region UserTeamManager methods
      public abstract int UserTeamSave(int SystemUserID, int TeamID, int UserTeamID);
      
      public abstract void UserTeamDelete(int UserTeamID);
      
      public abstract System.Data.IDataReader UserTeamGet(int UserTeamID);
      
      public abstract System.Data.IDataReader UserTeamGetAllByTeamSeasonID(int TeamSeasonID);
      
      public abstract System.Data.IDataReader UserTeamGetAllBySystemUserID(int SystemUserID);
      #endregion

	// *** START OF CUSTOM CODE - CODE ABOVE THIS COMMENT WILL BE OVERWRITTEN! ***

   }
}