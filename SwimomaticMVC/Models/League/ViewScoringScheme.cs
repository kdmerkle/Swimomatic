using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewScoringScheme
    {
        public string Description { get; set; }

        public string IndividualPoints { get; set; }

        public bool IsUSASwimming { get; set; }

        //public int LaneCount { get; set; }

        public string RelayPoints { get; set; }

        public int ScoringEventTypeID { get; set; }

        public int ScoringSchemeID { get; set; }

        public int SwimMeetTypeID { get; set; }

    }
}