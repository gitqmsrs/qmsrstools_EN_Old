using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "Extensions")]
    public class Extensions
    {
        private int _extensionID;
        private int _duration;
        
        private string _period;
        
        private bool _activeflag;

        private DateTime _fromdate;
        private DateTime _todate;

        private RecordsStatus _status;

        [XmlAttribute(AttributeName = "ExtensionID")]
        public int ExtensionID
        {
            get
            {
                return _extensionID;
            }
            set
            {
                _extensionID = value;
            }
        }
        [XmlAttribute(AttributeName = "Duration")]
        public int Duration
        {
            get
            {
                return _duration;
            }
            set
            {
                _duration = value;
            }
        }
        [XmlAttribute(AttributeName = "Period")]
        public string Period
        {
            get
            {
                return _period;
            }
            set
            {
                _period = value;
            }
        }
        [XmlAttribute(AttributeName = "FromDate")]
        public DateTime FromDate
        {
            get
            {
                return _fromdate;
            }
            set
            {
                _fromdate = value;
            }
        }
        [XmlAttribute(AttributeName = "ToDate")]
        public DateTime ToDate
        {
            get
            {
                return _todate;
            }
            set
            {
                _todate=value;
            }
        }
        [XmlAttribute(AttributeName = "ActiveFlag")]
        public bool ActiveFlag
        {
            get
            {
                return _activeflag;
            }
            set
            {
                _activeflag = value;
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