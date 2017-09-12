using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Collections.Generic;
using System.IO;
namespace QMSRSTools
{
    [XmlType(TypeName = "EmailTemplate")]
    public class EmailTemplate
    {
        private long _emailID;
        private string _module;
        private string _action;
        private string _subject;
        private string _body;
        private string _from;
        private string _smtpserver;
        private string _xmlrecipients;

        private RecordsStatus _status;
        private List<EmailRecipient> _recipients;
        
        public EmailTemplate()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }
        
        [XmlAttribute(AttributeName = "EmailID")]
        public long EmailID
        {
            get
            {
                return _emailID;
            }
            set
            {
                _emailID = value;
            }
        }
        [XmlAttribute(AttributeName = "Module")]
        public string Module
        {
            get
            {
                return _module;
            }
            set
            {
                _module = value;
            }
        }
        [XmlAttribute(AttributeName = "Action")]
        public string Action
        {
            get
            {
                return _action;
            }
            set
            {
                _action = value;
            }
        }
        [XmlAttribute(AttributeName = "Subject")]
        public string Subject
        {
            get
            {
                return _subject;
            }
            set
            {
                _subject = value;
            }
        }
        [XmlAttribute(AttributeName = "Body")]
        public string Body
        {
            get
            {
                return _body;
            }
            set
            {
                _body = value;
            }
        }
        [XmlAttribute(AttributeName = "EmailFrom")]
        public string EmailFrom
        {
            get
            {
                return _from;
            }
            set
            {
                _from = value;
            }
        }
        [XmlAttribute(AttributeName = "SMTPServer")]
        public string SMTPServer
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
        public List<EmailRecipient> Recipients
        {
            get
            {
                return _recipients;
            }
            set
            {
                _recipients = value;
                this.XMLRecipients = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "XMLRecipients")]
        public string XMLRecipients
        {
            get
            {
                return _xmlrecipients;
            }
            set
            {
                _xmlrecipients = value;
            }
        }
        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                if (obj is List<EmailRecipient>)
                {
                    serializer = new XmlSerializer(typeof(List<EmailRecipient>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
            }
            else
            {
                writer = new StringWriter();
            }
            return writer.ToString();
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