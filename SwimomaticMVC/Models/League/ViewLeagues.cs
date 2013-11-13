using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewLeagues
    {
        private List<ViewLeague> _ViewLeagueList;
        public List<ViewLeague> ViewLeagueList
        {
            get
            {
                if (_ViewLeagueList == null)
                {
                    _ViewLeagueList = new List<ViewLeague>();
                }
                return _ViewLeagueList;
            }
            set
            {
                _ViewLeagueList = value;
            }
        }
    }
}