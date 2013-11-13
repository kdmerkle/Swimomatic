using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewHeatSheetEvents
    {
        public ViewHeatSheetEvents()
        {
            _ViewHeatSheetEventList = new List<ViewHeatSheetEvent>();
        }
        public int HeatSheetID { get; set; }
        public int SwimMeetID { get; set; }
        public bool IsAdmin { get; set; }

        private List<ViewHeatSheetEvent> _ViewHeatSheetEventList;
        public List<ViewHeatSheetEvent> ViewHeatSheetEventList
        {
            get { return _ViewHeatSheetEventList; }
            set { _ViewHeatSheetEventList = value; }
        }
    }
}
