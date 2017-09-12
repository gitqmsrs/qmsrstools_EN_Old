using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "ISOStandard")]
    public class ISOStandard
    {
        private int _isostandardID;
        private string _isoname;
        private string _description;
        private RecordsStatus _status;

        public ISOStandard()
        {
            this._status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "ISOStandardID")]
        public int ISOStandardID
        {
            get
            {
                return _isostandardID;
            }
            set
            {
                _isostandardID = value;
            }
        }

        [XmlAttribute(AttributeName = "ISOName")]
        public string ISOName
        {
            get
            {
                return _isoname;
            }
            set
            {
                _isoname = value;
            }
        }

        [XmlAttribute(AttributeName = "Description")]
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
    }
}