namespace Swimomatic.Entity
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _RoleSystemUser class is the base class representing a single RoleSystemUser object.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 08/26/2010] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class _RoleSystemUser : LAAF.Core.LAEntity
    {
        
        #region  Private Members 
        private int _RoleID;
        
        private int _RoleSystemUserID;
        
        private int _SystemUserID;
        #endregion
        
        #region  Constructor 
        public _RoleSystemUser()
        {
        }
        #endregion
        
        #region  Public Properties 
        public virtual int RoleID
        {
            get
            {
                return _RoleID;
            }
            set
            {
                _RoleID = value;
            }
        }
        
        public virtual int RoleSystemUserID
        {
            get
            {
                return _RoleSystemUserID;
            }
            set
            {
                _RoleSystemUserID = value;
            }
        }
        
        public virtual int SystemUserID
        {
            get
            {
                return _SystemUserID;
            }
            set
            {
                _SystemUserID = value;
            }
        }
        #endregion
        
        public enum PropertyNames
        {
            
            RoleID,
            
            RoleSystemUserID,
            
            SystemUserID,
        }
    }
}