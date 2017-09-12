using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMSRSTools
{
    public class SessionContext
    {
        private string _username;
        private string _sessionID;
        private TimeZoneInfo _currentTimeZone;

        public string UserName
        {
            get
            {
                return _username;
            }
            set
            {
                _username = value;
            }
        }

        public string SessionID
        {
            get
            {
                return _sessionID;
            }
            set
            {
                _sessionID = value;
            }
        }

        public TimeZoneInfo CurrentTimeZone
        {
            get
            {
                return _currentTimeZone;
            }
            set
            {
                _currentTimeZone = value;
            }
        }

    }
}