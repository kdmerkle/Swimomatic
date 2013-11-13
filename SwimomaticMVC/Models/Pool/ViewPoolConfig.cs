using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

using System.ComponentModel.DataAnnotations;
using System.Web.Mvc;

namespace SwimomaticMVC.Models
{
    public class ViewPoolConfig
    {
        public int HeatSheetID { get; set; }
        public int PoolConfigID { get; set; }
        public int PoolID { get; set; }

        public string PoolDescription { get; set; }

        [Display(Name="Setup")]
        public string Description { get; set; }

        [Display(Name="Length")]
        public double LaneLength { get; set; }
        public string LengthDescription { get; set; }
        public int LengthMajor { get; set; }
        public int LengthMinor { get; set; }

        public int UOMID { get; set; }
        public string UOMAbbrev { get; set; }
        public int LocationID { get; set; }
        public int RegionID { get; set; }
        public string RegionAbbrev { get; set; }
        public string City { get; set; }
        public string LocationName { get; set; }
        public string FullAddress { get; set; }
        public int LaneCount { get; set; }
        public bool IsHomePoolConfig { get; set; }

        public SelectList UOMs { get; set; }

    }
}