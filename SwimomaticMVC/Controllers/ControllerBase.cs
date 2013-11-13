using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using SwimomaticMVC.Models;
using SwimomaticBusinessLib;
using Swimomatic.Entity;
using SwimomaticMVC.Helpers;
using LAAF.Logger;
using Helpers;
using Microsoft.Practices.Unity;
using DataDynamics.ActiveReports.Export.Pdf;
using DataDynamics.ActiveReports;
using System.IO;

namespace SwimomaticMVC.Controllers
{
    public class ControllerBase : Controller
    {
        public ControllerBase()
            : this(UnityContainerWrapper.Container.Resolve<ICacheService>())
        {
        }

        public ControllerBase(ICacheService cacheService)
        {
            this.DataCache = cacheService;
        }

        #region Properties
        private SwimomaticBusinessManager _BizMgr;
        internal SwimomaticBusinessManager BizMgr
        {
            get
            {
                if (_BizMgr == null)
                {
                    _BizMgr = new SwimomaticBusinessManager();
                }
                return _BizMgr;
            }
        }

        public CurrentUserBase CurrentUser
        {
            get
            {
                return (CurrentUserBase)HttpContext.Cache["CurrentUser"];
            }
            set
            {
                HttpContext.Cache["CurrentUser"] = value;
            }
        }

        protected ICacheService DataCache { get; set; }

        #endregion

        #region Event Handlers
        protected override void OnActionExecuting(ActionExecutingContext filterContext)
        {
            if (CurrentUser != null)
            {
                filterContext.Controller.ViewBag.Username = CurrentUser.UserName;
                ViewBag.FirstLastName = string.IsNullOrEmpty(CurrentUser.FirstLastName) ? " " : CurrentUser.FirstLastName;
            }
            else
            {
                if (!string.IsNullOrEmpty(SwimomaticMVC.MvcApplication.UserName))
                {
                    filterContext.Controller.ViewBag.Username = SwimomaticMVC.MvcApplication.UserName;
                    SystemUser su = BizMgr.GetSystemUserByUserName(SwimomaticMVC.MvcApplication.UserName);
                    SetCurrentUser(su);
                }
                else
                {
                    filterContext.Controller.ViewBag.Username = " ";
                }
            }

            base.OnActionExecuting(filterContext);
        }

        protected void SetCurrentUser(SystemUser su)
        {
            try
            {
                this.CurrentUser = new CurrentUserBase(su);
                //UserLeagueCollection uls = BizMgr.GetUserLeaguesBySystemUserID(su.SystemUserID);
                //foreach (UserLeague ul in uls)
                //{
                //    League l = BizMgr.GetLeague(ul.LeagueID);
                //    if (!this.CurrentUser.Leagues.Contains(l))
                //    {
                //        this.CurrentUser.Leagues.Add(l);
                //    }
                //}
                //UserTeamCollection uts = BizMgr.GetUserTeamsBySystemUserID(su.SystemUserID);
                //foreach (UserTeam ut in uts)
                //{
                //    Team t = BizMgr.GetTeam(ut.TeamID);
                //    if (!this.CurrentUser.Teams.Contains(t))
                //    {
                //        this.CurrentUser.Teams.Add(t);
                //    }
                //}
                //UserSwimmerCollection uss = BizMgr.GetUserSwimmersBySystemUserID(su.SystemUserID);
                //foreach (UserSwimmer us in uss)
                //{
                //    Swimmer s = BizMgr.GetSwimmer(us.SwimmerID);
                //    if (!this.CurrentUser.Swimmers.Contains(s))
                //    {
                //        this.CurrentUser.Swimmers.Add(s);
                //    }
                //}
                //UserSwimMeetCollection usms = BizMgr.GetUserSwimMeetsBySystemUserID(su.SystemUserID);
                //foreach (UserSwimMeet usm in usms)
                //{
                //    SwimMeet sm = BizMgr.GetSwimMeet(usm.SwimMeetID);
                //    if (!this.CurrentUser.SwimMeets.Contains(sm))
                //    {
                //        this.CurrentUser.SwimMeets.Add(sm);
                //    }
                //}
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "", "UserID=" + su.SystemUserID.ToString());
            }
        }

        #endregion

        #region Methods

        #region Action Methods

        #endregion

        /// <summary>
        /// Gets list of all regions to populate dropdown list
        /// </summary>
        /// <returns></returns>
        protected SelectList GetRegions(int RegionID)
        {
            RegionCollection regions = BizMgr.GetRegions();
            if (RegionID > 0)
            {
                return new SelectList(regions, "RegionID", "RegionName", RegionID);
            }
            else
            {
                return new SelectList(regions, "RegionID", "RegionName");
            }
        }

        protected SelectList GetRegions(int RegionID, string Text, string Value)
        {
            RegionCollection regions = BizMgr.GetRegions();
            if (RegionID > 0)
            {
                return new SelectList(regions, Value, Text, RegionID);
            }
            else
            {
                return new SelectList(regions, Value, Text);
            }
        }

        /// <summary>
        /// Gets the list of all Cities from all the Locations in the given region
        /// </summary>
        /// <param name="RegionID"></param>
        /// <returns></returns>
        public object GetCities(int RegionID)
        {
            List<SwimomaticBusinessLib.ListItem> itemList = null;
            try
            {
                if (RegionID == 0)
                {
                    return new SelectList(new List<SwimomaticBusinessLib.ListItem>(), "City", "City");
                }
                else
                {
                    LocationCollection locations = BizMgr.GetLocationsByRegionID(RegionID);
                    var ls = locations.GroupBy(l => l.City.ToUpper()).Select(l => l.First());
                    itemList = SwimomaticBusinessLib.Utility.GetListItemsFromLAAFCollection(ls, "City", "City", "Cities");
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + CurrentUser.SystemUserID.ToString(), "");
            }
            return this.Json(itemList);
        }

        protected SelectList GetUOMs(int UOMID)
        {
            UOMCollection uoms = BizMgr.GetUOMs();
            if (UOMID > 0)
            {
                return new SelectList(uoms, "UOMID", "Description", UOMID);
            }
            else
            {
                return new SelectList(uoms, "UOMID", "Description");
            }
        }

        //TODO:  Get this out of basecontroller
        protected ViewHeats GetHeats(int HeatSheetEventID)
        {
            ViewHeats vhs = new ViewHeats();
            ViewHeat vh;
            HeatCollection heats = BizMgr.GetHeatsByHeatSheetEventID(HeatSheetEventID);

            SwimMeet sm = BizMgr.GetSwimMeetByHeatSheetEventID(HeatSheetEventID);
            SwimMeetCollection swimMeets = BizMgr.GetSwimMeetsBySystemUserID(this.CurrentUser.SystemUserID);
            var smAdmin = swimMeets.Where<SwimMeet>(vl => vl.SwimMeetID == sm.SwimMeetID && vl.IsAdmin);
            vhs.IsAdmin = smAdmin.Count() > 0;

            int laneCount = 1;
            bool isRelay = false;
            if (heats.Count > 0)
            {
                PoolConfig poolConfig = BizMgr.GetPoolConfigByHeatID(heats[0].HeatID);
                laneCount = poolConfig.LaneCount;
                Stroke stroke = BizMgr.GetStrokeByHeatID(heats[0].HeatID);
                isRelay = stroke.IsRelay;
            }

            List<ViewHeatSwimmer> vhss = new List<ViewHeatSwimmer>();
            foreach (Heat heat in heats)
            {
                vh = new ViewHeat();
                vh.HeatID = heat.HeatID;
                vh.HeatNumber = heat.HeatNumber;
                vh.LaneCount = laneCount;
                vh.IsRelay = isRelay;
                vh.HeatSheetEventID = heat.HeatSheetEventID;
                vhss = GetHeatSwimmers(heat.HeatID);
                if (vhss.Count > 0)
                {
                    vh.ViewHeatSwimmers.AddRange(vhss);
                }
                vhs.ViewHeatList.Add(vh);
            }
            return vhs;
        }

        private List<ViewHeatSwimmer> GetHeatSwimmers(int HeatID)
        {
            List<ViewHeatSwimmer> vhss = new List<ViewHeatSwimmer>();
            ViewHeatSwimmer vhs;
            PoolConfig pc = null;
            Result r = null;
            HeatSwimmerCollection heatSwimmers = BizMgr.GetHeatSwimmersByHeatID(HeatID);
            foreach (HeatSwimmer heatSwimmer in heatSwimmers)
            {
                vhs = new ViewHeatSwimmer();
                vhs.LaneNumber = heatSwimmer.LaneNumber;
                vhs.Leg = heatSwimmer.Leg;
                vhs.LastFirstName = heatSwimmer.LastFirstName;
                vhs.Disqualified = heatSwimmer.Disqualified;
                vhs.ElapsedTime = heatSwimmer.ElapsedTime;
                vhs.ElapsedTimeString = SwimomaticBusinessLib.Utility.GetTimeFromSeconds(heatSwimmer.ElapsedTime);
                vhs.Place = heatSwimmer.Place;
                vhs.Points = heatSwimmer.Points;

                if (pc == null)
                {
                    pc = BizMgr.GetPoolConfigByHeatSheetEventID(heatSwimmer.HeatSheetEventID);
                }

                //TODO:Figure out what to do if event is seeded by split instead of ET
                r = BizMgr.GetResult(heatSwimmer.SeedResultID);
                vhs.SeedTime = BizMgr.GetConvertedTime(r.LaneLength, r.UOMID, r.ElapsedTime, pc.LaneLength, pc.UOMID);
                vhs.SeedTimeString = SwimomaticBusinessLib.Utility.GetTimeFromSeconds(vhs.SeedTime);
                vhs.Split = heatSwimmer.Split;
                vhs.SplitString = SwimomaticBusinessLib.Utility.GetTimeFromSeconds(heatSwimmer.Split);
                vhs.TeamNameAbbrev = heatSwimmer.Abbrev;
                vhs.HeatSwimmerID = heatSwimmer.HeatSwimmerID;
                vhss.Add(vhs);
            }

            return vhss;
        }

        #endregion

    }
}