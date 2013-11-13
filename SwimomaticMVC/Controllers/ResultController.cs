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
    public class ResultController : ControllerBase
    {
        #region Action Methods
        public ActionResult Index(int HeatSheetEventID)
        {
            return View(HeatSheetEventID);
        }

        public ActionResult HeatSheetEventResults(int HeatSheetEventID)
        {
            ViewHeatSheetEventResult vhser = new ViewHeatSheetEventResult();
            vhser.ViewHeatSheetEvent = GetHeatSheetEvent(HeatSheetEventID);
            vhser.ViewHeats = GetHeats(HeatSheetEventID);

            return PartialView("_HeatSheetEventResults", vhser);
        }

        [HttpPost]
        public ActionResult SaveHeatSheetEventResults(List<ViewHeatSheetEventResult> viewHeatSheetEventResults)
        {
            SaveResults(viewHeatSheetEventResults);

            SwimMeet swimMeet = BizMgr.GetSwimMeetByHeatSheetEventID(viewHeatSheetEventResults[0].HeatSheetEventID);
            ViewHeatSheetEventResult vhser = new ViewHeatSheetEventResult();
            vhser.ViewHeats = GetHeats(viewHeatSheetEventResults[0].HeatSheetEventID);
            vhser.SwimMeetID = swimMeet.SwimMeetID;
            return PartialView("_HeatSheetEventResultView", vhser);
        }
        public ActionResult SwimMeetResults(int SwimMeetID)
        {
            ViewSwimMeetResult vsmr = new ViewSwimMeetResult();
            vsmr.SwimMeetTotals = GetSwimMeetTotals(SwimMeetID);
            vsmr.SwimMeetResults = GetSwimMeetResults(SwimMeetID);
            vsmr.SwimMeetID = SwimMeetID;
            return View(vsmr);
        }

        public ActionResult SwimMeetResultsByUser(int SwimMeetID)
        {
            ViewSwimMeetResult vsmr = new ViewSwimMeetResult();
            vsmr.SwimMeetTotals = GetSwimMeetTotals(SwimMeetID);
            vsmr.SwimMeetResults = GetSwimMeetResultsByUser(SwimMeetID, this.CurrentUser.SystemUserID);
            vsmr.SwimMeetID = SwimMeetID;
            return View("SwimMeetResults", vsmr);
        }

        #endregion

        #region Private Methods
        private ViewHeatSheetEvent GetHeatSheetEvent(int HeatSheetEventID)
        {
            ViewHeatSheetEvent vhse = new ViewHeatSheetEvent();
            HeatSheetEvent hse = BizMgr.GetHeatSheetEvent(HeatSheetEventID);
            vhse.HeatSheetEventID = hse.HeatSheetEventID;
            vhse.HeatSheetID = hse.HeatSheetID;
            vhse.Sequence = hse.Sequence;
            vhse.Description = hse.Description;
            return vhse;
        }

        private void SaveResults(List<ViewHeatSheetEventResult> viewHeatSheetEventResults)
        {
            List<Result> results = new List<Result>();
            Result result = null;
            foreach (ViewHeatSheetEventResult vhser in viewHeatSheetEventResults)
            {
                result = new Result();
                result.ElapsedTime = vhser.ElapsedTimeString != null ? GetSecondsFromTimeString(vhser.ElapsedTimeString) : 0;
                result.Split = vhser.SplitString != null ? GetSecondsFromTimeString(vhser.SplitString) : 0;
                result.Disqualified = vhser.Disqualified;
                result.HeatSwimmerID = vhser.HeatSwimmerID;
                results.Add(result);
            }
            BizMgr.SaveResults(viewHeatSheetEventResults[0].HeatSheetEventID, results, this.CurrentUser.SystemUserID);
        }

        /// <summary>
        /// returns the number of seconds, with 2 decimal places from the time string formatted as "s.ff", "ss.ff", "m:ss.ff" or "mm:ss.ff" 
        /// </summary>
        /// <param name="timeString"></param>
        /// <returns></returns>
        private double GetSecondsFromTimeString(string timeString)
        {
            if (timeString.Length > 0)
            {
                DateTime elapsedTime = new DateTime();
                string[] timeFormat = new string[] { "s.ff", "ss.ff", "m:ss.ff", "mm:ss.ff" };
                System.Globalization.CultureInfo provider = System.Globalization.CultureInfo.InvariantCulture;
                elapsedTime = DateTime.ParseExact(timeString, timeFormat, provider, System.Globalization.DateTimeStyles.None);
                return ((double)elapsedTime.Minute * 60 + (double)elapsedTime.Second + (double)elapsedTime.Millisecond / 1000);
            }
            else
            {
                return 0;
            }
        }
        private List<ViewHeatSheetEventResult> GetSwimMeetResults(int SwimMeetID)
        {
            List<ViewHeatSheetEventResult> scoreList = new List<ViewHeatSheetEventResult>();
            ViewHeatSheetEventResult viewScore = null;
            ScoreCollection scores = BizMgr.GetScoresBySwimMeetID(SwimMeetID);
            foreach (Score score in scores)
            {
                viewScore = new ViewHeatSheetEventResult();
                viewScore.Abbrev = score.Abbrev;
                viewScore.Description = score.Description;
                viewScore.Disqualified = score.Disqualified;
                viewScore.ElapsedTime = score.ElapsedTime;
                viewScore.ElapsedTimeString = SwimomaticBusinessLib.Utility.GetTimeFromSeconds(score.ElapsedTime);
                viewScore.HeatSwimmerID = score.HeatSwimmerID;
                viewScore.HeatSheetEventID = score.HeatSheetEventID;
                viewScore.IsCertified = score.IsCertified;
                viewScore.IsProtested = score.IsProtested;
                viewScore.IsRelay = score.IsRelay;
                viewScore.Leg = score.Leg;
                viewScore.Place = score.Place;
                viewScore.Points = score.Points;
                viewScore.Sequence = score.Sequence;
                viewScore.Swimmer = score.Swimmer;
                scoreList.Add(viewScore);
            }
            return scoreList;
        }

        private List<ViewHeatSheetEventResult> GetSwimMeetResultsByUser(int SwimMeetID, int SystemUserID)
        {
            List<ViewHeatSheetEventResult> scoreList = new List<ViewHeatSheetEventResult>();
            ViewHeatSheetEventResult viewScore = null;
            ScoreCollection scores = BizMgr.GetScoresBySwimMeetIDSystemUserID(SwimMeetID, SystemUserID);
            foreach (Score score in scores)
            {
                viewScore = new ViewHeatSheetEventResult();
                viewScore.Abbrev = score.Abbrev;
                viewScore.Description = score.Description;
                viewScore.Disqualified = score.Disqualified;
                viewScore.ElapsedTime = score.ElapsedTime;
                viewScore.ElapsedTimeString = SwimomaticBusinessLib.Utility.GetTimeFromSeconds(score.ElapsedTime);
                viewScore.HeatSwimmerID = score.HeatSwimmerID;
                viewScore.HeatSheetEventID = score.HeatSheetEventID;
                viewScore.IsCertified = score.IsCertified;
                viewScore.IsProtested = score.IsProtested;
                viewScore.IsRelay = score.IsRelay;
                viewScore.Leg = score.Leg;
                viewScore.Place = score.Place;
                viewScore.Points = score.Points;
                viewScore.Sequence = score.Sequence;
                viewScore.Swimmer = score.Swimmer;
                scoreList.Add(viewScore);
            }
            return scoreList;
        }

        private List<ViewHeatSheetEventResult> GetSwimMeetResultsAsSwimmer(int SwimMeetID)
        {
            List<ViewHeatSheetEventResult> scoreList = new List<ViewHeatSheetEventResult>();
            ViewHeatSheetEventResult viewScore = null;
            ScoreCollection scores = BizMgr.GetScoresBySystemUserIDAsSwimmer(SwimMeetID);
            foreach (Score score in scores)
            {
                viewScore = new ViewHeatSheetEventResult();
                viewScore.Abbrev = score.Abbrev;
                viewScore.Description = score.Description;
                viewScore.Disqualified = score.Disqualified;
                viewScore.ElapsedTime = score.ElapsedTime;
                viewScore.HeatSwimmerID = score.HeatSwimmerID;
                viewScore.HeatSheetEventID = score.HeatSheetEventID;
                viewScore.IsCertified = score.IsCertified;
                viewScore.IsProtested = score.IsProtested;
                viewScore.IsRelay = score.IsRelay;
                viewScore.Leg = score.Leg;
                viewScore.Place = score.Place;
                viewScore.Points = score.Points;
                viewScore.Sequence = score.Sequence;
                viewScore.Swimmer = score.Swimmer;
                scoreList.Add(viewScore);
            }
            return scoreList;
        }

        private List<ViewHeatSheetEventResult> GetSwimMeetTotals(int SwimMeetID)
        {
            List<ViewHeatSheetEventResult> scoreList = new List<ViewHeatSheetEventResult>();
            ViewHeatSheetEventResult viewScore = null;
            ScoreCollection scores = BizMgr.GetTotalScoresBySwimMeetID(SwimMeetID);
            foreach (Score score in scores)
            {
                viewScore = new ViewHeatSheetEventResult();
                viewScore.Abbrev = score.Abbrev;
                viewScore.Points = score.Points;
                scoreList.Add(viewScore);
            }
            return scoreList;
        }

        #endregion

    }
}
