using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewEligibleSwimmers
    {
        public bool IsRelay { get; set; }
        public int PoolConfigID { get; set; }
        public int HeatSheetEventID { get; set; }

        private List<ViewEligibleSwimmer> _ViewEligibleSwimmers;
        public List<ViewEligibleSwimmer> ViewEligibleSwimmerList
        {
            get
            {
                if (_ViewEligibleSwimmers == null)
                {
                    _ViewEligibleSwimmers = new List<ViewEligibleSwimmer>();
                }
                return _ViewEligibleSwimmers;
            }
            set { _ViewEligibleSwimmers = value; }
        }
    }
}