using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using SwimomaticMVC.Models;
using Swimomatic.Entity;
using SwimomaticBusinessLib;
using LAAF.Logger;

namespace SwimomaticMVC.Controllers
{
    public class LeagueController : ControllerBase
    {

        #region Action Methods
        public ActionResult Index()
        {
            return View();
        }

        public PartialViewResult Leagues()
        {
            return PartialView("_Leagues", GetLeagues());
        }

        public PartialViewResult League(int LeagueID)
        {
            return PartialView("_League", GetLeague(LeagueID));
        }

        public PartialViewResult Seasons(int LeagueID)
        {
            return PartialView("_Seasons", GetSeasons(LeagueID));
        }

        public PartialViewResult TeamSeasons(int SeasonID)
        {
            return PartialView("_TeamSeasons", GetTeamSeasons(SeasonID));
        }

        public PartialViewResult Season(int SeasonID, int LeagueID)
        {
            return PartialView("_Season", GetSeason(SeasonID, LeagueID));
        }

        public PartialViewResult TeamLeagueRequests(int SeasonID)
        {
            return PartialView("_TeamLeagueRequests", GetTeamLeagueRequests(SeasonID));
        }

        public PartialViewResult ApproveRequest(int TeamLeagueRequestID, int SeasonID)
        {
            BizMgr.ApproveTeamLeagueRequest(TeamLeagueRequestID, this.CurrentUser.SystemUserID);
            return PartialView("_TeamLeagueRequests", GetTeamLeagueRequests(SeasonID));
        }

        [HttpPost]
        public PartialViewResult SaveLeague(ViewLeague viewLeague)
        {
            League league = new League();
            if (ModelState.IsValid)
            {
                try
                {
                    league.LeagueID = viewLeague.LeagueID;
                    league.LeagueName = viewLeague.LeagueName;
                    league.Description = viewLeague.LeagueDescription;
                    league.RegionID = viewLeague.RegionID;
                    viewLeague.LeagueID = BizMgr.SaveLeague(league);
                    BizMgr.SaveUserLeague(viewLeague.LeagueID, this.CurrentUser.SystemUserID);
                }
                catch (Exception ex)
                {
                    LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "League=" + viewLeague.LeagueID.ToString());
                    return PartialView("_League", viewLeague);
                }
            }
            else
            {
                viewLeague.Regions = GetRegions(viewLeague.RegionID);
                return PartialView("_League", viewLeague);
            }
            return PartialView("_League", GetLeague(viewLeague.LeagueID));
        }

        [HttpPost]
        public PartialViewResult SaveSeason(ViewSeason vwSeason)
        {
            Season season = null;
            if (ModelState.IsValid)
            {
                try
                {
                    season = BizMgr.GetSeason(vwSeason.SeasonID);
                    season.AgeClassRuleID = vwSeason.AgeClassRuleID;
                    if (vwSeason.AgeClassRuleID == 1)
                    {
                        season.AgeClassRuleCustomDate = (vwSeason.AgeClassRuleCustomDate.HasValue) ? vwSeason.AgeClassRuleCustomDate.Value : DateTime.MinValue;
                    }
                    else
                    {
                        season.AgeClassRuleCustomDate = DateTime.MinValue;
                    }
                    season.LeagueID = vwSeason.LeagueID;
                    season.Description = vwSeason.Description;
                    season.StartDate = vwSeason.StartDate.Value;
                    season.EndDate = vwSeason.EndDate.Value;
                    season.SeasonID = BizMgr.SaveSeason(season);

                    //SCORING SCHEMES
                    ScoringScheme ss = new ScoringScheme();
                    int scoringSchemeID = 0;
                    SeasonScoringScheme sss = new SeasonScoringScheme();

                    //Dual-Triangle Custom Scoring Scheme
                    ss.IndividualPoints = vwSeason.ScoringCustomIndividual;
                    ss.RelayPoints = vwSeason.ScoringCustomRelay;
                    scoringSchemeID = BizMgr.SaveScoringScheme(ss);

                    sss.SeasonID = season.SeasonID;
                    sss.ScoringSchemeID = scoringSchemeID;
                    sss.SwimMeetTypeID = 1;
                    BizMgr.SaveSeasonScoringScheme(sss);

                    // Invitational-Championship Custom Scoring Scheme
                    ss.IndividualPoints = vwSeason.ScoringFinalCustomIndividual;
                    ss.RelayPoints = vwSeason.ScoringFinalCustomRelay;
                    scoringSchemeID = BizMgr.SaveScoringScheme(ss);

                    sss = new SeasonScoringScheme();
                    sss.SeasonID = season.SeasonID;
                    sss.ScoringSchemeID = scoringSchemeID;
                    sss.SwimMeetTypeID = 3;
                    BizMgr.SaveSeasonScoringScheme(sss);
                    return PartialView("_Season", GetSeason(season.SeasonID, season.LeagueID));
                }
                catch (Exception ex)
                {
                    LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "Season=" + season.SeasonID.ToString());
                    return PartialView("_Season", vwSeason);
                }
            }
            else
            {
                vwSeason.IsAdmin = true;
                vwSeason.AgeClassRules = GetAgeClassRules(vwSeason.AgeClassRuleID);
                return PartialView("_Season", vwSeason);
            }
        }
        #endregion

        #region Private Methods
        private List<ViewLeague> GetLeagues()
        {
            LeagueCollection leagues = BizMgr.GetLeaguesBySystemUserID(this.CurrentUser.SystemUserID);
            List<ViewLeague> vls = new List<ViewLeague>();
            ViewLeague vl;
            foreach (League league in leagues)
            {
                vl = new ViewLeague();
                vl.LeagueName = league.LeagueName;
                vl.RegionID = league.RegionID;
                vl.LeagueDescription = league.Description;
                vl.LeagueID = league.LeagueID;
                vl.RegionAbbrev = league.RegionAbbrev;
                vl.IsAdmin = league.IsAdmin;
                vls.Add(vl);
            }
            return vls;
        }
        private ViewSeasons GetSeasons(int LeagueID)
        {
            ViewSeasons vss = new ViewSeasons();
            vss.LeagueID = LeagueID;

            LeagueCollection leagues = BizMgr.GetLeaguesBySystemUserID(this.CurrentUser.SystemUserID);
            var lgs = leagues.Where<League>(l => l.LeagueID == LeagueID && l.IsAdmin);
            vss.IsAdmin = lgs.Count() > 0;

            SeasonCollection seasons = BizMgr.GetSeasonsByLeagueIDSystemUserID(LeagueID, this.CurrentUser.SystemUserID);
            ViewSeason vs;
            foreach (Season season in seasons)
            {
                vs = new ViewSeason();
                vs.LeagueDescription = season.Description;
                vs.LeagueID = season.LeagueID;
                vs.SeasonID = season.SeasonID;
                vs.StartDate = season.StartDate;
                vs.EndDate = season.EndDate;
                vs.LeagueID = season.LeagueID;
                vs.IsAdmin = season.IsAdmin;
                vss.ViewSeasonList.Add(vs);
            }
            return vss;
        }

        private ViewLeague GetLeague(int LeagueID)
        {
            League league = BizMgr.GetLeague(LeagueID);
            ViewLeague vl = new ViewLeague();
            vl.LeagueName = league.LeagueName;
            vl.RegionID = league.RegionID;
            vl.Regions = GetRegions(league.RegionID);
            vl.LeagueDescription = league.Description;
            vl.LeagueID = league.LeagueID;
            vl.RegionAbbrev = league.RegionAbbrev;
            return vl;
        }
        private ViewSeason GetSeason(int SeasonID, int LeagueID)
        {
            Season season = BizMgr.GetSeasonBySeasonIDSystemUserID(SeasonID, this.CurrentUser.SystemUserID);
            ViewSeason vs = new ViewSeason();
            vs.Description = season.Description;
            vs.SeasonID = season.SeasonID;
            vs.LeagueID = (season.SeasonID == 0) ? LeagueID : season.LeagueID;
            vs.StartDate = season.StartDate;
            vs.EndDate = season.EndDate;
            vs.AgeClassRuleID = season.AgeClassRuleID;
            vs.AgeClassRuleDescription = season.AgeClassRuleDescription;
            vs.IsAdmin = season.IsAdmin || (season.SeasonID == 0); //set admin = true for new season so they can create it
            vs.AgeClassRuleCustomDate = season.AgeClassRuleCustomDate;
            vs.LeagueName = season.LeagueName;
            vs.AgeClassRules = GetAgeClassRules(season.AgeClassRuleID);

            List<ViewScoringScheme> customScoringSchemes = GetScoringSchemes(SeasonID);
            ViewScoringScheme vx = (ViewScoringScheme)customScoringSchemes.Where(c => c.SwimMeetTypeID == 1).FirstOrDefault();
            if (vx != null)
            {
                vs.ScoringCustomIndividual = vx.IndividualPoints;
                vs.ScoringCustomRelay = vx.RelayPoints;
            }
            vx = (ViewScoringScheme)customScoringSchemes.Where(c => c.SwimMeetTypeID == 3).FirstOrDefault();
            if (vx != null)
            {
                vs.ScoringFinalCustomIndividual = vx.IndividualPoints;
                vs.ScoringFinalCustomRelay = vx.RelayPoints;
            }
            foreach (ViewScoringScheme vss in customScoringSchemes)
            {
                vs.ScoringSchemeIDs.Add(vss.ScoringSchemeID);
            }

            //vs.ScoringUSASchemesHeat = GetScoringSchemes(true, SwimomaticBusinessManager.ScoringEventType.Heat);
            //vs.ScoringUSASchemesFinal = GetScoringSchemes(true, SwimomaticBusinessManager.ScoringEventType.Final);
            //vs.ScoringUSASchemesConsolation = GetScoringSchemes(true, SwimomaticBusinessManager.ScoringEventType.Consolation);
            return vs;
        }

        //
        private List<ViewScoringScheme> GetScoringSchemes(int SeasonID)
        {
            List<int> ScoringSchemeIDs = new List<int>();
            ScoringSchemeCollection scoringSchemes = BizMgr.GetScoringSchemesBySeasonID(SeasonID);
            List<ViewScoringScheme> vsss = new List<ViewScoringScheme>();
            ViewScoringScheme vss = null;
            foreach (ScoringScheme scoringScheme in scoringSchemes)
            {
                vss = new ViewScoringScheme();
                vss.Description = scoringScheme.Description;
                vss.IndividualPoints = scoringScheme.IndividualPoints;
                vss.IsUSASwimming = scoringScheme.IsUSASwimming;
                vss.RelayPoints = scoringScheme.RelayPoints;
                vss.ScoringEventTypeID = scoringScheme.ScoringEventTypeID;
                vss.SwimMeetTypeID = scoringScheme.SwimMeetTypeID;
                vss.ScoringSchemeID = scoringScheme.ScoringSchemeID;
                vsss.Add(vss);
            }
            return vsss;
        }

        /// <summary>
        /// Gets the scoring schemes used by USASwimming
        /// </summary>
        /// <param name="IsUSASwimming"></param>
        /// <param name="ScoringEventType"></param>
        /// <returns></returns>
        private List<ViewScoringScheme> GetScoringSchemes(bool IsUSASwimming, SwimomaticBusinessManager.ScoringEventType ScoringEventType)
        {
            ScoringSchemeCollection scoringSchemes = BizMgr.GetUSASwimmingScoringSchemes(IsUSASwimming, ScoringEventType);
            List<ViewScoringScheme> vsss = new List<ViewScoringScheme>();
            ViewScoringScheme vss = null;
            foreach (ScoringScheme scoringScheme in scoringSchemes)
            {
                vss = new ViewScoringScheme();
                vss.Description = scoringScheme.Description;
                vss.IndividualPoints = scoringScheme.IndividualPoints;
                vss.IsUSASwimming = scoringScheme.IsUSASwimming;
                vss.RelayPoints = scoringScheme.RelayPoints;
                vss.ScoringSchemeID = scoringScheme.ScoringSchemeID;
                vsss.Add(vss);
            }

            return vsss;
        }

        private List<ViewTeam> GetTeamSeasons(int SeasonID)
        {
            TeamCollection teams = BizMgr.GetTeamsBySeasonID(SeasonID);
            List<ViewTeam> vts = new List<ViewTeam>();
            ViewTeam vt = null;
            PoolConfig homePoolConfig = null;
            foreach (Team team in teams)
            {
                vt = new ViewTeam();
                vt.TeamName = team.TeamName;
                vt.Abbrev = team.Abbrev;
                vt.TeamNameAbbrev = team.TeamNameAbbrev;
                vt.LocationName = team.LocationName;
                vt.PostalCode = team.PostalCode;

                homePoolConfig = BizMgr.GetPoolConfig(team.HomePoolConfigID);
                vt.HomePoolConfig.LengthDescription = homePoolConfig.LengthDescription;
                vt.HomePoolConfig.LaneCount = homePoolConfig.LaneCount;
                vt.Address = homePoolConfig.Address;
                vt.CityStateZip = homePoolConfig.CityStateZip;
                vts.Add(vt);
            }
            return vts;
        }

        /// <summary>
        /// Returns TeamLeagueRequests for the CurentUser's SystemUserID
        /// </summary>
        /// <param name="SeasonID"></param>
        /// <returns></returns>
        private List<ViewTeam> GetTeamLeagueRequests(int SeasonID)
        {
            List<ViewTeam> vts = new List<ViewTeam>();
            ViewTeam vt = null;
            TeamCollection teams = BizMgr.GetTeamLeagueRequestsBySeasonIDSystemUserID(SeasonID, this.CurrentUser.SystemUserID);
            foreach (Team team in teams)
            {
                vt = new ViewTeam();
                vt.TeamNameAbbrev = team.TeamNameAbbrev;
                vt.LocationName = team.LocationName;
                vt.UserTeamID = team.UserTeamID;
                vt.TeamLeagueRequestID = team.TeamLeagueRequestID;
                vt.SeasonID = SeasonID;
                vts.Add(vt);
            }
            return vts;
        }

        private SelectList GetAgeClassRules(int AgeClassRuleID)
        {
            AgeClassRuleCollection ageClassRules = BizMgr.GetAgeClassRules();
            if (AgeClassRuleID > 0)
            {
                return new SelectList(ageClassRules, "AgeClassRuleID", "ShortDescription", AgeClassRuleID);
            }
            else
            {
                return new SelectList(ageClassRules, "AgeClassRuleID", "ShortDescription");
            }
        }
        #endregion
    }
}
