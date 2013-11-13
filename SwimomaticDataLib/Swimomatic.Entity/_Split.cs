namespace Swimomatic.Entity
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _Split class is the base class representing a single Split object.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 01/29/2011] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class _Split : LAAF.Core.LAEntity
    {
        
        #region  Private Members 
        private int _ResultID;
        
        private int _SplitID;
        
        private decimal _SplitTime;
        #endregion
        
        #region  Constructor 
        public _Split()
        {
        }
        #endregion
        
        #region  Public Properties 
        public virtual int ResultID
        {
            get
            {
                return _ResultID;
            }
            set
            {
                _ResultID = value;
            }
        }
        
        public virtual int SplitID
        {
            get
            {
                return _SplitID;
            }
            set
            {
                _SplitID = value;
            }
        }
        
        public virtual decimal SplitTime
        {
            get
            {
                return _SplitTime;
            }
            set
            {
                _SplitTime = value;
            }
        }
        #endregion
        
        public enum PropertyNames
        {
            
            ResultID,
            
            SplitID,
            
            SplitTime,
        }
    }
}