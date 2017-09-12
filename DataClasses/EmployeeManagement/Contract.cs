using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;

namespace QMSRSTools
{
    public enum ContractStatus
    {
        ACTIVE=1,
        SUSPENDED=2,
        EXTENDED=3,
        EXPIRED=4,
        TERMINATED=8
    }
    [XmlType(TypeName = "Contract")]
    public class Contract
    {
        private int _contractID;
        private string _contractno;
        private string _contactstatusstr;
        private string _group;
        private string _type;
        private string _remarks;
        private string _terminationreason;

        private DateTime _startdate;
        private DateTime _enddate;
        private DateTime? _terminationdate;
        private DateTime? _extendedtodate;

        private ContractStatus _contractstatus;
        private RecordsStatus _status;
        

        private List<ContractAssignement> _assignment;
        private List<Extensions> _extensions;

        private string _xmlassignement;

        public Contract()
        {
            this._contractstatus = ContractStatus.ACTIVE;
            
            this.Remarks = "CONTRACT IS ACTIVE";

            this._status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "ContractID")]
        public int ContractID
        {
            get
            {
                return _contractID;
            }
            set
            {
                _contractID = value;
            }
        }
        [XmlAttribute(AttributeName = "ContractNo")]
        public string ContractNo
        {
            get
            {
                return _contractno;
            }
            set
            {
                _contractno = value;
            }
        }
        [XmlAttribute(AttributeName = "StartDate")]
        public DateTime StartDate
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
        [XmlAttribute(AttributeName = "EndDate")]
        public DateTime EndDate
        {
            get
            {
                return _enddate;
            }
            set
            {
                _enddate = value;
            }
        }
        [XmlAttribute(AttributeName = "Group")]
        public string Group
        {
            get
            {
                return _group;
            }
            set
            {
                _group = value;
            }
        }
        [XmlAttribute(AttributeName = "Type")]
        public string Type
        {
            get
            {
                return _type;
            }
            set
            {
                _type = value;
            }
        }
        [XmlElement(ElementName = "TerminationDate")] 
        public DateTime? TerminationDate
        {
            get
            {
                return _terminationdate;
            }
            set
            {
                _terminationdate = value;
            }
        }
        [XmlElement(ElementName = "ExtendedToDate")]
        public DateTime? ExtendedToDate
        {
            get
            {
                return _extendedtodate;
            }
            set
            {
                _extendedtodate = value;
            }
        }
        [XmlAttribute(AttributeName = "Remarks")]
        public string Remarks
        {
            get
            {
                return _remarks;
            }
            set
            {
                _remarks=value;
            }
        }
        [XmlAttribute(AttributeName = "TermenationReason")]
        public string TermenationReason
        {
            get
            {
                return _terminationreason;
            }
            set
            {
                _terminationreason = value;
            }
        }
        [XmlIgnore]
        public List<ContractAssignement> Assignement
        {
            get
            {
                return _assignment;
            }
            set
            {
                _assignment = value;

                this.XMLAssignement = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "XMLAssignement")]
        public string XMLAssignement
        {
            get
            {
                return _xmlassignement;
            }
            set
            {
                _xmlassignement = value;
            }
        }
        [XmlIgnore]
        public List<Extensions> Extensions
        {
            get
            {
                return _extensions;
            }
            set
            {
                _extensions = value;
            }
        }

        [XmlIgnore]
        public ContractStatus CStatus
        {
            get
            {
                return _contractstatus;       
            }
            set
            {
                _contractstatus = value;
                this.CStatusStr = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "CStatusStr")]
        public string CStatusStr
        {
            get
            {
                return _contactstatusstr;
            }
            set
            {
                _contactstatusstr = value;
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

        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                if (obj is List<ContractAssignement>)
                {
                    serializer = new XmlSerializer(typeof(List<ContractAssignement>));

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
    }
}