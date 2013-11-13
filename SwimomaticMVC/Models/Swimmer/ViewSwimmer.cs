using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.ComponentModel;

namespace SwimomaticMVC.Models
{
    public class ViewSwimmer
    {
        [DisplayName("Last Name")]
        public string LastName { get; set; }
       
        [DisplayName("First Name")]
        public string FirstName { get; set; }

        public string LastFirstName { get; set; }
        public int Age { get; set; }
        public int SwimmerID { get; set; }
        public int UserSwimmerID { get; set; }
        public int SwimmerTeamRequestID { get; set; }
        public int TeamSeasonID { get; set; }

        [DisplayName("Birth Date")]
        public DateTime BirthDate { get; set; }

        [DisplayName("Gender")]
        public bool IsMale { get; set; }
    }
}