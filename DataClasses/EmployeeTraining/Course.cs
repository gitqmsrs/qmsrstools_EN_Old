using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
namespace QMSRSTools
{
    public enum CourseStatus
    {
        Created = 1,
        Cancelled = 2,
        Scheduled = 3,
        Completed = 4,
        Active = 5
    }

    [XmlType(TypeName = "Course")]
    public class Course
    {
        private long _courseID;
        
        private string _coursetitle;
        private string _description;
        private string _period;
        private string _coordinator;
        private string _notes;
        private string _coursestatusstr;
        private string _courseno;
        private string _modestring;
        private string _material;

        private string _xmlschedule;
        private string _xmlenroller;
        private string _xmlquestion;

        private int _duration;
        private int _capacity;

        private List<CourseSchedule> _schedule;

        private List<Enroller> _enrollers;
       
        private List<Question> _questions;

        private DateTime _startdate;
        private DateTime? _enddate;

        private bool _lunch;
        private bool _refreshment;
        private bool _transportation;

        private CourseStatus _coursestatus;
        private RecordsStatus _status;
        private RecordMode _mode;

        public Course()
        {
            this.CourseStatus = CourseStatus.Created;
            this.Status = RecordsStatus.ORIGINAL;
            this.Mode = RecordMode.Current;
        }

        [XmlAttribute(AttributeName = "CourseID")]
        public long CourseID
        {
            get
            {
                return _courseID;
            }
            set
            {
                _courseID = value;
            }
        }

        [XmlAttribute(AttributeName = "CourseNo")]
        public string CourseNo
        {
            get
            {
                return _courseno;
            }
            set
            {
                _courseno = value;
            }
        }

        [XmlAttribute(AttributeName = "CourseTitle")]
        public string CourseTitle
        {
            get
            {
                return _coursetitle;
            }
            set
            {
                _coursetitle = value;
            }
        }

        [XmlAttribute(AttributeName = "Material")]
        public string Material
        {
            get
            {
                return _material;
            }
            set
            {
                _material = value;
            }
        }

        [XmlAttribute(AttributeName = "Description")]
        public string Description
        {
            get
            {
                return _description;
            }
            set
            {
                _description = value;
            }
        }
        [XmlAttribute(AttributeName = "Period")]
        public string Period
        {
            get
            {
                return _period;
            }
            set
            {
                _period = value;
            }
        }
        [XmlAttribute(AttributeName = "Duration")]
        public int Duration
        {
            get
            {
                return _duration;
            }
            set
            {
                _duration = value;
            }
        }
        [XmlAttribute(AttributeName = "Capacity")]
        public int Capacity
        {
            get
            {
                return _capacity;
            }
            set
            {
                _capacity = value;
            }
        }
        [XmlAttribute(AttributeName = "Coordinator")]
        public string Coordinator
        {
            get
            {
                return _coordinator;
            }
            set
            {
                _coordinator = value;
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
        [XmlElement(ElementName = "EndDate")]
        public DateTime? EndDate
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
        [XmlAttribute(AttributeName = "IncludeLunch")]
        public bool IncludeLunch
        {
            get
            {
                return _lunch;
            }
            set
            {
                _lunch = value;
            }
        }
        [XmlAttribute(AttributeName = "IncludeRefreshment")]
        public bool IncludeRefreshment
        {
            get
            {
                return _refreshment;
            }
            set
            {
                _refreshment = value;
            }
        }
        [XmlAttribute(AttributeName = "IncludeTransporation")]
        public bool IncludeTransporation
        {
            get
            {
                return _transportation;
            }
            set
            {
                _transportation = value;
            }
        }
        [XmlIgnore]
        public CourseStatus CourseStatus
        {
            get
            {
                return _coursestatus;
            }
            set
            {
                _coursestatus = value;
                this.CourseStatusStr = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "CourseStatus")]
        public string CourseStatusStr
        {
            get
            {
                return _coursestatusstr;
            }
            set
            {
                _coursestatusstr = value;
            }
        }
        [XmlIgnore]
        public List<CourseSchedule> Schedule
        {
            get
            {
                return _schedule;
            }
            set
            {
                _schedule = value;

                this.XMLSchedule = serializeXML(value);
            }
        }

        [XmlIgnore]
        public List<Question> Question
        {
            get
            {
                return _questions;
            }
            set
            {
                _questions = value;
                this.XMLQuestion = serializeXML(value);
            }
        }

      
        [XmlIgnore]
        public List<Enroller> Enroller
        {
            get
            {
                return _enrollers;
            }
            set
            {
                _enrollers = value;
                this.XMLEnroller = serializeXML(value);
            }
        }

        [XmlAttribute(AttributeName = "XMLSchedule")]
        public string XMLSchedule
        {
            get
            {
                return _xmlschedule;
            }
            set
            {
                _xmlschedule = value;
            }
        }

        [XmlAttribute(AttributeName = "XMLEnroller")]
        public string XMLEnroller
        {
            get
            {
                return _xmlenroller;
            }
            set
            {
                _xmlenroller = value;
            }
        }

        [XmlAttribute(AttributeName = "XMLQuestion")]
        public string XMLQuestion
        {
            get
            {
                return _xmlquestion;
            }
            set
            {
                _xmlquestion = value;
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
                try
                {
                    if (obj is List<CourseSchedule>)
                    {
                        serializer = new XmlSerializer(typeof(List<CourseSchedule>));
                        writer = new StringWriter();
                        serializer.Serialize(writer, obj);
                    }
                    else if (obj is List<Enroller>)
                    {
                        serializer = new XmlSerializer(typeof(List<Enroller>));
                        writer = new StringWriter();
                        serializer.Serialize(writer, obj);
                    }
                    else if (obj is List<Question>)
                    {
                        serializer = new XmlSerializer(typeof(List<Question>));
                        writer = new StringWriter();
                        serializer.Serialize(writer, obj);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.InnerException.Message);
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