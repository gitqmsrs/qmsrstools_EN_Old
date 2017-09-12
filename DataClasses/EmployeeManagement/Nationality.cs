using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "Nationality")]
    public class Nationality
    {
        private int _nationalityid;
        private string _passportno;
        private DateTime _startdate;
        private DateTime _expirydate;
        private string _authority;
        private RecordsStatus _status;

        public Nationality()
        {
            this._status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "NationalityID")]
        public int NationalityID
        {
            get
            {
                return _nationalityid;
            }
            set
            {
                _nationalityid = value;
            }
        }
        [XmlAttribute(AttributeName = "PassportNo")]
        public string PassportNo
        {
            get
            {
                return _passportno;
            }
            set
            {
                _passportno = value;
            }
        }
        [XmlAttribute(AttributeName = "IssueDate")]
        public DateTime IssueDate
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
        [XmlAttribute(AttributeName = "ExpiryDate")]
        public DateTime ExpiryDate
        {
            get
            {
                return _expirydate;
            }
            set
            {
                _expirydate = value;
            }
        }
        [XmlAttribute(AttributeName = "Authority")]
        public string Authority
        {
            get
            {
                return _authority;
            }
            set
            {
                _authority = value;
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