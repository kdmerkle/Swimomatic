using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewHeatSwimmer : ViewEligibleSwimmer
    {
        public int Sequence { get; set; }
        public int HeatSwimmerID { get; set; }
        public int HeatSheetEventID { get; set; }
        public int LaneNumber { get; set; }
        public int Leg { get; set; }
        public double ElapsedTime { get; set; }
        public double Split { get; set; }
        public bool Disqualified { get; set; }
        public int Place { get; set; }
        public double Points { get; set; }

        public string ElapsedTimeString { get; set; }
        public string SplitString { get; set; }
        public string Description { get; set; }
    }
}
      