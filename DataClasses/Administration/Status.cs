using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "Status")]
    public class Status
    {
        private long _statusID;
        private string _statusname;
        private string _description;
        private RecordsStatus _status;

        public Status()
        {
            this.RecordStatus = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "StatusID")]
        public long StatusID
        {
            get
            {
                return _statusID;
            }
            set
            {
                _statusID = value;
            }
        }
        [XmlAttribute(AttributeName = "StatusName")]
        public string StatusName
        {
            get
            {
                return _statusname;
            }
            set
            {
                _statusname = value;
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
        public RecordsStatus RecordStatus
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