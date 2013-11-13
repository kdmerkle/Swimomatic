using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SwimomaticMVC.Helpers
{
    #region CacheClass
    public class InMemoryCache : ICacheService
    {
        public T Get<T>(string cacheID, Func<T> getItemCallback) where T : class
        {
            T item = HttpRuntime.Cache.Get(cacheID) as T;
            if (item == null)
            {
                item = getItemCallback();
                System.Web.HttpRuntime.Cache.Insert(cacheID, item);
            }
            return item;
        }

        public void Remove(string cacheID)
        {
            System.Web.HttpRuntime.Cache.Remove(cacheID);
        }
    }

    public interface ICacheService
    {
        T Get<T>(string cacheID, Func<T> getItemCallback) where T : class;
        void Remove(string cacheID);
    }
    #endregion
}