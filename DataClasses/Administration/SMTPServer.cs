using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "SMTPServer")]
    public class SMTPServer
    {
        private long _smtpserverID;
        private string _smtpserver;
        private string _userName;
        private string _password;
        private RecordsStatus _status;

        public SMTPServer()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "SMTPServerID")]
        public long SMTPServerID
        {
            get
            {
                return _smtpserverID;
            }
            set
            {
                _smtpserverID = value;
            }
        }
        [XmlAttribute(AttributeName = "SMTP")]
        public string SMTP
        {
            get
            {
                return _smtpserver;
            }
            set
            {
                _smtpserver = value;
            }
        }
        
        [XmlAttribute(AttributeName = "UserName")]
        public string UserName
        {
            get
            {
                return _userName;
            }
            set
            {
                _userName = value;
            }
        }

        [XmlAttribute(AttributeName = "Password")]
        public string Password
        {
            get
            {
                return _password;
            }
            set
            {
                _password = value;
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