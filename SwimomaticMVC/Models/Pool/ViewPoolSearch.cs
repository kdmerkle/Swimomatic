using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;

namespace SwimomaticMVC.Models
{
    public class ViewPoolSearch
    {
        public ViewPoolSearch()
        {
            _Location = new ViewLocation();
        }

        public SelectList Cities { get; set; }
        public SelectList Regions { get; set; }

        private ViewLocation _Location;
        public ViewLocation Location
        {
            get { return _Location; }
            set { _Location = value; }
        }
        public string City { get; set; }
        public string RegionAbbrev { get; set; }
    }
}