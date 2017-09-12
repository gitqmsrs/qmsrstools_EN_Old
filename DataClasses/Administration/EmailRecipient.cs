using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "EmailRecipient")]
    public class EmailRecipient
    {
        private long _recipientID;
        private string _recipient;
        private bool _isTo;
        private bool _isCC;
        private bool _isBCC;
        private RecordsStatus _status;
        private int _statusInt;

        public EmailRecipient()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "RecipientID")]
        public long RecipientID
        {
            get
            {
                return _recipientID;
            }
            set
            {
                _recipientID = value;
            }
        }
        [XmlAttribute(AttributeName = "Recipient")]
        public string Recipient
        {
            get
            {
                return _recipient;
            }
            set
            {
                _recipient = value;
            }
        }
        [XmlAttribute(AttributeName = "IsTo")]
        public bool IsTo
        {
            get
            {
                return _isTo;
            }
            set
            {
                _isTo = value;
            }
        }
        [XmlAttribute(AttributeName = "IsCC")]
        public bool IsCC
        {
            get
            {
                return _isCC;
            }
            set
            {
                _isCC = value;
            }
        }
        [XmlAttribute(AttributeName = "IsBCC")]
        public bool IsBCC
        {
            get
            {
                return _isBCC;
            }
            set
            {
                _isBCC = value;
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