using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using SwimomaticMVC.Models;
using Swimomatic.Entity;
using SwimomaticBusinessLib;
using LAAF.Logger;
using System.Threading.Tasks;

namespace SwimomaticMVC.Controllers
{
    public class HeatSheetController : ControllerBase
    {

        #region Action Methods

        public ActionResult Index(int id)
        {
            try
            {
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "SwimMeetID=" + id.ToString());
            }
            return View("Index", id);
        }

        public ActionResult SwimMeet(int SwimMeetID)
        {
            ViewSwimMeet vsm = GetSwimMeet(SwimMeetID);
            return PartialView("_SwimMeet", vsm);
        }

        public ActionResult HeatSheets(int SwimMeetID)
        {
            ViewHeatSheets vhsl = new ViewHeatSheets();
            vhsl.ViewPoolConfigs = GetHeatSheets(SwimMeetID);
            vhsl.SwimMeetID = SwimMeetID;

            SwimMeetCollection swimMeets = BizMgr.GetSwimMeetsBySystemUserID(this.CurrentUser.SystemUserID);
            var smAdmin = swimMeets.Where<SwimMeet>(vl => vl.SwimMeetID == SwimMeetID && vl.IsAdmin);
            vhsl.IsAdmin = smAdmin.Count() > 0;

            return PartialView("_HeatSheets", vhsl);
        }

        //public ActionResult HeatSheet(int id)
        //{
        //    int HeatSheetID = id;
        //    try
        //    {
        //        ViewBag.PoolConfig = GetPoolConfig(HeatSheetID);
        //        ViewBag.HeatSheetEvents = GetHeatSheetEvents(HeatSheetID);
        //    }
        //    catch (Exception ex)
        //    {
        //        LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetID=" + HeatSheetID.ToString());
        //    }
        //    return PartialView("_HeatSheet");
        //}

        public ActionResult HeatSheetEvents(int HeatSheetID)
        {
            ViewHeatSheetEvents vhse = new ViewHeatSheetEvents();
            try
            {
                vhse = DataCache.Get<ViewHeatSheetEvents>("HeatSheetEvents" + HeatSheetID.ToString(), () => GetHeatSheetEvents(HeatSheetID));
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetID=" + HeatSheetID.ToString());
            }
            return PartialView("_HeatSheetEvents", vhse);
        }


        private ViewHeatSwimmers GetHeatSwimmers(int HeatSheetID)
        {
            ViewHeatSwimmers vhs = new ViewHeatSwimmers();
            HeatSwimmerCollection heatSwimmers = BizMgr.GetHeatSwimmersByHeatSheetID(HeatSheetID);


            return vhs;

        }

        public ActionResult HeatSheetEventsByUser(int HeatSheetID)
        {
            ViewHeatSheetEvents vhse = new ViewHeatSheetEvents();
            try
            {
                vhse = DataCache.Get<ViewHeatSheetEvents>("HeatSheetEventsByUser" + HeatSheetID.ToString(), () => GetHeatSheetEventsByUser(HeatSheetID));
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetID=" + HeatSheetID.ToString());
            }
            return PartialView("_HeatSheetEvents", vhse);
        }

        public ActionResult HeatSheetTeams(int PoolConfigID, int SwimMeetID)
        {
            try
            {
                ViewBag.HeatSheetTeams = GetHeatSheetTeams(PoolConfigID, SwimMeetID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetID=" + SwimMeetID.ToString());
            }
            return PartialView("_HeatSheetTeams");
        }

        public ActionResult PoolConfigs(int SwimMeetID)
        {
            try
            {
                ViewBag.PoolConfigs = GetPoolConfigs(SwimMeetID);
                ViewBag.SwimMeetID = SwimMeetID;
                Location l = BizMgr.GetLocationBySwimMeetID(SwimMeetID);
                ViewBag.LocationID = l.LocationID;
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "SwimMeetID=" + SwimMeetID.ToString());
            }
            return PartialView("_PoolConfigs");
        }

        public ActionResult Heats(int HeatSheetEventID)
        {
            ViewHeats vhs = new ViewHeats();
            try
            {
                vhs = DataCache.Get<ViewHeats>("Heats" + HeatSheetEventID.ToString(), () => GetHeats(HeatSheetEventID));
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetEventID=" + HeatSheetEventID.ToString());
            }
            return PartialView("_Heats", vhs);
        }

        public ActionResult AddHeat(int HeatSheetEventID)
        {
            try
            {
                BizMgr.AddHeat(HeatSheetEventID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetEventID=" + HeatSheetEventID.ToString());
            }
            return Heats(HeatSheetEventID);
        }

        public ActionResult DeleteHeat(int HeatID, int HeatSheetEventID)
        {
            try
            {
                BizMgr.DeleteHeat(HeatID, HeatSheetEventID);
                DataCache.Remove("Heats" + HeatSheetEventID.ToString());
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatID=" + HeatID.ToString() + "HeatSheetEventID=" + HeatSheetEventID.ToString());
            }
            return Heats(HeatSheetEventID);
        }
        [HttpPost]
        public ActionResult ResequenceHeatSheetEvents(ViewHeatSheetEventSequence HeatSheetEventSequence)
        {
            try
            {
                BizMgr.ReSequenceHeatSheetEvents(HeatSheetEventSequence.HeatSheetID, HeatSheetEventSequence.HeatSheetEventIDs);
                DataCache.Remove("HeatSheetEvents" + HeatSheetEventSequence.HeatSheetID.ToString());
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetID=" + HeatSheetEventSequence.HeatSheetID.ToString());
                //return RedirectToAction("Error", "Home", new RouteValueDictionary { { "LogID", LogError(ex, LALogger.LogEntryType.NormalError, (CurrentUser != null) ? CurrentUser.UserFullName : "", "", "", "", null).ToString() } });
            }
            return new EmptyResult();
        }

        public ActionResult DeleteHeatSheetEvent(int HeatSheetEventID, int HeatSheetID)
        {
            try
            {
                BizMgr.DeleteHeatSheetEvent(HeatSheetEventID, HeatSheetID);
                DataCache.Remove("HeatSheetEvents" + HeatSheetID.ToString());
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetID=" + HeatSheetID.ToString());
            }
            return HeatSheetEvents(HeatSheetID);
        }

        public ActionResult HeatSheetEvent(int HeatSheetID)
        {
            ViewHeatSheetEvent vhse = null;
            try
            {
                vhse = GetHeatSheetEvent(HeatSheetID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetID=" + HeatSheetID.ToString());
            }
            return PartialView("_HeatSheetEvent", vhse);
        }

        public ActionResult GetAvailableSwimmers(int HeatID)
        {
            ViewAddSwimmer vas = null;
            try
            {
                vas = GetAvailableSwimmerList(HeatID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatID=" + HeatID.ToString());
            }
            return PartialView("_AddSwimmer", vas);
        }

        public ActionResult GetEligibleSwimmers(int HeatSheetEventID)
        {
            ViewEligibleSwimmers vess = null;
            try
            {
                vess = GetEligibleSwimmerList(HeatSheetEventID);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetEventID=" + HeatSheetEventID.ToString());
            }
            return PartialView("_EligibleSwimmers", vess);
        }

        public ActionResult AddHeatSwimmer(int HeatID, int SwimmerTeamSeasonID, int Leg, int LaneNumber)
        {
            Heat h = null;
            try
            {
                h = BizMgr.GetHeat(HeatID);
                BizMgr.AddHeatSwimmer(HeatID, SwimmerTeamSeasonID, Leg, LaneNumber);
                DataCache.Remove("Heats" + h.HeatSheetEventID.ToString());
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatID=" + HeatID.ToString() + "SwimmerTeamSeasonID=" + SwimmerTeamSeasonID.ToString() + "LaneNumber=" + LaneNumber.ToString());
            }
            return Heats(h.HeatSheetEventID);
        }


        public ActionResult RemoveHeatSwimmer(int HeatSwimmerID)
        {
            Heat h = null;
            try
            {
                h = BizMgr.GetHeatByHeatSwimmerID(HeatSwimmerID);
                BizMgr.RemoveHeatSwimmer(HeatSwimmerID);
                DataCache.Remove("Heats" + h.HeatSheetEventID.ToString());
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSwimmerID=" + HeatSwimmerID.ToString());
            }
            return Heats(h.HeatSheetEventID);
        }

        public ActionResult IncrementLane(int HeatID, int HeatSwimmerID, int Move, int IsRelay)
        {
            Heat h = null;
            try
            {
                h = BizMgr.GetHeat(HeatID);
                if (IsRelay == 0)
                {
                    BizMgr.IncrementHeatSwimmerLane(HeatID, HeatSwimmerID, Move);
                }
                else
                {
                    BizMgr.IncrementHeatSwimmerLaneForRelay(HeatID, HeatSwimmerID, Move);
                }
                DataCache.Remove("Heats" + h.HeatSheetEventID.ToString());
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSwimmerID=" + HeatSwimmerID.ToString());
            }
            return Heats(h.HeatSheetEventID);
        }

        public ActionResult IncrementLeg(int HeatID, int HeatSwimmerID, int Move)
        {
            Heat h = null;
            try
            {
                h = BizMgr.GetHeat(HeatID);
                BizMgr.IncrementHeatSwimmerLeg(HeatID, HeatSwimmerID, Move);
                DataCache.Remove("Heats" + h.HeatSheetEventID.ToString());
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSwimmerID=" + HeatSwimmerID.ToString());
            }
            return Heats(h.HeatSheetEventID);
        }

        [HttpPost]
        public ActionResult SaveHeatSheet(ViewHeatSheet viewHeatSheet)
        {
            int heatSheetID = BizMgr.SaveHeatSheet(viewHeatSheet.PoolConfigID, viewHeatSheet.SwimMeetID);

            Dictionary<int, string> heatSheetTeams = new Dictionary<int, string>();
            foreach (ViewHeatSheetTeam hst in viewHeatSheet.HeatSheetTeams)
            {
                if (!heatSheetTeams.Keys.Contains(hst.TeamSeasonID))
                {
                    heatSheetTeams.Add(hst.TeamSeasonID, hst.LaneNumber.ToString());
                }
                else
                {
                    heatSheetTeams[hst.TeamSeasonID] += "|" + hst.LaneNumber.ToString();
                }
            }

            HeatSheetTeam heatSheetTeam = null;
            foreach (KeyValuePair<int, string> item in heatSheetTeams)
            {
                heatSheetTeam = new HeatSheetTeam();
                heatSheetTeam.HeatSheetID = heatSheetID;
                heatSheetTeam.TeamSeasonID = item.Key;
                heatSheetTeam.Lanes = item.Value;
                BizMgr.SaveHeatSheetTeam(heatSheetTeam);
            }
            ViewBag.SwimMeetID = viewHeatSheet.SwimMeetID;
            return PartialView("_HeatSheets", GetHeatSheets(viewHeatSheet.SwimMeetID));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult SaveHeatSheetEvent(ViewHeatSheetEvent vsme)
        {
            Swimomatic.Entity.HeatSheetEvent heatSheetEvent = null;
            try
            {
                bool isValid = true;
                heatSheetEvent = GetHeatSheetEventFromVSME(vsme);
                if (!vsme.ValidateHeatSheetEvent(ModelState))
                {
                    isValid = false;
                }
                if (isValid && BizMgr.HeatSheetEventExists(vsme.Distance, heatSheetEvent.SwimEventID, vsme.HeatSheetID))
                {
                    ModelState.AddModelError("Event", "This event already exists.");
                    isValid = false;
                }

                if (!isValid)
                {
                    ViewBag.HeatSheetEvent = GetHeatSheetEvent(vsme.HeatSheetID);
                    return PartialView("_HeatSheetEvent");
                }
                else
                {
                    heatSheetEvent.HeatSheetEventID = BizMgr.SaveHeatSheetEvent(heatSheetEvent);

                    //Clear the cached so new event will be included in response
                    DataCache.Remove("HeatSheetEvents" + heatSheetEvent.HeatSheetID.ToString());
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetID=" + vsme.HeatSheetEventID.ToString());
            }
            return GetEligibleSwimmers(heatSheetEvent.HeatSheetEventID);
        }

        [HttpPost]
        public ActionResult SeedHeatSheetEvent(ViewEligibleSwimmers vess)
        {
            HeatSheetEvent hse = BizMgr.GetHeatSheetEvent(vess.HeatSheetEventID);
            try
            {
                List<int> selectedSwimmerTeamSeasonIDs = new List<int>();
                foreach (ViewEligibleSwimmer swimmer in vess.ViewEligibleSwimmerList)
                {
                    selectedSwimmerTeamSeasonIDs.Add(swimmer.SwimmerTeamSeasonID);
                }
                BizMgr.SeedHeatSheetEvent(vess.HeatSheetEventID, selectedSwimmerTeamSeasonIDs);

                //Clear the cache so new event will be included in response
                DataCache.Remove("HeatSheetEvents" + hse.HeatSheetID.ToString());
                DataCache.Remove("Heats" + vess.HeatSheetEventID.ToString());
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "HeatSheetID=" + vess.HeatSheetEventID.ToString());
            }
            return Heats(vess.HeatSheetEventID);
        }


        #endregion

        #region Private Methods

        private ViewTeams GetHeatSheetTeams(int PoolConfigID, int SwimMeetID)
        {
            ViewTeams vts = new ViewTeams();
            PoolConfig ppc = BizMgr.GetPoolConfig(PoolConfigID);
            vts.LaneCount = ppc.LaneCount;
            vts.SwimMeetID = SwimMeetID;

            ViewTeam vt = null;
            TeamCollection teams = BizMgr.GetTeamsBySwimMeetID(SwimMeetID);
            foreach (Team team in teams)
            {
                vt = new ViewTeam();
                vt.Abbrev = team.Abbrev;
                vt.TeamID = team.TeamID;
                vt.TeamSeasonID = team.TeamSeasonID;
                vt.TeamName = team.TeamName;
                vt.TeamNameAbbrev = team.TeamNameAbbrev;
                vts.ViewTeamList.Add(vt);
            }
            return vts;
        }

        private List<ViewPoolConfig> GetPoolConfigs(int SwimMeetID)
        {
            //TODO: Filter PCs and only return those that have not been associated to an existing heat sheet for this Swim Meet
            PoolConfigCollection ppcs = BizMgr.GetPoolConfigsBySwimMeetID(SwimMeetID);
            List<ViewPoolConfig> vpcs = new List<ViewPoolConfig>();
            ViewPoolConfig vpc = null;

            foreach (PoolConfig pc in ppcs)
            {
                vpc = new ViewPoolConfig();
                vpc.LaneLength = pc.LaneLength;
                vpc.LengthDescription = pc.LengthDescription;
                vpc.UOMAbbrev = pc.UOMAbbrev;
                vpc.PoolDescription = pc.PoolDescription;
                vpc.LaneCount = pc.LaneCount;
                vpc.PoolConfigID = pc.PoolConfigID;
                vpc.PoolID = pc.PoolID;
                vpcs.Add(vpc);
            }
            return vpcs;
        }

        private List<ViewPoolConfig> GetHeatSheets(int SwimMeetID)
        {
            List<ViewPoolConfig> vhs = new List<ViewPoolConfig>();
            PoolConfig pc;
            ViewPoolConfig vpc;
            try
            {
                HeatSheetCollection heatSheets = BizMgr.GetHeatSheetsBySwimMeetID(SwimMeetID);
                foreach (HeatSheet hs in heatSheets)
                {
                    pc = BizMgr.GetPoolConfigByHeatSheetID(hs.HeatSheetID);
                    vpc = new ViewPoolConfig();
                    vpc.HeatSheetID = hs.HeatSheetID;
                    vpc.LaneLength = pc.LaneLength;
                    vpc.LaneCount = pc.LaneCount;
                    vpc.LengthDescription = pc.LengthDescription;
                    vpc.LocationName = pc.LocationName;
                    vpc.PoolConfigID = pc.PoolConfigID;
                    vpc.PoolDescription = pc.PoolDescription;
                    vpc.PoolID = pc.PoolID;
                    vpc.UOMAbbrev = pc.UOMAbbrev;
                    vpc.UOMID = pc.UOMID;
                    vhs.Add(vpc);
                }
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + base.CurrentUser.SystemUserID.ToString(), "SwimMeetID=" + SwimMeetID.ToString());
            }
            return vhs;
        }

        private HeatSheetEvent GetHeatSheetEventFromVSME(ViewHeatSheetEvent vsme)
        {
            Swimomatic.Entity.HeatSheetEvent HeatSheetEvent = new HeatSheetEvent();
            HeatSheetEvent.HeatSheetID = vsme.HeatSheetID;
            HeatSheetEvent.Distance = vsme.Distance;

            //get the SwimEvent
            SwimEvent swimEvent = BizMgr.GetSwimEventByAgeClassIDStrokeID(vsme.AgeClassID, vsme.StrokeID);
            HeatSheetEvent.SwimEventID = swimEvent.SwimEventID;

            return HeatSheetEvent;
        }

        private ViewSwimMeet GetSwimMeet(int SwimMeetID)
        {
            ViewSwimMeet vsm = new ViewSwimMeet();
            SwimMeet swimMeet = BizMgr.GetSwimMeet(SwimMeetID);
            vsm.StartDate = swimMeet.StartDate;
            vsm.SwimMeetID = swimMeet.SwimMeetID;
            vsm.Description = swimMeet.Description;
            vsm.LeagueName = swimMeet.LeagueName;
            vsm.LocationName = swimMeet.LocationName;
            vsm.SeasonDescription = swimMeet.SeasonDescription;

            TeamCollection teams = BizMgr.GetTeamsBySwimMeetID(swimMeet.SwimMeetID);
            foreach (Team team in teams)
            {
                vsm.Teams += team.TeamNameAbbrev + ", ";
            }
            char[] trim = new char[] { ',', ' ' };
            vsm.Teams = vsm.Teams.TrimEnd(trim);

            return vsm;
        }

        private ViewHeatSheetEvents GetHeatSheetEvents(int HeatSheetID)
        {
            ViewHeatSheetEvents vhses = new ViewHeatSheetEvents();
            vhses.HeatSheetID = HeatSheetID;

            SwimMeetCollection swimMeets = BizMgr.GetSwimMeetsBySystemUserID(this.CurrentUser.SystemUserID);
            var smAdmin = swimMeets.Where<SwimMeet>(vl => vl.SwimMeetID == vhses.SwimMeetID && vl.IsAdmin);
            vhses.IsAdmin = smAdmin.Count() > 0;

            HeatSwimmerCollection heatSwimmers = BizMgr.GetHeatSwimmersByHeatSheetID(HeatSheetID);

            //HeatSheet hs = BizMgr.GetHeatSheet(HeatSheetID);
            //vhses.SwimMeetID = hs.SwimMeetID;

            ViewHeatSheetEvent vhse;
            //HeatSheetEventCollection HeatSheetEvents = BizMgr.GetHeatSheetEventsByHeatSheetID(HeatSheetID);
            var hss = heatSwimmers.GroupBy(hs => hs.HeatSheetEventID).Select(grp => grp.First());

            foreach (HeatSwimmer heatSwimmer in hss)
            {
                vhse = new ViewHeatSheetEvent();
                vhse.HeatSheetEventID = heatSwimmer.HeatSheetEventID;
                vhse.Sequence = heatSwimmer.Sequence;
                vhse.Description = heatSwimmer.Description;
                vhse.HeatSheetID = heatSwimmer.HeatSheetID;
                vhses.ViewHeatSheetEventList.Add(vhse);
            }
            return vhses;
        }

        private ViewHeatSheetEvents GetHeatSheetEventsByUser(int HeatSheetID)
        {
            ViewHeatSheetEvents vhses = new ViewHeatSheetEvents();
            vhses.HeatSheetID = HeatSheetID;

            HeatSheet hs = BizMgr.GetHeatSheet(HeatSheetID);
            vhses.SwimMeetID = hs.SwimMeetID;

            SwimMeetCollection swimMeets = BizMgr.GetSwimMeetsBySystemUserID(this.CurrentUser.SystemUserID);
            var smAdmin = swimMeets.Where<SwimMeet>(vl => vl.SwimMeetID == vhses.SwimMeetID && vl.IsAdmin);
            vhses.IsAdmin = smAdmin.Count() > 0;

            ViewHeatSheetEvent vhse;
            HeatSheetEventCollection HeatSheetEvents = BizMgr.GetHeatSheetEventsByHeatSheetIDSystemUserID(HeatSheetID, this.CurrentUser.SystemUserID);
            foreach (HeatSheetEvent HeatSheetEvent in HeatSheetEvents)
            {
                vhse = new ViewHeatSheetEvent();
                vhse.HeatSheetEventID = HeatSheetEvent.HeatSheetEventID;
                vhse.Sequence = HeatSheetEvent.Sequence;
                vhse.Description = HeatSheetEvent.Description;
                vhse.HeatSheetID = HeatSheetEvent.HeatSheetID;
                vhses.ViewHeatSheetEventList.Add(vhse);
            }
            return vhses;
        }


        private ViewPoolConfig GetPoolConfig(int HeatSheetID)
        {
            ViewPoolConfig vpc = new ViewPoolConfig();
            PoolConfig pc = BizMgr.GetPoolConfigByHeatSheetID(HeatSheetID);
            vpc.LengthDescription = pc.LengthDescription;
            vpc.PoolDescription = pc.PoolDescription;
            vpc.LocationName = pc.LocationName;
            vpc.UOMAbbrev = pc.UOMAbbrev;
            return vpc;
        }


        private ViewHeatSheetEvent GetHeatSheetEvent(int HeatSheetID)
        {
            ViewHeatSheetEvent vhse = new ViewHeatSheetEvent();
            HeatSheetEvent HeatSheetEvent = BizMgr.GetHeatSheetEvent(0);
            vhse.HeatSheetEventID = HeatSheetEvent.HeatSheetEventID;
            vhse.HeatSheetID = HeatSheetID;
            vhse.Sequence = HeatSheetEvent.Sequence;
            vhse.Description = HeatSheetEvent.Description;
            vhse.AgeClassList = GetAgeClasses(0);
            vhse.StrokeList = DataCache.Get<SelectList>("StrokeList", () => GetStrokes(0));
            vhse.DistanceList = GetDistances(0);
            return vhse;
        }

        //TODO: Put distances in Database
        private SelectList GetDistances(int selectedValue)
        {
            var distances = new[] { new { distance = 0, distanceText = "<select>" }, 
                                    new { distance = 25, distanceText = "25" }, 
                                    new { distance = 50, distanceText = "50" }, 
                                    new { distance = 100, distanceText = "100" },
                                    new { distance = 200, distanceText = "200" } };
            return new SelectList(distances, "distance", "distanceText", selectedValue);
        }

        private SelectList GetAgeClasses(int selectedValue)
        {
            AgeClassCollection ageClasss = BizMgr.GetAgeClasses();
            AgeClass ageClass = new AgeClass();
            ageClass.AgeClassID = 0;
            ageClass.Description = "<select>";
            ageClasss.Add(ageClass);
            return new SelectList(ageClasss, "AgeClassID", "Description", selectedValue);
        }

        private SelectList GetStrokes(int selectedValue)
        {
            StrokeCollection strokes = BizMgr.GetStrokes();
            Stroke stroke = new Stroke();
            stroke.StrokeID = 0;
            stroke.Description = "<select>";
            strokes.Add(stroke);
            return new SelectList(strokes, "StrokeID", "Description", selectedValue);
        }

        private ViewAddSwimmer GetAvailableSwimmerList(int HeatID)
        {
            ViewAddSwimmer vas = new ViewAddSwimmer();
            vas.HeatID = HeatID;

            Heat heat = BizMgr.GetHeat(HeatID);
            vas.HeatSheetEventID = heat.HeatSheetEventID;

            Stroke stroke = BizMgr.GetStrokeByHeatID(HeatID);
            vas.IsRelay = stroke.IsRelay;

            SwimmerCollection swimmers = BizMgr.GetAvailableSwimmersByHeatID(HeatID);
            vas.HeatSwimmerList = new SelectList(swimmers, "SwimmerTeamSeasonID", "AbbrevLastFirst");

            return vas;
        }

        private ViewEligibleSwimmers GetEligibleSwimmerList(int HeatSheetEventID)
        {
            ViewEligibleSwimmers vess = new ViewEligibleSwimmers();
            vess.HeatSheetEventID = HeatSheetEventID;
            SwimmerCollection swimmers = BizMgr.GetAvailableSwimmersByHeatSheetEventID(HeatSheetEventID);

            SwimMeet sm = BizMgr.GetSwimMeetByHeatSheetEventID(HeatSheetEventID);
            Result mrResult;
            Result pbResult;
            Result sbResult;

            PoolConfig pc = BizMgr.GetPoolConfigByHeatSheetEventID(HeatSheetEventID);

            // Parallel.ForEach<Swimmer>(swimmers, delegate(Swimmer swimmer)
            foreach (Swimmer swimmer in swimmers)
            {
                ViewEligibleSwimmer ves = new ViewEligibleSwimmer();
                ves.SwimmerID = swimmer.SwimmerID;
                ves.SwimmerTeamSeasonID = swimmer.SwimmerTeamSeasonID;
                ves.LastFirstName = swimmer.LastFirstName;
                ves.TeamNameAbbrev = swimmer.Abbrev;
                ves.AgeAtMeet = BizMgr.GetAgeAtDate(swimmer.BirthDate, sm.StartDate);

                mrResult = BizMgr.GetSeedTime(HeatSheetEventID, swimmer.SwimmerID, SwimomaticBusinessManager.SeedTimeType.MostRecent);
                pbResult = BizMgr.GetSeedTime(HeatSheetEventID, swimmer.SwimmerID, SwimomaticBusinessManager.SeedTimeType.PersonalBest);
                sbResult = BizMgr.GetSeedTime(HeatSheetEventID, swimmer.SwimmerID, SwimomaticBusinessManager.SeedTimeType.SeasonBest);

                ves.MostRecent = BizMgr.GetConvertedTime(mrResult.LaneLength, mrResult.UOMID, mrResult.ElapsedTime, pc.LaneLength, pc.UOMID);
                ves.PersonalBest = BizMgr.GetConvertedTime(pbResult.LaneLength, pbResult.UOMID, pbResult.ElapsedTime, pc.LaneLength, pc.UOMID);
                ves.SeasonBest = BizMgr.GetConvertedTime(sbResult.LaneLength, sbResult.UOMID, sbResult.ElapsedTime, pc.LaneLength, pc.UOMID);

                vess.ViewEligibleSwimmerList.Add(ves);
            }
            //});
            return vess;
        }

        #endregion

    }
}
