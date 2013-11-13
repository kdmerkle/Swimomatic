namespace Swimomatic.Entity
{
    
    
    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The _TeamLeagueRequest class is the base class representing a single TeamLeagueRequest object.
    // This class should not be modified manually.
    // </summary>
    // <history>
    // 		[Updated on 12/08/2010] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class _TeamLeagueRequest : LAAF.Core.LAEntity
    {
        
        #region  Private Members 
        private System.DateTime _ApprovalDate;
        
        private int _ApprovalUserID;
        
        private bool _IsApproved;
        
        private System.DateTime _RequestDate;
        
        private int _SeasonID;
        
        private int _TeamLeagueRequestID;
        
        private int _UserTeamID;
        #endregion
        
        #region  Constructor 
        public _TeamLeagueRequest()
        {
        }
        #endregion
        
        #region  Public Properties 
        public virtual System.DateTime ApprovalDate
        {
            get
            {
                return _ApprovalDate;
            }
            set
            {
                _ApprovalDate = value;
            }
        }
        
        public virtual int ApprovalUserID
        {
            get
            {
                return _ApprovalUserID;
            }
            set
            {
                _ApprovalUserID = value;
            }
        }
        
        public virtual bool IsApproved
        {
            get
            {
                return _IsApproved;
            }
            set
            {
                _IsApproved = value;
            }
        }
        
        public virtual System.DateTime RequestDate
        {
            get
            {
                return _RequestDate;
            }
            set
            {
                _RequestDate = value;
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
        
        public virtual int TeamLeagueRequestID
        {
            get
            {
                return _TeamLeagueRequestID;
            }
            set
            {
                _TeamLeagueRequestID = value;
            }
        }
        
        public virtual int UserTeamID
        {
            get
            {
                return _UserTeamID;
            }
            set
            {
                _UserTeamID = value;
            }
        }
        #endregion
        
        public enum PropertyNames
        {
            
            ApprovalDate,
            
            ApprovalUserID,
            
            IsApproved,
            
            RequestDate,
            
            SeasonID,
            
            TeamLeagueRequestID,
            
            UserTeamID,
        }
    }
}
