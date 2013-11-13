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
    public class TeamController : ControllerBase
    {

        #region Action Methods
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult Teams()
        {
            return PartialView("_Teams", GetTeams());
        }

        public ActionResult Team(int UserTeamID)
        {
            ViewTeam vt = GetTeam(UserTeamID);
            vt.Cities = (SelectList)GetCities(0);
            vt.Regions = GetRegions(0);

            vt.HomePoolConfig = GetPoolConfig(UserTeamID);

            ViewLocation vl = new ViewLocation();
            if (UserTeamID > 0)
            {
                vl.City = vt.HomePoolConfig.City;
                vl.RegionID = vt.HomePoolConfig.RegionID;
                vl.RegionAbbrev = vt.HomePoolConfig.RegionAbbrev;
            }
            else
            {
                vl.City = this.CurrentUser.City;
                vl.RegionID = this.CurrentUser.RegionID;
                vl.RegionAbbrev = this.CurrentUser.RegionAbbrev;
            }
            vt.Location = vl;

            return PartialView("_Team", vt);
        }

        public ActionResult LeagueSearch(int UserTeamID)
        {
            ViewLeague vl = new ViewLeague();
            vl.Regions = GetRegions(0);
            vl.UserTeamID = UserTeamID;
            return PartialView("_LeagueSearch", vl);
        }

        public ActionResult TeamLeagueRequest(ViewLeague vl)
        {
            ViewTeamLeagueRequest vtlr = new ViewTeamLeagueRequest();
            vtlr.ViewLeagues = GetLeagues(vl);
            vtlr.UserTeamID = vl.UserTeamID;
            return PartialView("_TeamLeagueRequest", vtlr);
        }

        public ActionResult SaveTeamLeagueRequest(int SeasonID, int UserTeamID)
             {
            BizMgr.SaveTeamLeagueRequest(SeasonID, UserTeamID);
            ViewTeam vt = new ViewTeam();
            Season s = BizMgr.GetSeason(SeasonID);
            Team t = BizMgr.GetTeamByUserTeamID(UserTeamID);

            vt.LeagueName = s.LeagueName;
            vt.TeamName = t.TeamName;
            vt.SeasonDescription = s.Description + "(" + s.StartDate.ToShortDateString() + " - " + s.EndDate.ToShortDateString() + ")";
            return PartialView("_RequestConfirmation", vt);
        }

        public ActionResult TeamSeasons(int TeamID)
        {
            return PartialView("_TeamSeasons", GetTeamSeasons(TeamID));
        }
        public ActionResult SwimmerTeamSeasons(int TeamSeasonID)
        {
            return PartialView("_SwimmerTeamSeasons", GetSwimmerTeamSeasons(TeamSeasonID));
        }
        public ActionResult SwimmerTeamRequests(int TeamSeasonID)
        {
            return PartialView("_SwimmerTeamRequests", GetSwimmerTeamRequests(TeamSeasonID));
        }
        public ActionResult ApproveRequest(int SwimmerTeamRequestID, int TeamSeasonID)
        {
            BizMgr.ApproveSwimmerTeamRequest(SwimmerTeamRequestID, this.CurrentUser.SystemUserID);
            return PartialView("_SwimmerTeamSeasons", GetSwimmerTeamSeasons(TeamSeasonID));
        }

        [HttpPost]
        public ActionResult SaveTeam(ViewTeam model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    Team team = new Team();
                    team.TeamID = model.TeamID;
                    team.TeamName = model.TeamName;
                    team.Abbrev = model.Abbrev;
                    team.HomePoolConfigID = model.HomePoolConfigID;
                    model.TeamID = BizMgr.SaveTeam(team);

                    BizMgr.SaveUserTeam(model.TeamID, this.CurrentUser.SystemUserID);
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "Team=" + model.TeamID.ToString());
            }
            return PartialView("_Teams", GetTeams());
        }

        public JsonResult GetLocations(int RegionID, string City)
        {
            LocationCollection locations = BizMgr.GetLocationsByCityRegionID(City, RegionID);
            List<ViewLocation> vls = new List<ViewLocation>();
            ViewLocation vl = null;
            foreach (Location location in locations)
            {
                vl = new ViewLocation();
                vl.Latitude = location.Latitude;
                vl.Longitude = location.Longitude;
                vl.Name = location.Name;
                vl.LocationID = location.LocationID;
                vls.Add(vl);
            }
            return this.Json(vls);
        }
        #endregion

        #region Private Methods

        private ViewPoolConfig GetPoolConfig(int UserTeamID)
        {
            PoolConfig pc = BizMgr.GetPoolConfigByUserTeamID(UserTeamID);
            ViewPoolConfig vpc = new ViewPoolConfig();
            vpc.Description = pc.Description;
            vpc.LaneCount = pc.LaneCount;
            vpc.LengthDescription = pc.LengthDescription;
            vpc.LocationName = pc.LocationName;
            vpc.PoolConfigID = pc.PoolConfigID;
            vpc.City = pc.City;
            vpc.RegionAbbrev = pc.RegionAbbrev;
            vpc.RegionID = pc.RegionID;
            return vpc;
        }

        private ViewTeams GetTeams()
        {
            TeamCollection Teams = BizMgr.GetTeamsBySystemUserID(this.CurrentUser.SystemUserID);
            ViewTeams vts = new ViewTeams();
            ViewTeam vt;
            PoolConfig homePoolConfig = null;
            foreach (Team Team in Teams)
            {
                vt = new ViewTeam();
                vt.TeamName = Team.TeamName;
                vt.Abbrev = Team.Abbrev;
                vt.TeamID = Team.TeamID;
                vt.LocationName = Team.LocationName;
                vt.UserTeamID = Team.UserTeamID;
                vt.IsAdmin = Team.IsAdmin;

                homePoolConfig = BizMgr.GetPoolConfig(Team.HomePoolConfigID);
                vt.HomePoolConfig.LengthDescription = homePoolConfig.LengthDescription;
                vt.HomePoolConfig.LaneCount = homePoolConfig.LaneCount;
                vt.Address = homePoolConfig.Address;
                vt.CityStateZip = homePoolConfig.CityStateZip;
                vts.ViewTeamList.Add(vt);
            }

            return vts;
        }

        private ViewTeam GetTeam(int UserTeamID)
        {
            Team Team = BizMgr.GetTeamByUserTeamID(UserTeamID);
            ViewTeam vt = new ViewTeam();
            vt.TeamName = Team.TeamName;
            vt.Abbrev = Team.Abbrev;
            vt.TeamID = Team.TeamID;
            vt.UserTeamID = Team.UserTeamID;
            return vt;
        }

        private List<ViewSeason> GetTeamSeasons(int TeamID)
        {
            List<ViewSeason> vss = new List<ViewSeason>();
            ViewSeason vs = new ViewSeason();
            SeasonCollection seasons = BizMgr.GetSeasonsByTeamID(TeamID);
            foreach (Season season in seasons)
            {
                vs = new ViewSeason();
                vs.Description = season.Description;
                vs.EndDate = season.EndDate;
                vs.LeagueID = season.LeagueID;
                vs.LeagueName = season.LeagueName;
                vs.LeagueDescription = season.LeagueDescription;
                vs.SeasonID = season.SeasonID;
                vs.StartDate = season.StartDate;
                vs.TeamSeasonID = season.TeamSeasonID;
                vss.Add(vs);
            }
            return vss;
        }
        private List<ViewLeague> GetLeagues(ViewLeague viewLeague)
        {
            SeasonCollection seasons = BizMgr.GetSeasonsBySearch(viewLeague.LeagueName, viewLeague.RegionID);
            ViewLeague vl = null;
            List<ViewLeague> vls = new List<ViewLeague>();
            foreach (Season season in seasons)
            {
                vl = new ViewLeague();
                vl.EndDate = season.EndDate;
                vl.LeagueName = season.LeagueName;
                vl.LeagueDescription = season.LeagueDescription;
                vl.SeasonDescription = season.Description;
                vl.StartDate = season.StartDate;
                vl.SeasonID = season.SeasonID;
                vls.Add(vl);
            }
            return vls;
        }

        private ViewSwimmers GetSwimmerTeamSeasons(int TeamSeasonID)
        {
            ViewSwimmers vss = new ViewSwimmers();
            ViewSwimmer vs = null;

            Team team = BizMgr.GetTeamByTeamSeasonID(TeamSeasonID);
            TeamCollection teams = BizMgr.GetTeamsBySystemUserID(this.CurrentUser.SystemUserID);
            var adminTeams = teams.Where<Team>(t => t.TeamID == team.TeamID && t.IsAdmin);
            vss.IsAdmin = adminTeams.Count() > 0;

            SwimmerCollection Swimmers = BizMgr.GetSwimmersByTeamSeasonID(TeamSeasonID);
            foreach (Swimmer swimmer in Swimmers)
            {
                vs = new ViewSwimmer();
                vs.Age = BizMgr.GetAgeAtDate(swimmer.BirthDate, DateTime.Today);
                vs.BirthDate = swimmer.BirthDate;
                vs.LastFirstName = swimmer.LastFirstName;
                vs.IsMale = swimmer.IsMale;
                vss.ViewSwimmerList.Add(vs);
            }
            return vss;
        }
        private List<ViewSwimmer> GetSwimmerTeamRequests(int TeamSeasonID)
        {
            List<ViewSwimmer> vss = new List<ViewSwimmer>();
            ViewSwimmer vs = null;
            SwimmerCollection Swimmers = BizMgr.GetSwimmerTeamRequestsBySystemUserIDTeamSeasonID(this.CurrentUser.SystemUserID, TeamSeasonID);
            foreach (Swimmer swimmer in Swimmers)
            {
                vs = new ViewSwimmer();
                vs.Age = BizMgr.GetAgeAtDate(swimmer.BirthDate, DateTime.Today);
                vs.BirthDate = swimmer.BirthDate;
                vs.LastFirstName = swimmer.LastFirstName;
                vs.TeamSeasonID = swimmer.TeamSeasonID;
                vs.IsMale = swimmer.IsMale;
                vs.SwimmerTeamRequestID = swimmer.SwimmerTeamRequestID;
                vss.Add(vs);
            }
            return vss;
        }
        #endregion
    }
}
