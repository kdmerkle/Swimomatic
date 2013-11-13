using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewSwimMeet
    {
        public int SwimMeetID { get; set; }
        public int SwimMeetTypeID { get; set; }
        public bool CanEdit { get; set; }
        public bool IsAdmin { get; set; }
        public bool HasResults{ get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string Description { get; set; }
        public int LocationID { get; set; }
        public string LocationName { get; set; }
        public int LeagueID { get; set; }
        public string LeagueDescription { get; set; }
        public string LeagueName { get; set; }
        public int SeasonID { get; set; }
        public string SeasonDescription { get; set; }
        public string Teams { get; set; }
        public List<int> TeamSeasonIDs { get; set; }

        /// <summary>
        /// Returns a flag indicating whether the user has any teams that are members of a league for a current or future season
        /// Used to determine if the user may create a swim meet
        /// </summary>
        public bool HasTeamSeasons { get; set; }
    }
}
