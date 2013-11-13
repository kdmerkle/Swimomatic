using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using SwimomaticMVC.Helpers;

namespace SwimomaticMVC
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        public static string UserName;

        public static void RegisterGlobalFilters(GlobalFilterCollection filters)
        {
            filters.Add(new HandleErrorAttribute());
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            //ignore Active Reports requests
            routes.IgnoreRoute("{*allActiveReportRpxHandler}", new { allActiveReportRpxHandler = @".*\.rpx(/.*)?" });
            routes.IgnoreRoute("{*allActiveReport}", new { allActiveReport = @".*\.ActiveReport(/.*)?" });
            routes.IgnoreRoute("{*allArCacheItem}", new { allArCacheItem = @".*\.ArCacheItem(/.*)?" });

            routes.MapRoute(
                "Default", // Route name
                "{controller}/{action}/{id}", // URL with parameters
                new { controller = "Home", action = "Index", id = UrlParameter.Optional } // Parameter defaults
            );

        }

        protected void Application_Start()
        {
            ControllerBuilder.Current.SetControllerFactory(typeof(UnityControllerBuilder));
            UnityContainerWrapper.Initialize();
            AreaRegistration.RegisterAllAreas();

            RegisterGlobalFilters(GlobalFilters.Filters);
            RegisterRoutes(RouteTable.Routes);

            ViewEngines.Engines.Clear();
            ViewEngines.Engines.AddIPhone<RazorViewEngine>();
            ViewEngines.Engines.AddMobile<RazorViewEngine>("Android", "Mobile/Android");
            ViewEngines.Engines.AddGenericMobile<RazorViewEngine>();
            ViewEngines.Engines.Add(new RazorViewEngine());
        }

        protected void Application_PostAuthenticateRequest(object sender, EventArgs e)
        {
            UserName = User.Identity.Name;
        }
    }
}