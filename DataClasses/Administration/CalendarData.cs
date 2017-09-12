using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    public class CalendarData
    {
        private int _eventID;
        
        private string _eventname;
        private string _url;
        private string _backgroundcolor;
        private string _color;
        private string _modulename;
        private string _starttime;
        private string _endtime;

        private DateTime _startdate;
        private DateTime? _enddate;
        
        public CalendarData()
        {
        }

        public int id
        {
            get
            {
                return _eventID;
            }
            set
            {
                _eventID = value;
            }
        }

        public string title
        {
            get
            {
                return _eventname;
            }
            set
            {
                _eventname = value;
            }

        }

        public DateTime start
        {
            get
            {
                return _startdate;
            }
            set
            {
                _startdate = value;
            }
        }

        public DateTime? end
        {
            get
            {
                return _enddate;
            }
            set
            {
                _enddate = value;
            }
        }
        public string starttime
        {
            get
            {
                return _starttime;
            }
            set
            {
                _starttime = value;
            }
        }

        public string endtime
        {
            get
            {
                return _endtime;
            }
            set
            {
                _endtime = value;
            }
        }

        public string url
        {
            get
            {
                return _url;
            }
            set
            {
                _url = value;
            }
        }

        public string backgroundColor
        {
            get
            {
                return _backgroundcolor;
            }
            set
            {
                _backgroundcolor = value;
            }
        }
        public string modulename
        {
            get
            {
                return _modulename;
            }
            set
            {
                _modulename = value;
            }
        }
        public string color
        {
            get
            {
                return _color;
            }
            set
            {
                _color = value;
            }
        }
    }
}