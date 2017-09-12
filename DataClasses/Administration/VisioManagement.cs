using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMSRSTools
{
    public class VisioManagement
    {
        private string _pageextension;
        private string _navigationURL;
        private string _visionodename;
        private string _modulename;
        private string _securityKey;

        private long _nodeID;
        private bool _isquerystr;
        private bool _ismodule;
      
        private RecordsStatus _status;

        public VisioManagement()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        public long NodeID
        {
            get
            {
                return _nodeID;
            }
            set
            {
                _nodeID = value;
            }
        }
        public string name
        {
            get
            {
                return _visionodename;
            }
            set
            {
                _visionodename = value;
            }
        }

        public string NavigationURL
        {
            get
            {
                return _navigationURL;
            }
            set
            {
                _navigationURL = value;
            }
        }
      
        public string PageExtension
        {
            get
            {
                return _pageextension;
            }
            set
            {
                _pageextension = value;
            }
        }

        public string RelatedModule
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
        public string SecurityKey
        {
            get
            {
                return _securityKey;
            }
            set
            {
                _securityKey = value;
            }
        }
        public bool IsQueryString
        {
            get
            {
                return _isquerystr;
            }
            set
            {
                _isquerystr = value;
            }
        }
        public bool IsModule
        {
            get
            {
                return _ismodule;
            }
            set
            {
                _ismodule = value;
            }
        }
        public RecordsStatus Status
        {
            get
            {
                return _status;
            }
            set
            {
                _status = value;
            }
        }
    }
}