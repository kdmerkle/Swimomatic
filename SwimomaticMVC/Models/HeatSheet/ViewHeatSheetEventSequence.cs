using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewHeatSheetEventSequence
    {
        public int HeatSheetID { get; set; }
        public List<int> HeatSheetEventIDs
        {
            get;
            set;
        }
    }
}