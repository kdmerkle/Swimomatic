using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using SwimomaticBusinessLib;
using Swimomatic.Entity;

namespace SwimomaticMVC.Helpers
{
    public class CurrentUserBase : SystemUser
    {
        public CurrentUserBase(SystemUser systemUser)
        {
            base.CreateDate = systemUser.CreateDate;
            base.City = systemUser.City;
            base.Email = systemUser.Email;
            base.IsActive = systemUser.IsActive;
            base.Password = systemUser.Password;
            base.RegionID = systemUser.RegionID;
            base.RegistrationKey = systemUser.RegistrationKey;
            base.ResetPassword = systemUser.ResetPassword;
            base.SystemUserID = systemUser.SystemUserID;
            base.UserName = systemUser.UserName;
            base.LastName = systemUser.LastName;
            base.FirstName = systemUser.FirstName;
            base.RegionAbbrev = systemUser.RegionAbbrev;
        }

        //private TeamCollection _Teams;
        //public TeamCollection Teams
        //{
        //    get
        //    {
        //        if (_Teams == null)
        //        {
        //            _Teams = new TeamCollection();
        //        }
        //        return _Teams;
        //    }
        //    set
        //    {
        //        _Teams = value;
        //    }
        //}
        //private SwimmerCollection _Swimmers;
        //public SwimmerCollection Swimmers
        //{
        //    get
        //    {
        //        if (_Swimmers == null)
        //        {
        //            _Swimmers = new SwimmerCollection();
        //        }
        //        return _Swimmers;
        //    }
        //    set
        //    {
        //        _Swimmers = value;
        //    }
        //}
        //private LeagueCollection _Leagues;
        //public LeagueCollection Leagues
        //{
        //    get
        //    {
        //        if (_Leagues == null)
        //        {
        //            _Leagues = new LeagueCollection();
        //        }
        //        return _Leagues;
        //    }
        //    set
        //    {
        //        _Leagues = value;
        //    }
        //}
        //private SwimMeetCollection _SwimMeets;
        //public SwimMeetCollection SwimMeets
        //{
        //    get
        //    {
        //        if (_SwimMeets == null)
        //        {
        //            _SwimMeets = new SwimMeetCollection();
        //        }
        //        return _SwimMeets;
        //    }
        //    set
        //    {
        //        _SwimMeets = value;
        //    }
        //}
    }
}