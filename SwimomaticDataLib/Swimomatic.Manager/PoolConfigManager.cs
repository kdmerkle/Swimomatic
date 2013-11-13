namespace Swimomatic.Manager
{
    
    public class PoolConfigManager : _PoolConfigManager
    {
        
        #region  Constructor 
        public PoolConfigManager()
        {
        }
        
        public PoolConfigManager(Swimomatic.ServiceProvider.SwimomaticServiceProvider serviceProvider) : 
                base(serviceProvider)
        {
        }
        #endregion

        public override Entity.PoolConfig PoolConfigGetByHeatSheetEventID(int HeatSheetEventID)
        {
            Entity.PoolConfig poolConfig =  base.PoolConfigGetByHeatSheetEventID(HeatSheetEventID);

            LaneSequenceManager lsm = new LaneSequenceManager();
            Entity.LaneSequenceCollection lss = lsm.LaneSequenceGetAllByLaneCount(poolConfig.LaneCount);

            poolConfig.LaneSequence = new System.Collections.Generic.Dictionary<int, int>();
            foreach (Entity.LaneSequence ls in lss)
            {
                poolConfig.LaneSequence.Add(ls.LaneNumber, ls.LaneOrder);
            }
            return poolConfig;
        }
    }
}
