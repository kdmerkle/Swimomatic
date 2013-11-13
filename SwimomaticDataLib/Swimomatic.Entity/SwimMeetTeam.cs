using System.Collections.Generic;

namespace Swimomatic.Entity
{


    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The SwimMeetTeam class is the concrete class representing a single SwimMeetTeam object.
    // This class is where any customizations can be made.
    // </summary>
    // <history>
    // 		[Generated on 09/18/2009] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class SwimMeetTeam : _SwimMeetTeam
    {
        #region  Constructor
        public SwimMeetTeam()
        {
        }
        #endregion

        public string TeamName { get; set; }
        public string Abbrev { get; set; }
    }
}
