using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
namespace QMSRSTools
{
    public enum ReviewStatus
    {
        Cancelled = 1,
        Completed = 2,
        InProgress = 3,
        Pending = 4,
        Rescheduled = 5,
        ClosingDown = 6
    }

    [XmlType(TypeName = "Review")]
    public class Review
    {
        private int _reviewID;
        
        private string _reviewNo;
        private string _objectives;
        private string _summary;
        private string _notes;
        private string _reviewstatusstr;
        private string _reviewname;
        private string _reviewcategory;
        private string _modestring;

        private List<ReviewTask> _tasks;
        private List<Employee> _representatives;
        private List<ORGUnit> _units;
        private List<AuditEmailRecipient> _recipients;
        private List<Employee> _reviewrecipients;
 
        private DateTime _plannedreviewdate;
        private DateTime? _actualreviewdate;
        private DateTime? _actualclosedate;

        private ReviewStatus _reviewstatus;

        private RecordsStatus _status;

        private string _xmltasks;
        private string _xmlunits;
        private string _xmlrepresentatives;
        private string _xmlreviewrecipients;

        private Modules _module;
        private string _modulename;
        private RecordMode _mode;

        public Review()
        {
            this.Status = RecordsStatus.ORIGINAL;
            this.ReviewStatus = ReviewStatus.Pending;
            this.Module = Modules.ManagementReviews;
            this.Mode = RecordMode.Current;
        }

        [XmlAttribute(AttributeName = "ReviewID")]
        public int ReviewID
        {
            get
            {
                return _reviewID;
            }
            set
            {
                _reviewID = value;
            }
        }

        [XmlAttribute(AttributeName = "ReviewNo")]
        public string ReviewNo
        {
            get
            {
                return _reviewNo;
            }
            set
            {
                _reviewNo = value;
            }
        }
        [XmlAttribute(AttributeName = "ReviewCategory")]
        public string ReviewCategory
        {
            get
            {
                return _reviewcategory;
            }
            set
            {
                _reviewcategory = value;
            }
        }
        [XmlAttribute(AttributeName = "ReviewName")]
        public string ReviewName
        {
            get
            {
                return _reviewname;
            }
            set
            {
                _reviewname=value;
            }
        }
        [XmlAttribute(AttributeName = "PlannedReviewDate")]
        public DateTime PlannedReviewDate
        {
            get
            {
                return _plannedreviewdate;
            }
            set
            {
                _plannedreviewdate = value;
            }
        }

        [XmlElement(ElementName = "ActualReviewDate")]
        public DateTime? ActualReviewDate
        {
            get
            {
                return _actualreviewdate;
            }
            set
            {
                _actualreviewdate = value;
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

        [XmlAttribute(AttributeName = "Objectives")]
        public string Objectives
        {
            get
            {
                return _objectives;
            }
            set
            {
                _objectives = value;
            }
        }

        [XmlAttribute(AttributeName = "Summary")]
        public string Summary
        {
            get
            {
                return _summary;
            }
            set
            {
                _summary = value;
            }
        }

        [XmlAttribute(AttributeName = "Notes")]
        public string Notes
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

        [XmlIgnore]
        public ReviewStatus ReviewStatus
        {
            get
            {
                return _reviewstatus;
            }
            set
            {
                _reviewstatus = value;
                this.ReviewStatusStr = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ReviewStatus")]
        public string ReviewStatusStr
        {
            get
            {
                return _reviewstatusstr;
            }
            set
            {
                _reviewstatusstr = value;
            }
        }
        [XmlIgnore]
        public List<ReviewTask> Tasks
        {
            get
            {
                return _tasks;
            }
            set
            {
                _tasks = value;
                this.XMLTasks = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "XMLTasks")]
        public string XMLTasks
        {
            get
            {
                return _xmltasks;
            }
            set
            {
                _xmltasks = value;
            }
        }
        [XmlIgnore]
        public List<Employee> Representatives
        {
            get
            {
                return _representatives;
            }
            set
            {
                _representatives = value;

                this.XMLRepresentatives = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "XMLRepresentatives")]
        public string XMLRepresentatives
        {
            get
            {
                return _xmlrepresentatives;
            }
            set
            {
                _xmlrepresentatives = value;
            }
        }
        [XmlIgnore]
        public List<Employee> ReviewRecipients
        {
            get
            {
                return _reviewrecipients;
            }
            set
            {
                _reviewrecipients = value;
                this.XMLReviewRecipients = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "XMLReviewRecipients")]
        public string XMLReviewRecipients
        {
            get
            {
                return _xmlreviewrecipients;
            }
            set
            {
                _xmlreviewrecipients = value;
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
                if (obj is List<ReviewTask>)
                {
                    serializer = new XmlSerializer(typeof(List<ReviewTask>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
                else if (obj is List<Employee>)
                {
                    serializer = new XmlSerializer(typeof(List<Employee>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
                else if (obj is List<ORGUnit>)
                {
                    serializer = new XmlSerializer(typeof(List<ORGUnit>));

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