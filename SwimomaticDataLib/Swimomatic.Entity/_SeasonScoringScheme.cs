namespace Swimomatic.Entity
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _SeasonScoringScheme class is the base class representing a single SeasonScoringScheme object.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 04/19/2011] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class _SeasonScoringScheme : LAAF.Core.LAEntity
    {
        
        #region  Private Members 
        private int _ScoringSchemeID;
        
        private int _SeasonID;
        
        private int _SeasonScoringSchemeID;
        
        private int _SwimMeetTypeID;
        #endregion
        
        #region  Constructor 
        public _SeasonScoringScheme()
        {
        }
        #endregion
        
        #region  Public Properties 
        public virtual int ScoringSchemeID
        {
            get
            {
                return _ScoringSchemeID;
            }
            set
            {
                _ScoringSchemeID = value;
            }
        }
        
        public virtual int SeasonID
        {
            get
            {
                return _SeasonID;
            }
            set
            {
                _SeasonID = value;
            }
        }
        
        public virtual int SeasonScoringSchemeID
        {
            get
            {
                return _SeasonScoringSchemeID;
            }
            set
            {
                _SeasonScoringSchemeID = value;
            }
        }
        
        public virtual int SwimMeetTypeID
        {
            get
            {
                return _SwimMeetTypeID;
            }
            set
            {
                _SwimMeetTypeID = value;
            }
        }
        #endregion
        
        public enum PropertyNames
        {
            
            ScoringSchemeID,
            
            SeasonID,
            
            SeasonScoringSchemeID,
            
            SwimMeetTypeID,
        }
    }
}
