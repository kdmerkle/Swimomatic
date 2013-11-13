using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Practices.Unity;
using System.Web.Mvc;
using System.Web.Routing;

namespace SwimomaticMVC.Helpers
{
    #region The UnityContainerWrapper, which provides access to the IoC container to callers

    public static class UnityContainerWrapper
    {
        // locking reference object so multiple first-hit threads don't result in multiple UnityContainers
        public static object padLock = new object();

        // the container itself
        public static UnityContainer Container { get; set; }

        internal static void Initialize()
        {
            // create the UnityContainer instance when the application starts
            lock (padLock)
            {
                if (UnityContainerWrapper.Container == null)
                {
                    UnityContainerWrapper.Container = new UnityContainer();

                    // now tell it what to hand back when someone asks for an ICacheService
                    UnityContainerWrapper
                        .Container
                        // singleton
                            .RegisterType<ICacheService, InMemoryCache>(new ContainerControlledLifetimeManager())
                        // single-call
                        //.RegisterType<ICacheService, InMemoryCache>()
                            ;

                    // PS: you can do this via configuration files too
                }
            }
        }
    }

    #endregion

    #region The ControllerBuilder that uses the UnityContainer to inject controllers

    public class UnityControllerBuilder : System.Web.Mvc.DefaultControllerFactory
    {
        protected override IController GetControllerInstance(RequestContext requestContext, Type controllerType)
        {
            // now unity will do the job of calling the constructors, so put whatever you want in them
            return UnityContainerWrapper.Container.Resolve(controllerType) as IController;
        }
    }

    #endregion
}