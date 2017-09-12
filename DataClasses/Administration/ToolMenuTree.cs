using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "ToolMenuTree")]
    public class ToolMenuTree
    {
        private long _nodeID;
        private long _parentID;
        private string _name;
        private string _nodenavigation;
        private List<ToolMenuTree> _children;
        private RecordsStatus _status;
        private string _pageextension;
        private string _securitykey;
        private bool _isquerystr;
        private bool _ismodule;
        private int _statusInt;
        
        public ToolMenuTree()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "NodeID")]
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
        [XmlAttribute(AttributeName = "name")]
        public string name
        {
            get
            {
                return _name;
            }
            set
            {
                _name = value;
            }
        }
      
        [XmlIgnore]
        public string NavigationLink
        {
            get
            {
                return _nodenavigation;
            }
            set
            {
                _nodenavigation = value;
            }
        }
        [XmlIgnore]
        public List<ToolMenuTree> children
        {
            get
            {
                return _children;
            }
            set
            {
                _children = value;
            }
        }
        [XmlIgnore]
        public long ParentID
        {
            get
            {
                return _parentID;
            }
            set
            {
                _parentID = value;
            }
        }
        [XmlIgnore]
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
        [XmlIgnore]
        public string SecurityKey
        {
            get
            {
                return _securitykey;
            }
            set
            {
                _securitykey = value;
            }
        }
        [XmlIgnore]
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
        [XmlIgnore]
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
        [XmlIgnore]
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
        [XmlAttribute(AttributeName = "Status")]
        public int StatusInt
        {
            get
            {
                return _statusInt;
            }
            set
            {
                _statusInt = value;
            }
        }
    }
}