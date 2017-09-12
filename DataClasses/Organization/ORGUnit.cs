//class created to store the attribute values of the Organization Unit table in the database
using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Collections.Generic;
using System.IO;
namespace QMSRSTools
{
    [XmlType(TypeName = "ORGUnit")]
    public class ORGUnit
    {
        private string _code;
        private string _name;
        private DateTime _createdate;
        private string _orglevel;
        private string _country;

        private int _orgID;

        private List<ORGUnit> _children;

        private int _parentID;
        private int _depth;
        private RecordsStatus _status;
        private int _statusInt;

        public ORGUnit()
        {
            this._status = RecordsStatus.ORIGINAL;
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

        [XmlAttribute(AttributeName = "ORGID")]
        public int ORGID
        {
            get
            {
                return _orgID;
            }
            set
            {
                _orgID = value;
            }
        }

        [XmlAttribute(AttributeName = "Code")]
        public string Code
        {
            get
            {
                return _code;
            }
            set
            {
                _code = value;
            }
        }
        [XmlIgnore]
        public int Depth
        {
            get
            {
                return _depth;
            }
            set
            {
                _depth = value;
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
        public List<ORGUnit> children
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

        [XmlAttribute(AttributeName = "ORGLevel")]
        public string ORGLevel
        {
            get
            {
                return _orglevel;
            }
            set
            {
                _orglevel = value;
            }
        }


        [XmlAttribute(AttributeName = "Country")]
        public string Country
        {
            get
            {
                return _country;
            }
            set
            {
                _country = value;
            }
        }

        [XmlAttribute(AttributeName = "ParentID")]
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

        [XmlAttribute(AttributeName = "CreateDate")]
        public DateTime CreateDate
        {
            set
            {
                _createdate = value;
            }
            get
            {
                return _createdate;
            }
        }
    }
}