using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SwimomaticMVC.Models
{
    public class ViewLocationSearch
    {
        public SelectList Regions { get; set; }
        public SelectList Cities { get; set; }

    }
}