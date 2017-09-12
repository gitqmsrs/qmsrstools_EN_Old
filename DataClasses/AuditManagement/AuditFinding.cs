using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
namespace QMSRSTools
{
    [XmlType(TypeName = "AuditFinding")]
    public class AuditFinding
    {
        private long _findingid;

        private string _finding;
        private string _findingtype;
        private string _details;
        private string _checkliststr;
        private string _xmlactions;
        private List<Causes> _causes;
        private List<AuditActions> _actions;
        private List<Causes> _selected;
        private ISOProcess _checklist;

        private RecordsStatus _status;

        private string _causeName;

        public AuditFinding()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "FindingID")]
        public long FindingID
        {
            get
            {
                return _findingid;
            }
            set
            {
                _findingid = value;
            }
        }
        [XmlAttribute(AttributeName = "Finding")]
        public string Finding
        {
            get
            {
                return _finding;
            }
            set
            {
                _finding = value;
            }
        }
        [XmlAttribute(AttributeName = "FindingType")]
        public string FindingType
        {
            get
            {
                return _findingtype;
            }
            set
            {
                _findingtype = value;
            }
        }
        [XmlAttribute(AttributeName = "Details")]
        public string Details
        {
            get
            {
                return _details;
            }
            set
            {
                _details = value;
            }
        }
        [XmlIgnore]
        public List<Causes> Causes
        {

            get
            {
                return _causes;
            }
            set
            {
                _causes = value;
            }
        }
        [XmlIgnore]
        public List<Causes> SelectedCause
        {
            get
            {
                return _selected;
            } set
            {
                _selected = value;
            }
        }
        [XmlIgnore]
        public ISOProcess CheckList
        {
            get
            {
                return _checklist;
            }
            set
            {
                _checklist = value;
                if (value != null)
                {
                    this.ISOChecklistString = value.name;
                }
            }
        }
        [XmlAttribute(AttributeName = "ISOChecklistString")]
        public string ISOChecklistString
        {
            get
            {
                return _checkliststr;
            }
            set
            {
                _checkliststr = value;
            }
        }
        [XmlIgnore]
        public List<AuditActions> Actions
        {
            get
            {
                return _actions;
            }
            set
            {
                _actions = value;
                this.AuditStatusString = serializeXML(value);
            }
        }

        [XmlAttribute(AttributeName = "XMLAuditActions")]
        public string AuditStatusString
        {
            get
            {
                return _xmlactions;
            }
            set
            {

                _xmlactions = value;
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
        [XmlAttribute(AttributeName = "CauseName")]
        public string CauseName
        {
            get
            {
                return _causeName;
            }
            set
            {
                _causeName = value;
            }
        }

        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                if (obj is List<AuditActions>)
                {
                    serializer = new XmlSerializer(typeof(List<AuditActions>));

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