using System.Collections.Generic;

namespace Swimomatic.Entity
{


    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The HeatSheetTeam class is the concrete class representing a single HeatSheetTeam object.
    // This class is where any customizations can be made.
    // </summary>
    // <history>
    // 		[Generated on 10/06/2010] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class HeatSheetTeam : _HeatSheetTeam
    {

        #region  Constructor
        public HeatSheetTeam()
        {
        }
        #endregion

        private List<int> _LaneList;
        public List<int> LaneList
        {
            get
            {
                if (_LaneList == null)
                {
                    _LaneList = new List<int>();
                }

                if (_LaneList.Count == 0)
                {
                    string[] arrLanes = this.Lanes.Split('|');
                    for (int i = 0; i < arrLanes.Length; i++)
                    {
                        _LaneList.Add(int.Parse(arrLanes[i]));
                    }
                }
                return _LaneList;
            }
            set
            {
                string retVal = string.Empty;
                foreach (int item in value)
                {
                    retVal += item.ToString() + "|";
                }

                this.Lanes = retVal;
            }
        }

    }
}
