using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "ResidenceDocument")]
    public class ResidenceDocument
    {
        private int _permitID;

        private string _documentno;
        private string _documenttype;
        private string _documentstatus;

        private DateTime _validfrom;
        private DateTime _validto;
        private RecordsStatus _status;

        public ResidenceDocument()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "PermitID")]
        public int PermitID
        {
            get
            {
                return _permitID;
            }
            set
            {
                _permitID = value;
            }
        }

        [XmlAttribute(AttributeName = "DocumentNo")]
        public string DocumentNo
        {
            get
            {
                return _documentno;
            }
            set
            {
                _documentno = value;
            }
        }
        [XmlAttribute(AttributeName = "DocumentType")]
        public string DocumentType
        {
            get
            {
                return _documenttype;
            }
            set
            {
                _documenttype = value;
            }
        }

        [XmlAttribute(AttributeName = "DocumentStatus")]
        public string DocumentStatus
        {
            get
            {
                return _documentstatus;
            }
            set
            {
                _documentstatus = value;
            }
        }
        [XmlAttribute(AttributeName = "ValidFrom")]
        public DateTime ValidFrom
        {
            get
            {
                return _validfrom;
            }
            set
            {
                _validfrom = value;
            }
        }
        [XmlAttribute(AttributeName = "ValidTo")]
        public DateTime ValidTo
        {
            get
            {
                return _validto;
            }
            set
            {
                _validto = value;
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