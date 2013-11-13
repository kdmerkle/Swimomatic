using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SwimomaticMVC.Models
{
    public class ViewAddSwimmer
    {
        public bool IsRelay { get; set; }
        public int HeatID { get; set; }
        public int HeatSheetEventID { get; set; }
        public SelectList HeatSwimmerList { get; set; }
    }
}
