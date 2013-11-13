using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SwimomaticMVC
{
    public static class MobileHelpers
    {
        public static bool UserAgentContains(this ControllerContext c, string agentToFind)
        {
            return (c.HttpContext.Request.UserAgent.IndexOf(agentToFind, StringComparison.OrdinalIgnoreCase) > 0);
        }

        public static bool IsMobileDevice(this ControllerContext c)
        {
            return c.HttpContext.Request.Browser.IsMobileDevice;
        }

        public static void AddMobile<T>(this ViewEngineCollection ves, Func<ControllerContext, bool> isTheRightDevice, string pathToSearch)
            where T : IViewEngine, new()
        {
            ves.Add(new CustomMobileViewEngine(isTheRightDevice, pathToSearch, new T()));
        }

        public static void AddMobile<T>(this ViewEngineCollection ves, string userAgentSubstring, string pathToSearch)
            where T : IViewEngine, new()
        {
            ves.Add(new CustomMobileViewEngine(c => c.UserAgentContains(userAgentSubstring), pathToSearch, new T()));
        }

        public static void AddIPhone<T>(this ViewEngineCollection ves) //specific example helper
            where T : IViewEngine, new()
        {
            ves.Add(new CustomMobileViewEngine(c => c.UserAgentContains("iPhone"), "Mobile/iPhone", new T()));
        }

        public static void AddGenericMobile<T>(this ViewEngineCollection ves)
            where T : IViewEngine, new()
        {
            ves.Add(new CustomMobileViewEngine(c => c.IsMobileDevice(), "Mobile", new T()));
        }
    }
}