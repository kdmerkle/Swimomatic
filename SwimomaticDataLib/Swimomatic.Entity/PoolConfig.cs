using System;

using System.Collections.Generic;

namespace Swimomatic.Entity
{


    // Logical Architect Application Framework
    // Logical Architect (LogArch, Inc)
    // www.logicalarchitect.com
    //  
    // <summary>
    // The PoolConfig class is the concrete class representing a single PoolConfig object.
    // This class is where any customizations can be made.
    // </summary>
    // <history>
    // 		[Generated on 09/18/2009] - Generated by LAAF CodeGen
    // </history>
    [System.Serializable()]
    public class PoolConfig : _PoolConfig
    {

        #region  Constructor
        public PoolConfig()
        {
        }
        #endregion

        public string Address { get; set; }
        public string City { get; set; }
        public decimal Latitude { get; set; }
        public int LocationID { get; set; }
        public int RegionID { get; set; }
        public string LocationName { get; set; }
        public decimal Longitude { get; set; }
        public string PoolDescription { get; set; }
        public string RegionAbbrev { get; set; }
        public string PostalCode { get; set; }
        public string UOMAbbrev { get; set; }
        public string FullAddress { get { return Address + " " + City + ", " + RegionAbbrev +  " " + PostalCode; } }
        public string CityStateZip { get { return City + ", " + RegionAbbrev +  " " + PostalCode; } }

        public string LengthDescription
        {
            get
            {
                System.Text.StringBuilder sb = new System.Text.StringBuilder();

                sb.Append(GetLengthFloor().ToString());
                switch (this.UOMID)
                {
                    case 1:
                        sb.Append(" M - ");
                        sb.Append(GetLengthRemainder().ToString());
                        sb.Append(" cm");
                        break;
                    case 2:
                        sb.Append(" Yd - ");
                        sb.Append(GetLengthRemainder().ToString());
                        sb.Append(" in");
                        break;
                    default:
                        break;
                }
                return sb.ToString();
            }
        }

        public double GetLengthFloor()
        {
            return Math.Floor(base.LaneLength);
        }

        public double GetLengthRemainder()
        {
            switch (this.UOMID)
            {
                case 1:
                    return Math.Round((base.LaneLength - GetLengthFloor()) * 100.0D);
                case 2:
                    return Math.Round((base.LaneLength - GetLengthFloor()) * 36.0D);
                default:
                    return 0;
            }
        }

        public Dictionary<int, int> LaneSequence { get; set; }
    }
}
