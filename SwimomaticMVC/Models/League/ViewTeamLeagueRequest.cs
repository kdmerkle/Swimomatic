using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewTeamLeagueRequest
    {
        public List<ViewLeague> ViewLeagues { get; set; }
        public int UserTeamID { get; set; }
    }
}