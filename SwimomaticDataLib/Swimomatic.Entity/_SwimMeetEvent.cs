namespace Swimomatic.Entity
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _SwimMeetEvent class is the base class representing a single SwimMeetEvent object.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Generated on 10/01/2010] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class _SwimMeetEvent : LAAF.Core.LAEntity
    {
        
        #region  Private Members 
        private int _Sequence;
        
        private int _SwimEventID;
        
        private int _SwimMeetEventID;
        
        private int _SwimMeetID;
        
        private int _Distance;
        #endregion
        
        #region  Constructor 
        public _SwimMeetEvent()
        {
        }
        #endregion
        
        #region  Public Properties 
        public virtual int Sequence
        {
            get
            {
                return _Sequence;
            }
            set
            {
                _Sequence = value;
            }
        }
        
        public virtual int SwimEventID
        {
            get
            {
                return _SwimEventID;
            }
            set
            {
                _SwimEventID = value;
            }
        }
        
        public virtual int SwimMeetEventID
        {
            get
            {
                return _SwimMeetEventID;
            }
            set
            {
                _SwimMeetEventID = value;
            }
        }
        
        public virtual int SwimMeetID
        {
            get
            {
                return _SwimMeetID;
            }
            set
            {
                _SwimMeetID = value;
            }
        }
        
        public virtual int Distance
        {
            get
            {
                return _Distance;
            }
            set
            {
                _Distance = value;
            }
        }
        #endregion
        
        public enum PropertyNames
        {
            
            Sequence,
            
            SwimEventID,
            
            SwimMeetEventID,
            
            SwimMeetID,
            
            Distance,
        }
    }
}
