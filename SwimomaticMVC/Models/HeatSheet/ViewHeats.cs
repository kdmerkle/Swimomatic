using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewHeats
    {
        public ViewHeats()
        {
            _ViewHeatList = new List<ViewHeat>();
        }
        private List<ViewHeat> _ViewHeatList;
        public List<ViewHeat> ViewHeatList { get { return _ViewHeatList; } set { _ViewHeatList = value; } }
        public bool IsAdmin { get; set; }
    }
}