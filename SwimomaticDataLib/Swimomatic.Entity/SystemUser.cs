namespace Swimomatic.Entity
{


    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The SystemUser class is the concrete class representing a single SystemUser object.
    // This class is where any customizations can be made.
    // </summary>
    // <history>
    // 		[Generated on 08/26/2010] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class SystemUser : _SystemUser
    {

        #region  Constructor
        public SystemUser()
        {
        }
        #endregion

        public string FirstLastName { get { return base.FirstName + " " + base.LastName; } }
        public string LastFirstName { get { return base.LastName + ", " + base.FirstName; } }
        public string RegionAbbrev { get; set; }
    }
}
