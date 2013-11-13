namespace Swimomatic.Entity
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _Region class is the base class representing a single Region object.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 09/29/2010] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class _Region : LAAF.Core.LAEntity
    {
        
        #region  Private Members 
        private string _RegionAbbrev;
        
        private int _RegionID;
        
        private string _RegionName;
        #endregion
        
        #region  Constructor 
        public _Region()
        {
        }
        #endregion
        
        #region  Public Properties 
        public virtual string RegionAbbrev
        {
            get
            {
                return _RegionAbbrev;
            }
            set
            {
                _RegionAbbrev = value;
            }
        }
        
        public virtual int RegionID
        {
            get
            {
                return _RegionID;
            }
            set
            {
                _RegionID = value;
            }
        }
        
        public virtual string RegionName
        {
            get
            {
                return _RegionName;
            }
            set
            {
                _RegionName = value;
            }
        }
        #endregion
        
        public enum PropertyNames
        {
            
            RegionAbbrev,
            
            RegionID,
            
            RegionName,
        }
    }
}
