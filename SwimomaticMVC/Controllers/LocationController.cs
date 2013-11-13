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
    public class LocationController : ControllerBase
    {
        #region Action Methods

        public ActionResult Index()
        {
            //ViewBag.Controller = "Location";
            ViewBag.Regions = GetRegions(0);
            return View();
        }

        [ChildActionOnly]
        public ActionResult Locations()
        {
            return PartialView("_Locations", GetViewLocations(base.CurrentUser.SystemUserID));
        }

        [ChildActionOnly]
        public ActionResult SelectLocations()
        {
            return PartialView("_SelectLocations", GetViewLocations(base.CurrentUser.SystemUserID));
        }

        [ChildActionOnly]
        public ActionResult LocationSearch()
        {
            ViewLocationSearch vls = new ViewLocationSearch();
            vls.Regions = GetRegions(0);
            vls.Cities = new SelectList(new List<string>(), "", "");
            return PartialView("_LocationSearch", vls);
        }

        public ActionResult Location(int LocationID)
        {
            ViewBag.Location = GetLocation(LocationID);
            return PartialView("_Location");
        }

        /// <summary>
        /// Return a merged set of User's Locations and Searched Locations if Merge=1
        /// Else, returns Locations By City & Region
        /// </summary>
        /// <param name="RegionID"></param>
        /// <param name="City"></param>
        /// <returns></returns>
        public ActionResult LocationsBySearch(int RegionID, string City, int Merge)
        {
            LocationCollection unionLS = new LocationCollection();
            try
            {
                bool bMerge = Convert.ToBoolean(Merge);
                List<ViewLocation> vls = new List<ViewLocation>();
                LocationCollection ls = BizMgr.GetLocationsByCityRegionID(City, RegionID);
                LocationCollection uls = new LocationCollection();
                if (bMerge)
                {
                    uls = BizMgr.GetLocationsBySystemUserID(this.CurrentUser.SystemUserID);
                }
                unionLS = LAAF.Common.Helper.Union(uls, ls, "LocationID");
                string[] arrSort = new string[] { "RegionAbbrev", "City" };
                unionLS.Sort(arrSort, LAAF.Common.Helper.SortDirection.Ascending);
            }
            catch (Exception ex)
            {
                LogController.LogError(ex, LogEntryType.NormalError, "", "", "SystemUserID=" + this.CurrentUser.SystemUserID.ToString(), "");
            }
            return PartialView("_SelectLocations", GetViewLocationsFromLocations(unionLS));
        }

        public ActionResult PoolConfigs(int Id)
        {
            int LocationID = Id;
            ViewBag.PoolConfigs = GetPoolConfigs(LocationID);
            ViewBag.LocationID = LocationID;
            return PartialView("_Pools");
        }

        public ActionResult PoolConfig(int PoolID, int PoolConfigID)
        {
            ViewBag.PoolConfig = GetPoolConfig(PoolID, PoolConfigID);
            return PartialView("_PoolConfig");
        }

        public ActionResult Pool(int PoolID, int LocationID)
        {
            ViewBag.Pool = GetPool(PoolID, LocationID);
            //ViewBag.LocationID = LocationID;
            return PartialView("_Pool");
        }

        public ActionResult SavePool(ViewPool viewPool)
        {
            Pool pool = new Pool();
            pool.Description = viewPool.PoolDescription;
            pool.LocationID = viewPool.LocationID;
            int PoolID = BizMgr.SavePool(pool, this.CurrentUser.SystemUserID);

            PoolConfig poolConfig = new PoolConfig();
            poolConfig.Description = viewPool.Description;
            poolConfig.LaneLength = BizMgr.GetLaneLength(viewPool.LengthMajor, viewPool.LengthMinor, viewPool.UOMID);
            poolConfig.PoolConfigID = viewPool.PoolConfigID;
            poolConfig.PoolID = PoolID;
            poolConfig.LaneCount = viewPool.LaneCount;
            poolConfig.UOMID = viewPool.UOMID;
            poolConfig.PoolConfigID = BizMgr.SavePoolConfig(poolConfig, this.CurrentUser.SystemUserID);

            ViewBag.PoolConfigs = GetPoolConfigs(viewPool.LocationID);
            return PartialView("_PoolConfigs");
        }
        public ActionResult SavePoolConfig(ViewPoolConfig viewPoolConfig)
        {
            PoolConfig poolConfig = new PoolConfig();
            poolConfig.Description = viewPoolConfig.Description;
            poolConfig.LaneLength = BizMgr.GetLaneLength(viewPoolConfig.LengthMajor, viewPoolConfig.LengthMinor, viewPoolConfig.UOMID);
            poolConfig.PoolConfigID = viewPoolConfig.PoolConfigID;
            poolConfig.PoolID = viewPoolConfig.PoolID;
            poolConfig.LaneCount = viewPoolConfig.LaneCount;
            poolConfig.UOMID = viewPoolConfig.UOMID;
            poolConfig.PoolConfigID = BizMgr.SavePoolConfig(poolConfig, this.CurrentUser.SystemUserID);

            ViewBag.PoolConfigs = GetPoolConfigs(viewPoolConfig.LocationID);
            return PartialView("_PoolConfigs");
        }

        public ActionResult SaveLocation(ViewLocation viewLocation)
        {
            Swimomatic.Entity.Location location = new Swimomatic.Entity.Location();
            location.Address = viewLocation.Address;
            location.City = viewLocation.City;
            location.LocationID = viewLocation.LocationID;
            location.Name = viewLocation.Name;
            location.PostalCode = viewLocation.PostalCode;
            location.RegionID = viewLocation.RegionID;
            location.LocationID = BizMgr.SaveLocation(location, this.CurrentUser.SystemUserID);
            return LocationsBySearch(location.RegionID, location.City, 0);
        }
        #endregion

        #region Private Methods
        private ViewLocation GetLocation(int LocationID)
        {
            ViewLocation vl = new ViewLocation();
            Location location = BizMgr.GetLocation(LocationID);
            vl.Address = location.Address;
            vl.City = location.City;
            vl.LocationID = location.LocationID;
            vl.Name = location.Name;
            vl.PostalCode = location.PostalCode;
            vl.RegionID = location.RegionID;
            vl.Regions = GetRegions(location.RegionID);
            return vl;
        }

        public List<ViewLocation> GetViewLocations(int SystemUserID)
        {
            //TODO: Determine whether SystemUserID is neccessary
            LocationCollection ls = BizMgr.GetLocationsBySystemUserID(this.CurrentUser.SystemUserID);
            return GetViewLocationsFromLocations(ls);
        }

        private List<ViewLocation> GetViewLocationsFromLocations(LocationCollection ls)
        {
            List<ViewLocation> vls = new List<ViewLocation>();
            ViewLocation vl;
            foreach (Location l in ls)
            {
                vl = new ViewLocation();
                vl.LocationID = l.LocationID;
                vl.Address = l.Address;
                vl.City = l.City;
                vl.Name = l.Name;
                vl.PoolCount = l.PoolCount;
                vl.PostalCode = l.PostalCode;
                vl.RegionAbbrev = l.RegionAbbrev;
                vls.Add(vl);
            }
            return vls;
        }

        private List<ViewPoolConfig> GetPoolConfigs(int LocationID)
        {
            List<ViewPoolConfig> pcs = new List<ViewPoolConfig>();
            PoolConfigCollection poolConfigs = BizMgr.GetPoolConfigsByLocationID(LocationID);
            ViewPoolConfig pc = null;
            foreach (PoolConfig poolConfig in poolConfigs)
            {
                pc = new ViewPoolConfig();
                pc.Description = poolConfig.Description;
                pc.LaneCount = poolConfig.LaneCount;
                pc.LaneLength = poolConfig.LaneLength;
                pc.LengthDescription = poolConfig.LengthDescription;
                pc.LocationName = poolConfig.LocationName;
                pc.PoolConfigID = poolConfig.PoolConfigID;
                pc.PoolDescription = poolConfig.PoolDescription;
                pc.PoolID = poolConfig.PoolID;
                pc.UOMID = poolConfig.UOMID;
                pcs.Add(pc);
            }
            return pcs;
        }

        private ViewPool GetPool(int PoolID, int LocationID)
        {
            ViewPool pc = new ViewPool();
            Pool pool = null;
            PoolConfig poolConfig = new PoolConfig();
            if (PoolID == 0) //this is a new pool
            {
                pool = new Pool();
                poolConfig.Description = "Recreational";
                poolConfig.UOMID = 1; //default to meters
            }
            else
            {
                pool = BizMgr.GetPool(PoolID);
            }
            pc.UOMs = base.GetUOMs(poolConfig.UOMID);
            pc.PoolDescription = pool.Description;
            pc.Description = poolConfig.Description;
            pc.LaneCount = poolConfig.LaneCount;
            pc.LaneLength = poolConfig.LaneLength;
            pc.LengthMajor = (int)poolConfig.GetLengthFloor();
            pc.LengthMinor = (int)poolConfig.GetLengthRemainder();
            pc.LengthDescription = poolConfig.LengthDescription;
            pc.LocationName = poolConfig.LocationName;
            pc.LocationID = LocationID;
            pc.PoolConfigID = poolConfig.PoolConfigID;
            pc.PoolDescription = poolConfig.PoolDescription;
            pc.PoolID = poolConfig.PoolID;
            pc.UOMID = poolConfig.UOMID;
            return pc;

        }
        private ViewPoolConfig GetPoolConfig(int PoolID, int PoolConfigID)
        {
            ViewPoolConfig pc = new ViewPoolConfig();
            PoolConfig poolConfig = null;
            if (PoolConfigID == 0) //this is a new setup for an existing pool
            {
                poolConfig = new PoolConfig();
                poolConfig.Description = "Recreational";
                poolConfig.PoolID = PoolID;
                poolConfig.UOMID = 1; //default to meters
            }
            else
            {
                poolConfig = BizMgr.GetPoolConfig(PoolConfigID);
            }
            pc.UOMs = base.GetUOMs(poolConfig.UOMID);
            pc.Description = poolConfig.Description;
            pc.LaneCount = poolConfig.LaneCount;
            pc.LaneLength = poolConfig.LaneLength;
            pc.LengthMajor = (int)poolConfig.GetLengthFloor();
            pc.LengthMinor = (int)poolConfig.GetLengthRemainder();
            pc.LengthDescription = poolConfig.LengthDescription;
            pc.LocationName = poolConfig.LocationName;
            pc.LocationID = poolConfig.LocationID;
            pc.PoolConfigID = poolConfig.PoolConfigID;
            pc.PoolDescription = poolConfig.PoolDescription;
            pc.PoolID = poolConfig.PoolID;
            pc.UOMID = poolConfig.UOMID;
            return pc;
        }

        #endregion
    }
}
