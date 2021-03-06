namespace Swimomatic.Entity
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The Season class is the concrete class representing a single Season object.
    // This class is where any customizations can be made.
    // </summary>
    // <history>
    // 		[Generated on 09/18/2009] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class Season : _Season
    {
        
        #region  Constructor 
        public Season()
        {
        }
        #endregion

        public string LeagueName { get; set; }
        public string LeagueDescription { get; set; }
        public int TeamSeasonID { get; set; }
        public string AgeClassRuleDescription { get; set; }
        public bool IsAdmin { get; set; }
    }
}
