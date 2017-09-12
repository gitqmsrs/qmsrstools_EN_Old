using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "ISOProcess")]
    public class ISOProcess
    {
        private int _isoprocessID;
        private int _parentID;
        private string _tag;
        private string _name;
        private string _description;
        private List<ISOProcess> _children;
        private RecordsStatus _status;
        private int _statusInt;
        private string _isostandard;

        public ISOProcess()
        {
            this._status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "ISOProcessID")]
        public int ISOProcessID
        {
            get
            {
                return _isoprocessID;
            }
            set
            {
                _isoprocessID = value;
            }
        }
        [XmlAttribute(AttributeName = "ISOStandard")]
        public string ISOStandard
        {
            get
            {
                return _isostandard;
            }
            set
            {
                _isostandard = value;
            }
        }
        public int ParentID
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
        public string Tag
        {
            get
            {
                return _tag;
            }
            set
            {
                _tag = value;
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
        public string Description
        {
            get
            {
                return _description;
            }
            set
            {
                _description = value;
            }
        }
        public List<ISOProcess> children
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
        public RecordsStatus Status
        {
            get
            {
                return _status;
            }
            set
            {
                _status = value;
                this.StatusInt = (int)value;
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