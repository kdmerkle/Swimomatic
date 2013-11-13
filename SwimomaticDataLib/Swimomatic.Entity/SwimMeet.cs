namespace Swimomatic.Entity
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The SwimMeet class is the concrete class representing a single SwimMeet object.
    // This class is where any customizations can be made.
    // </summary>
    // <history>
    // 		[Generated on 09/18/2009] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class SwimMeet : _SwimMeet
    {
        
        #region  Constructor 
        public SwimMeet()
        {
        }
        #endregion

        public string SeasonDescription { get; set; }
        public string LeagueDescription { get; set; }
        public string LeagueName { get; set; }
        public string LocationName { get; set; }
        public bool HasResults { get; set; }
        public bool IsAdmin { get; set; }
    }
}
