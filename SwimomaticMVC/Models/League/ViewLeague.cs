using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;


namespace SwimomaticMVC.Models
{
    public class ViewLeague
    {
        [Required(ErrorMessage = "League Name is Required")]
        public string LeagueName { get; set; }

        [Required(ErrorMessage = "League Description is Required")]
        public string LeagueDescription { get; set; }

        public int UserTeamID { get; set; }
        public int LeagueID { get; set; }
        public int SeasonID { get; set; }
        public int RegionID { get; set; }
        public string RegionAbbrev { get; set; }
        public string SeasonDescription { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public bool IsAdmin { get; set; }
        public SelectList Regions { get; set; }
    }
}