using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewAddSwimmers
    {
        public bool IsRelay { get; set; }
        public int PoolPoolConfigID { get; set; }
        public int SwimMeetEventID { get; set; }
        public List<ViewHeatSwimmer> ViewHeatSwimmers { get; set; } 
    }
}