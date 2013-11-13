using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewEligibleSwimmer
    {
        public int SwimmerTeamSeasonID { get; set; }
        public int SwimmerID { get; set; }
        public string TeamNameAbbrev { get; set; }
        public string LastFirstName { get; set; }
        public string SeedTimeString { get; set; }
        public int AgeAtMeet { get; set; }
        public Double SeedTime { get; set; }
        public Double MostRecent { get; set; }
        public Double PersonalBest { get; set; }
        public Double SeasonBest { get; set; }

        //A swimmer is only selectable for an event by a TeamAdmin
        public bool IsSelectable { get; set; }

        //A swimmer may be limited to a number of events in a meet
        public bool HasExceededHeatSheetEventLimit { get; set; }

    }
}