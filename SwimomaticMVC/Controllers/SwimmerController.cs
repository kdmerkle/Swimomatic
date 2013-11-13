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
    public class SwimmerController : ControllerBase
    {

        #region Action Methods
        public ActionResult Index()
        {
            try
            {
                ViewBag.Swimmers = GetSwimmers();
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "SwimmerController.Index");
            }
            return View();
        }

        public ActionResult Swimmer(int UserSwimmerID)
        {
            try
            {
                ViewBag.Swimmer = GetSwimmer(UserSwimmerID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "UserSwimmer=" + UserSwimmerID.ToString());
            }
            return PartialView("_Swimmer");
        }

        public ActionResult TeamSearch(int UserSwimmerID)
        {
            ViewBag.Regions = GetRegions(0);
            ViewBag.Cities = new List<SelectListItem>();
            ViewBag.UserSwimmerID = UserSwimmerID;

            return PartialView("_TeamSearch");
        }

        public ActionResult SwimmerTeamRequest(ViewTeam vt)
        {
            ViewBag.Teams = GetTeams(vt);
            return PartialView("_SwimmerTeamRequest");
        }

        public ActionResult SaveSwimmerTeamRequest(int TeamSeasonID, int UserSwimmerID)
        {
            BizMgr.SaveSwimmerTeamRequest(TeamSeasonID, UserSwimmerID);
            ViewBag.ViewSwimmer = GetSwimmer(UserSwimmerID);
            ViewBag.ViewTeam = GetTeamSeason(TeamSeasonID);
            return PartialView("_RequestConfirmation");
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult SaveSwimmer(ViewSwimmer model)
        {
            try
            {
                if (ModelState.IsValid)
                {
                    Swimmer swimmer = new Swimmer();
                    swimmer.SwimmerID = model.SwimmerID;
                    swimmer.LastName = model.LastName;
                    swimmer.FirstName = model.FirstName;
                    swimmer.BirthDate = model.BirthDate;
                    swimmer.IsMale = model.IsMale;
                    model.SwimmerID = BizMgr.SaveSwimmer(swimmer);

                    BizMgr.SaveUserSwimmer(model.SwimmerID, this.CurrentUser.SystemUserID);
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "Swimmer=" + model.SwimmerID.ToString());
            }
            ViewBag.Swimmers = GetSwimmers();
            return PartialView("_Swimmers");
        }
        #endregion

        #region Private Methods
        private List<ViewSwimmer> GetSwimmers()
        {
            SwimmerCollection swimmers = BizMgr.GetSwimmersBySystemUserID(this.CurrentUser.SystemUserID);
            List<ViewSwimmer> vss = new List<ViewSwimmer>();
            ViewSwimmer vs;
            foreach (Swimmer swimmer in swimmers)
            {
                vs = new ViewSwimmer();
                vs.Age = BizMgr.GetAgeAtDate(swimmer.BirthDate, DateTime.Today);
                vs.BirthDate = swimmer.BirthDate;
                vs.IsMale = swimmer.IsMale;
                vs.LastFirstName = swimmer.LastFirstName;
                vs.SwimmerID = swimmer.SwimmerID;
                vs.UserSwimmerID = swimmer.UserSwimmerID;
                vss.Add(vs);
            }

            return vss;
        }

        private ViewSwimmer GetSwimmer(int UserSwimmerID)
        {
            Swimmer swimmer = BizMgr.GetSwimmerByUserSwimmerID(UserSwimmerID);
            ViewSwimmer vs = new ViewSwimmer();
            vs.UserSwimmerID = UserSwimmerID;
            vs.IsMale = (swimmer.SwimmerID == 0) ? true : swimmer.IsMale;
            vs.BirthDate = swimmer.BirthDate;
            vs.LastName = swimmer.LastName;
            vs.FirstName = swimmer.FirstName;
            vs.SwimmerID = swimmer.SwimmerID;
            return vs;
        }

        private ViewTeams GetTeams(ViewTeam viewTeam)
        {
            TeamCollection teams = BizMgr.GetTeamBySearch(viewTeam.Address, viewTeam.City, viewTeam.PostalCode, viewTeam.RegionID, viewTeam.TeamName);
            ViewTeams vts = new ViewTeams();
            vts.UserSwimmerID = viewTeam.UserSwimmerID;
            ViewTeam vt = null;
            foreach (Team team in teams)
            {
                vt = new ViewTeam();
                vt.Address = team.Address;
                vt.City = team.City;
                vt.EndDate = team.EndDate;
                vt.LeagueName = team.LeagueName;
                vt.LocationName = team.LocationName;
                vt.PostalCode = team.PostalCode;
                vt.SeasonDescription = team.SeasonDescription;
                vt.StartDate = team.StartDate;
                vt.TeamNameAbbrev = team.TeamNameAbbrev;
                vt.TeamSeasonID = team.TeamSeasonID;
                vts.ViewTeamList.Add(vt);
            }
            return vts;
        }


        private ViewTeam GetTeamSeason(int TeamSeasonID)
        {
            ViewTeam vt = new ViewTeam();
            Team team = BizMgr.GetTeamByTeamSeasonID(TeamSeasonID);
            vt.TeamName = team.TeamName;
            vt.SeasonDescription = team.SeasonDescription;
            return vt;
        }

        #endregion
    }
}
