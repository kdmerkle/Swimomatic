using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

using SwimomaticMVC.Models;
using Swimomatic.Entity;
using SwimomaticBusinessLib;
using LAAF.Logger;

namespace SwimomaticMVC.Controllers
{
    public class PoolController : ControllerBase
    {

        #region Action Methods
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult UserCreatedPools(int UserTeamID)
        {
            return PartialView("_UserCreatedPools", GetPoolConfigs(UserTeamID));
        }

        public ActionResult PoolConfigs(int LocationID)
        {
            return PartialView("_HomePool", GetPoolConfigsByLocationID(LocationID));
        }

        public ActionResult PoolSearch()
        {
            ViewPoolSearch vps = new ViewPoolSearch();
            vps.Cities = (SelectList)GetCities(0);
            vps.Regions = (SelectList)GetRegions(0);
            vps.City = this.CurrentUser.City;
            vps.RegionAbbrev = this.CurrentUser.RegionAbbrev;
            return PartialView("_PoolSearch", vps);
        }
        #endregion

        #region Private Methods
        private List<ViewPoolConfig> GetPoolConfigs(int UserTeamID)
        {
            List<ViewPoolConfig> vpcs = new List<ViewPoolConfig>();
            ViewPoolConfig vpc = null;
            Team team = BizMgr.GetTeamByUserTeamID(UserTeamID);
            PoolConfigCollection poolConfigs = BizMgr.GetPoolConfigsByUserTeamID(UserTeamID);
            foreach (PoolConfig pc in poolConfigs)
            {
                vpc = new ViewPoolConfig();
                vpc.LocationName = pc.LocationName;
                vpc.LocationID = pc.LocationID;
                vpc.FullAddress = pc.FullAddress;
                vpc.IsHomePoolConfig = (pc.PoolConfigID == team.HomePoolConfigID);
                vpc.PoolConfigID = pc.PoolConfigID;
                vpcs.Add(vpc);
            }
            return vpcs;
        }

        private List<ViewPoolConfig> GetPoolConfigsByLocationID(int LocationID)
        {
            List<ViewPoolConfig> vpcs = new List<ViewPoolConfig>();
            ViewPoolConfig vpc = null;
            PoolConfigCollection poolConfigs = BizMgr.GetPoolConfigsByLocationID(LocationID);
            foreach (PoolConfig pc in poolConfigs)
            {
                vpc = new ViewPoolConfig();
                vpc.LocationName = pc.LocationName;
                vpc.LocationID = pc.LocationID;
                vpc.FullAddress = pc.FullAddress;
                vpc.IsHomePoolConfig = false; //this will always be false because this method is only called when creating a new team, thus, it has no HomePoolConfig yet
                vpc.PoolConfigID = pc.PoolConfigID;
                vpcs.Add(vpc);
            }
            return vpcs;
        }
        #endregion

    }
}
