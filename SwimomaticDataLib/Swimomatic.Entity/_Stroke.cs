namespace Swimomatic.Entity
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _Stroke class is the base class representing a single Stroke object.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 08/03/2009] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class _Stroke : LAAF.Core.LAEntity
    {
        
        #region  Private Members 
        private string _Description;
        
        private int _StrokeID;
        
        private bool _IsRelay;
        #endregion
        
        #region  Constructor 
        public _Stroke()
        {
        }
        #endregion
        
        #region  Public Properties 
        public virtual string Description
        {
            get
            {
                return _Description;
            }
            set
            {
                _Description = value;
            }
        }
        
        public virtual int StrokeID
        {
            get
            {
                return _StrokeID;
            }
            set
            {
                _StrokeID = value;
            }
        }
        
        public virtual bool IsRelay
        {
            get
            {
                return _IsRelay;
            }
            set
            {
                _IsRelay = value;
            }
        }
        #endregion
        
        public enum PropertyNames
        {
            
            Description,
            
            StrokeID,
            
            IsRelay,
        }
    }
}
