using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewSeasons
    {
        public ViewSeasons()
        {
            _ViewSeasonList = new List<ViewSeason>();
        }

        public int LeagueID { get; set; }
        public bool IsAdmin { get; set; }
        private List<ViewSeason> _ViewSeasonList;
        public List<ViewSeason> ViewSeasonList
        {
            get
            {
                return _ViewSeasonList;
            }
            set
            {
                _ViewSeasonList = value;
            }
        }
    }
}