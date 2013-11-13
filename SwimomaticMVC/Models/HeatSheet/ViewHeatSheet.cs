using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewHeatSheet
    {
        public int PoolConfigID { get; set; }
        public int SwimMeetID { get; set; }
        private List<ViewHeatSheetTeam> _HeatSheetTeams;
        public List<ViewHeatSheetTeam> HeatSheetTeams
        {
            get
            {
                if (_HeatSheetTeams == null)
                {
                    _HeatSheetTeams = new List<ViewHeatSheetTeam>();
                }
                return _HeatSheetTeams;
            }
            set { _HeatSheetTeams = value; }
        }

    }
}