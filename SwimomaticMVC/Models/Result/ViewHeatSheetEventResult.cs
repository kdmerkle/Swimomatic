using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewHeatSheetEventResult
    {
        public int HeatSwimmerID { get; set; }
        public int SwimMeetID { get; set; }
        public int HeatSheetID { get; set; }
        public int HeatSheetEventID { get; set; }
        public double ElapsedTime { get; set; }
        public string ElapsedTimeString { get; set; }
        public double Split { get; set; }
        public string SplitString { get; set; }
        public bool Disqualified { get; set; }
        public string Swimmer { get; set; }
        public string Abbrev { get; set; }
        public string Description { get; set; }
        public int SwimmerID { get; set; }
        public bool IsRelay { get; set; }
        public bool IsCertified { get; set; }
        public bool IsProtested { get; set; }
        public int Place { get; set; }
        public double Points { get; set; }
        public int Sequence { get; set; }
        public int Leg { get; set; }
        public ViewHeats ViewHeats { get; set; }
        public ViewHeatSheetEvent  ViewHeatSheetEvent { get; set; }
    }
}