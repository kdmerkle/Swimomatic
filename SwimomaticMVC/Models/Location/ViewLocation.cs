using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel.DataAnnotations;

namespace SwimomaticMVC.Models
{
    public class ViewLocation
    {
        public int LocationID { get; set; }

        [Display(Name = "State")]
        public int RegionID { get; set; }
        public int PoolCount { get; set; }
        public SelectList Regions { get; set; }

        [Display(Name = "Location Name")]
        public string Name { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string RegionAbbrev { get; set; }

        [Display(Name = "Zip Code")]
        public string PostalCode { get; set; }

        public decimal Latitude { get; set; }
        public decimal Longitude { get; set; }

    }
}