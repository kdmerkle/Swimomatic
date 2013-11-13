using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewTeams
    {
        public int LaneCount { get; set; }
        private List<ViewTeam> _ViewTeamList;
        public List<ViewTeam> ViewTeamList
        {
            get
            {
                if (_ViewTeamList == null)
                {
                    _ViewTeamList = new List<ViewTeam>();
                }
                return _ViewTeamList;
            }
            set { _ViewTeamList = value; }
        }

        //Dictionary<LaneNumber, TeamID>
        public Dictionary<int, int> LaneNumbers { get; set; }
        public int SwimMeetID { get; set; }
        public int UserSwimmerID { get; set; }
    }
}