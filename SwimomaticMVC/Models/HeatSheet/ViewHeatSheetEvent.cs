using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SwimomaticMVC.Models
{
    public class ViewHeatSheetEvent
    {
        private List<ViewSwimEvent> _SwimEvents;
        public List<ViewSwimEvent> SwimEvents
        {
            get
            {
                if (_SwimEvents == null)
                {
                    _SwimEvents = new List<ViewSwimEvent>();
                }
                return _SwimEvents;
            }
            set
            {
                _SwimEvents = value;
            }
        }

        private ViewHeats _Heats;
        public ViewHeats Heats
        {
            get
            {
                if (_Heats == null)
                {
                    _Heats = new ViewHeats();
                }
                return _Heats;
            }
            set
            {
                _Heats = value;
            }
        }
        public SelectList AgeClassList { get; set; }
        public SelectList StrokeList { get; set; }
        public SelectList DistanceList { get; set; }
        public string EventName { get; set; }
        public string Description { get; set; }
        public int Sequence { get; set; }
        public int Distance { get; set; }
        public int HeatSheetEventID { get; set; }
        public int AgeClassID { get; set; }
        public int StrokeID { get; set; }
        public int HeatSheetID { get; set; }

        internal bool ValidateHeatSheetEvent(ModelStateDictionary modelState)
        {
            if (this.AgeClassID <= 0)
            {
                modelState.AddModelError("AgeClassID", "Please Select an Age Class");
            }
            if (this.StrokeID <= 0)
            {
                modelState.AddModelError("AgeClassID", "Please Select a Stroke");
            }
            if (this.Distance == 0)
            {
                modelState.AddModelError("Distance", "Please Select a Distance");
            }
            return modelState.IsValid;
        }
    }
}
