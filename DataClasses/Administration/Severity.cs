using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "Severity")]
    public class Severity
    {
        private int _severityID;
        private string _criteria;
        private int _value;
        private decimal _score;
        private DateTime _modifieddate;
        private string _modifiedby;
        private RecordsStatus _status;

        public Severity()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "SeverityID")]
        public int SeverityID
        {
            get
            {
                return _severityID;
            }
            set
            {
                _severityID = value;
            }
        }
        [XmlAttribute(AttributeName = "Criteria")]
        public string Criteria
        {
            get
            {
                return _criteria;
            }
            set
            {
                _criteria = value;
            }
        }
        [XmlAttribute(AttributeName = "SeverityValue")]
        public int SeverityValue
        {
            get
            {
                return _value;
            }
            set
            {
                _value = value;
            }
        }
        [XmlAttribute(AttributeName = "Score")]
        public decimal Score
        {
            get
            {
                return _score;
            }
            set
            {
                _score = value;
            }
        }
        [XmlAttribute(AttributeName = "ModifiedDate")]
        public DateTime ModifiedDate
        {
            get
            {
                return _modifieddate;
            }
            set
            {
                _modifieddate = value;
            }
        }
        [XmlAttribute(AttributeName = "ModifiedBy")]
        public string ModifiedBy
        {
            get
            {
                return _modifiedby;
            }
            set
            {
                _modifiedby = value;
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