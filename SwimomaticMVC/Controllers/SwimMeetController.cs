using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using Swimomatic.Entity;
using SwimomaticBusinessLib;
using System.Web.UI.WebControls;
using SwimomaticMVC.Models;
using LAAF.Logger;

namespace SwimomaticMVC.Controllers
{
    public class SwimMeetController : ControllerBase
    {
        #region Action Methods
        public ActionResult Index()
        {
            ViewSwimMeet vsm = new ViewSwimMeet();
            try
            {
                vsm.HasTeamSeasons = BizMgr.GetHasTeamSeasons(this.CurrentUser.SystemUserID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "");
            }
            return View("Index", vsm);
        }

        [ChildActionOnly]
        public ActionResult SwimMeets()
        {
            return PartialView("_SwimMeets", GetSwimMeets(base.CurrentUser.SystemUserID));
        }

        [ChildActionOnly]
        public ActionResult Leagues()
        {
            return PartialView("_Leagues", GetViewLeagues(base.CurrentUser.SystemUserID));
        }

        [HttpPost]
        public ActionResult SaveSwimMeet(ViewSwimMeet viewSwimMeet)
        {
            try
            {
                //Save SwimMeet
                SwimMeet swimMeet = new SwimMeet();
                swimMeet.SwimMeetID = viewSwimMeet.SwimMeetID;
                swimMeet.SwimMeetTypeID = viewSwimMeet.SwimMeetTypeID;
                swimMeet.Description = viewSwimMeet.Description;
                swimMeet.StartDate = viewSwimMeet.StartDate;
                swimMeet.EndDate = viewSwimMeet.EndDate;
                swimMeet.LocationID = viewSwimMeet.LocationID;
                swimMeet.SeasonID = viewSwimMeet.SeasonID;
                swimMeet.SwimMeetID = BizMgr.SaveSwimMeet(swimMeet, base.CurrentUser.SystemUserID);

                //Delete existing SwimMeetTeams
                BizMgr.DeleteSwimMeetTeamsBySwimMeetID(swimMeet.SwimMeetID);

                //Save SwimMeetTeams
                SwimMeetTeam smt = null;
                foreach (int teamSeasonID in viewSwimMeet.TeamSeasonIDs)
                {
                    smt = new SwimMeetTeam();
                    smt.SwimMeetID = swimMeet.SwimMeetID;
                    smt.TeamSeasonID = teamSeasonID;
                    BizMgr.SaveSwimMeetTeam(smt);
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "");
            }
            return PartialView("_SwimMeets", GetSwimMeets(base.CurrentUser.SystemUserID));
        }

        public ActionResult DeleteSwimMeet(int SwimMeetID)
        {
            try
            {
                BizMgr.DeleteSwimMeet(SwimMeetID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "");
            }
            return PartialView("_SwimMeets", GetSwimMeets(base.CurrentUser.SystemUserID));
        }

        public ActionResult GetTeams(int SeasonID)
        {
            ViewTeams vts = new ViewTeams();
            try
            {
                vts.ViewTeamList = GetViewTeamList(SeasonID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "");
            }
            return PartialView("_Teams", vts);
        }

        public ActionResult GetSeasons(int LeagueID)
        {
            ViewSeasons vss = new ViewSeasons();
            try
            {
                vss.ViewSeasonList = GetViewSeasonList(LeagueID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "");
            }
            return PartialView("_Seasons", vss);
        }

        #endregion

        #region Private Methods

        private ViewSwimMeets GetSwimMeets(int SystemUserID)
        {
            ViewSwimMeets vsms = new ViewSwimMeets();
            ViewSwimMeet vsm;
            SwimMeetCollection swimMeets = BizMgr.GetSwimMeetsBySystemUserID(SystemUserID);
            foreach (SwimMeet swimMeet in swimMeets)
            {
                vsm = new ViewSwimMeet();
                vsm.CanEdit = (swimMeet.StartDate > DateTime.Today && swimMeet.IsAdmin);
                vsm.HasResults = swimMeet.HasResults;
                vsm.Description = swimMeet.Description;
                vsm.EndDate = swimMeet.EndDate;
                vsm.StartDate = swimMeet.StartDate;
                vsm.SeasonID = swimMeet.SeasonID;
                vsm.SeasonDescription = swimMeet.SeasonDescription;
                vsm.LeagueDescription = swimMeet.LeagueDescription;
                vsm.LocationID = swimMeet.LocationID;
                vsm.LocationName = swimMeet.LocationName;
                vsm.SwimMeetID = swimMeet.SwimMeetID;

                TeamCollection teams = BizMgr.GetTeamsBySwimMeetID(swimMeet.SwimMeetID);
                foreach (Team team in teams)
                {
                    vsm.Teams += team.TeamNameAbbrev + ", ";
                }
                vsm.Teams = vsm.Teams.TrimEnd(new char[] { ' ', ',' });
                vsms.ViewSwimMeetList.Add(vsm);
            }
            return vsms;
        }

        /// <summary>
        /// Returns all the teams with a current or future TeamSeason record containing the given LeagueID
        /// </summary>
        /// <param name="SeasonID"></param>
        /// <returns></returns>
        private List<ViewTeam> GetViewTeamList(int SeasonID)
        {
            List<ViewTeam> vts = new List<ViewTeam>();
            ViewTeam vt;
            TeamCollection teams = BizMgr.GetTeamsBySeasonID(SeasonID);
            foreach (Team t in teams)
            {
                vt = new ViewTeam();
                vt.Abbrev = t.Abbrev;
                vt.TeamID = t.TeamID;
                vt.TeamSeasonID = t.TeamSeasonID;
                vt.TeamName = t.TeamName;
                vts.Add(vt);
            }
            return vts;
        }
        /// <summary>
        /// Returns all the Leagues that the user is admin of, or leagues which the user's teams are members of
        /// </summary>
        /// <param name="p"></param>
        /// <returns></returns>
        private List<ViewLeague> GetViewLeagues(int SystemUserID)
        {
            LeagueCollection leagues = BizMgr.GetEligibleLeaguesBySystemUserID(SystemUserID);
            return GetViewLeaguesFromLeagues(leagues);
        }

        private List<ViewSeason> GetViewSeasonList(int LeagueID)
        {
            List<ViewSeason> vsl = new List<ViewSeason>();
            ViewSeason vs = null;
            List<Season> seasons = BizMgr.GetCurrentSeasonsByLeagueID(LeagueID);
            foreach (Season s in seasons)
            {
                vs = new ViewSeason();
                vs.Description = s.Description;
                vs.EndDate = s.EndDate;
                vs.LeagueID = s.LeagueID;
                vs.SeasonID = s.SeasonID;
                vs.StartDate = s.StartDate;
                vsl.Add(vs);
            }
            return vsl;
        }

        private List<ViewLeague> GetViewLeaguesFromLeagues(LeagueCollection leagues)
        {
            List<ViewLeague> vls = new List<ViewLeague>();
            ViewLeague vl;
            foreach (League l in leagues)
            {
                vl = new ViewLeague();
                vl.LeagueDescription = l.Description;
                vl.LeagueName = l.LeagueName;
                vl.LeagueID = l.LeagueID;
                vl.RegionAbbrev = l.RegionAbbrev;
                vls.Add(vl);
            }
            return vls;
        }

        private List<ViewPoolConfig> GetPoolConfigs(List<ViewLocation> viewLocations)
        {
            List<ViewPoolConfig> vpcs = new List<ViewPoolConfig>();
            ViewPoolConfig vpc;
            List<int> locationIDs = new List<int>();
            foreach (ViewLocation vl in viewLocations)
            {
                locationIDs.Add(vl.LocationID);
            }
            PoolConfigCollection pcs = BizMgr.GetPoolConfigsByLocationIDList(locationIDs);
            foreach (PoolConfig pc in pcs)
            {
                vpc = new ViewPoolConfig();
                vpc.LaneCount = pc.LaneCount;
                vpc.LocationName = pc.LocationName;
                vpc.LengthDescription = pc.LengthDescription;
                vpc.PoolDescription = pc.PoolDescription;
                vpc.UOMAbbrev = pc.UOMAbbrev;
                vpcs.Add(vpc);
            }
            return vpcs;
        }
        #endregion
    }
}
