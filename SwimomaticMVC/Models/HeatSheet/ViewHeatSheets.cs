using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewHeatSheets
    {
        public int SwimMeetID { get; set; }
        public List<ViewPoolConfig> ViewPoolConfigs { get; set; }
        public bool IsAdmin  { get; set; }
    }
}