using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace SwimomaticMVC.Controllers
{
    public class HomeController : ControllerBase
    {
        public ActionResult Index()
        {
            ViewBag.Message = "Welcome to Swimomatic!";
            return View();
        }

        public ActionResult About()
        {
            return View();
        }
        public ActionResult Sample()
        {
            return View();
        }
    }
}
