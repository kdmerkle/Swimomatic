using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel;

namespace SwimomaticMVC.Models
{
    public class ViewTeam
    {
        public ViewTeam()
        {
            _HomePoolConfig = new ViewPoolConfig();
            _SwimmerTeamSeasonList = new List<ViewSwimmer>();
            _SwimmerTeamRequestList = new List<ViewSwimmer>();
        }

        public int TeamID { get; set; }
        [DisplayName("Team Name")]
        public string TeamName { get; set; }
        public string Abbrev { get; set; }
        public string TeamNameAbbrev { get; set; }
        public int HomePoolConfigID { get; set; }
        public SelectList Cities { get; set; }
        public SelectList Regions { get; set; }
        public ViewLocation Location { get; set; }
        public bool IsAdmin { get; set; }

        //Location

        private ViewPoolConfig _HomePoolConfig;
        public ViewPoolConfig HomePoolConfig
        {
            get { return _HomePoolConfig; }
            set { _HomePoolConfig = value; }
        }

        //Location
        public string CityStateZip { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public int LocationID { get; set; }
        public string LocationName { get; set; }
        public string PostalCode { get; set; }

        [DisplayName("State")]
        public int RegionID { get; set; }

        //Season
        public int TeamSeasonID { get; set; }
        public int SeasonID { get; set; }
        public string SeasonDescription { get; set; }
        public DateTime StartDate { get; set; }
        public DateTime EndDate { get; set; }
        public string LeagueName { get; set; }

        public int UserSwimmerID { get; set; }
        public int TeamLeagueRequestID { get; set; }
        public int UserTeamID { get; set; }

        private List<ViewSwimmer> _SwimmerTeamSeasonList;
        public List<ViewSwimmer> SwimmerTeamSeasonList
        {
            get
            {
                return _SwimmerTeamSeasonList;
            }
            set { _SwimmerTeamSeasonList = value; }
        }

        private List<ViewSwimmer> _SwimmerTeamRequestList;
        public List<ViewSwimmer> SwimmerTeamRequestList
        {
            get
            {
                return _SwimmerTeamRequestList;
            }
            set { _SwimmerTeamRequestList = value; }
        }

    }
}