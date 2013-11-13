using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewHeatSwimmers
    {
        private List<ViewHeatSwimmer> _HeatSwimmers;
        public List<ViewHeatSwimmer> HeatSwimmers
        {
            get
            {
                if (_HeatSwimmers == null)
                {
                    _HeatSwimmers = new List<ViewHeatSwimmer>();
                }
                return _HeatSwimmers;
            }
            set { _HeatSwimmers = value; }
        }

        private List<ViewHeat> _Heats;
        public List<ViewHeat> Heats
        {
            get
            {
                if (_Heats == null)
                {
                    _Heats = new List<ViewHeat>();
                }
                return _Heats;
            }
            set { _Heats = value; }
        }

        public bool IsAdmin { get; set; }
        public int HeatSheetID { get; set; }
    }
}