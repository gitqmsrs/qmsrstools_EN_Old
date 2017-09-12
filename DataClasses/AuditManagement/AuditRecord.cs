using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
namespace QMSRSTools
{
    public enum AuditRecordStatus
    {
        Cancelled=1,
        Completed=2,
        InProgress= 3,
        Pending=4,
        Rescheduled = 5,
        Closing=6
    }

    [XmlType(TypeName = "AuditRecord")]
    public class AuditRecord
    {
        private long _auditID;
        
        private string _auditreference;
        private string _audittype;
        private string _auditstatusstring;
        private string _scope;
        private string _summery;
        private string _notes;
        private string _processdoc;
        private string _supplier;
        private string _project;
        private string _auditname;
        private string _relatedxmlfindings;
        private string _xmlchecklist;
        private string _xmlunits;
        private string _xmlauditors;
        private string _xmlrecipients;
        private string _xmlauditrecipients;
        private string _modulename;
        private string _modestring;

        private AuditRecordStatus _auditstatus;

        private DateTime _plannedauditdate;
        private DateTime? _actualauditdate;
        private DateTime? _actualclosedate;
        private RecordsStatus _status;
        private RecordMode _mode;
        
        private Modules _module;
        
        private List<Employee> _auditors;
        private List<ORGUnit> _units;
        private List<ISOProcess> _checklists;
        private List<AuditFinding> _findings;
        private List<AuditEmailRecipient> _recipients;
        private List<Employee> _auditrecipients;

        private int _completed;

        public AuditRecord()
        {
            this.AuditStatus = AuditRecordStatus.Pending;
            this.Module = Modules.AuditManagement;
            this.Completed = 0;
            this.Mode = RecordMode.Current;
        }

        [XmlAttribute(AttributeName = "AuditID")]
        public long AuditID
        {
            get
            {
                return _auditID;
            }
            set
            {
                _auditID = value;
            }
        }

        [XmlAttribute(AttributeName = "AuditNo")]
        public string AuditNo
        {
            get
            {
                return _auditreference;
            }
            set
            {
                _auditreference = value;
            }
        }

        [XmlAttribute(AttributeName = "AuditType")]
        public string AuditType
        {
            get
            {
                return _audittype;
            }
            set
            {
                _audittype = value;

            }
        }

        [XmlAttribute(AttributeName = "AuditName")]
        public string AuditName
        {
            get
            {
                return _auditname;
            }
            set
            {
                _auditname = value;
            }
        }
        [XmlAttribute(AttributeName = "Completed")]
        public int Completed
        {
            get
            {
                return _completed;
            }
            set
            {
                _completed = value;
            }
        }
        [XmlAttribute(AttributeName = "Scope")]
        public string Scope
        {
            get
            {
                return _scope;
            }
            set
            {
                _scope = value;
            }
        }
        [XmlAttribute(AttributeName = "Summery")]
        public string Summery
        {
            get
            {
                return _summery;
            }
            set
            {
                _summery = value;
            }
        }
        [XmlAttribute(AttributeName = "Comments")]
        public string Comments
        {
            get
            {
                return _notes;
            }
            set
            {
                _notes = value;
            }
        }
        [XmlAttribute(AttributeName = "PlannedAuditDate")]
        public DateTime PlannedAuditDate
        {
            get
            {
                return _plannedauditdate;
            }
            set
            {
                _plannedauditdate = value;
            }
        }
        [XmlElement(ElementName = "ActualAuditDate")] 
        public DateTime? ActualAuditDate
        {
            get
            {
                return _actualauditdate;
            }
            set
            {
                _actualauditdate = value;
            }
        }

        [XmlElement(ElementName = "ActualCloseDate")]
        public DateTime? ActualCloseDate
        {
            get
            {
                return _actualclosedate;
            }
            set
            {
                _actualclosedate = value;
            }
        }

        [XmlIgnore]
        public AuditRecordStatus AuditStatus
        {
            get
            {
                return _auditstatus;
            }
            set
            {
                _auditstatus = value;
                this.AuditStatusString = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "AuditStatusString")]
        public string AuditStatusString
        {
            get
            {
                return _auditstatusstring;
            }
            set
            {
                _auditstatusstring = value;
            }
        }
        [XmlAttribute(AttributeName = "ProcessDocument")]
        public string ProcessDocument
        {
            get
            {
                return _processdoc;
            }
            set
            {
                _processdoc = value;
            }
        }
        [XmlAttribute(AttributeName = "Project")]
        public string Project
        {
            get
            {
                return _project;
            }
            set
            {
                _project = value;
            }
        }
        [XmlAttribute(AttributeName = "Supplier")]
        public string Supplier
        {
            get
            {
                return _supplier;
            }
            set
            {
                _supplier = value;
            }
        }

        [XmlIgnore]
        public List<Employee> Auditors
        {
            get
            {
                return _auditors;
            }
            set
            {
                _auditors = value;
                this.XMLAuditors = serializeXML(value);
            }
        }

        [XmlAttribute(AttributeName = "XMLAuditors")]
        public string XMLAuditors
        {
            get
            {
                return _xmlauditors;
            }
            set
            {
                _xmlauditors = value;
            }
        }
        [XmlIgnore]
        public List<AuditEmailRecipient> Recipients
        {
            get
            {
                return _recipients;
            }
            set
            {
                _recipients = value;
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

        [XmlIgnore]
        public List<Employee> AuditRecipients
        {
            get
            {
                return _auditrecipients;
            }
            set
            {
                _auditrecipients = value;
                this.XMLAuditRecipients = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "XMLAuditRecipients")]
        public string XMLAuditRecipients
        {
            get
            {
                return _xmlauditrecipients;
            }
            set
            {
                _xmlauditrecipients = value;
            }
        }
        
        [XmlIgnore]
        public List<ISOProcess> CheckLists
        {
            get
            {
                return _checklists;
            }
            set
            {
                _checklists = value;
                this.XMLChecklist = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "XMLChecklist")]
        public string XMLChecklist
        {
            get
            {
                return _xmlchecklist;
            }
            set
            {
                _xmlchecklist = value;
            }
        }
        [XmlIgnore]
        public List<ORGUnit> Units
        {
            get
            {
                return _units;
            }
            set
            {
                _units = value;
                this.XMLUnits = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "XMLUnits")]
        public string XMLUnits
        {
            get
            {
                return _xmlunits;
            }
            set
            {
                _xmlunits = value;
            }
        }
        [XmlIgnore]
        public List<AuditFinding> Findings
        {
            get
            {
                return _findings;
            }
            set
            {
                _findings = value;

                this.RelatedXmlFindings = serializeXML(value);
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

        [XmlAttribute(AttributeName = "RelatedXmlFindings")]
        public string RelatedXmlFindings
        {
            get
            {
                return _relatedxmlfindings;
            }
            set
            {
                _relatedxmlfindings = value;
            }
        }
        [XmlIgnore]
        public Modules Module
        {
            get
            {
                return _module;
            }
            set
            {
                _module = value;
                this.ModuleName = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ModuleName")]
        public string ModuleName
        {
            get
            {
                return _modulename;
            }
            set
            {
                _modulename = value;
            }
        }
        [XmlIgnore]
        public RecordMode Mode
        {
            get
            {
                return _mode;
            }
            set
            {
                _mode = value;
                this.ModeString = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ModeString")]
        public string ModeString
        {
            get
            {
                return _modestring;
            }
            set
            {
                _modestring = value;
            }
        }
        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                if (obj is List<AuditFinding>)
                {
                    serializer = new XmlSerializer(typeof(List<AuditFinding>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
                else if(obj is List<ISOProcess>)
                {
                    serializer = new XmlSerializer(typeof(List<ISOProcess>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
                else if (obj is List<ORGUnit>)
                {
                    serializer = new XmlSerializer(typeof(List<ORGUnit>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
                else if (obj is List<Employee>)
                {
                    serializer = new XmlSerializer(typeof(List<Employee>));

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