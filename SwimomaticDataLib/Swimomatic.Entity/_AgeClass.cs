namespace Swimomatic.Entity
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _AgeClass class is the base class representing a single AgeClass object.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 08/03/2009] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class _AgeClass : LAAF.Core.LAEntity
    {
        
        #region  Private Members 
        private int _AgeClassID;
        
        private string _Description;
        
        private bool _IsMale;
        
        private int _MinAge;
        
        private int _MaxAge;
        #endregion
        
        #region  Constructor 
        public _AgeClass()
        {
        }
        #endregion
        
        #region  Public Properties 
        public virtual int AgeClassID
        {
            get
            {
                return _AgeClassID;
            }
            set
            {
                _AgeClassID = value;
            }
        }
        
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
        
        public virtual bool IsMale
        {
            get
            {
                return _IsMale;
            }
            set
            {
                _IsMale = value;
            }
        }
        
        public virtual int MinAge
        {
            get
            {
                return _MinAge;
            }
            set
            {
                _MinAge = value;
            }
        }
        
        public virtual int MaxAge
        {
            get
            {
                return _MaxAge;
            }
            set
            {
                _MaxAge = value;
            }
        }
        #endregion
        
        public enum PropertyNames
        {
            
            AgeClassID,
            
            Description,
            
            IsMale,
            
            MinAge,
            
            MaxAge,
        }
    }
}
