using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewSwimmers
    {
        private List<ViewSwimmer> _ViewSwimmerList;
        public List<ViewSwimmer> ViewSwimmerList
        {
            get
            {
                if (_ViewSwimmerList == null)
                {
                    _ViewSwimmerList = new List<ViewSwimmer>();
                }
                return _ViewSwimmerList;
            }
            set
            {
                _ViewSwimmerList = value;
            }
        }

        public bool IsAdmin { get; set; }
    }
}