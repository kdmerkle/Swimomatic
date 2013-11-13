using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Models
{
    public class ViewSwimMeets
    {
        private List<ViewSwimMeet> _ViewSwimMeetList;
        public List<ViewSwimMeet> ViewSwimMeetList
        {
            get
            {
                if (_ViewSwimMeetList == null)
                {
                    _ViewSwimMeetList = new List<ViewSwimMeet>();
                }
                return _ViewSwimMeetList;
            }
            set
            {
                _ViewSwimMeetList = value;
            }
        }
    }
}