using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewHeat
    {
        private List<ViewHeatSwimmer> _ViewHeatSwimmers;
        public List<ViewHeatSwimmer> ViewHeatSwimmers
        {
            get
            {
                if (_ViewHeatSwimmers == null)
                {
                    _ViewHeatSwimmers = new List<ViewHeatSwimmer>();
                }
                return _ViewHeatSwimmers;
            }
            set
            {
                _ViewHeatSwimmers = value;
            }
        }

        public bool IsRelay { get; set; }
        public int HeatSheetEventID { get; set; }
        public int LaneCount { get; set; }
        public int HeatID { get; set; }
        public int HeatNumber { get; set; }
        public string Description { get; set; }
    }
}
