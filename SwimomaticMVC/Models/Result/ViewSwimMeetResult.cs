using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewSwimMeetResult
    {
        public List<ViewHeatSheetEventResult> SwimMeetResults { get; set; }
        public List<ViewHeatSheetEventResult> SwimMeetTotals { get; set; }
        public int SwimMeetID { get; set; }
    }
}