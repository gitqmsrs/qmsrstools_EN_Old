using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Configuration;

namespace QMSRS.Utilities
{
    public class WebConfigurationManager
    {
        public static string GetSitePath()
        {
            return ConfigurationManager.AppSettings["SiteURL"].ToString();
        }

        public static string GetTimeZone()
        {
            return ConfigurationManager.AppSettings["TimeZoneSource"].ToString();
        }
    }
}
