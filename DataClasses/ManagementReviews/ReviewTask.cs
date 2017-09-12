using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
namespace QMSRSTools
{
    [XmlType(TypeName = "ReviewTask")]
    public class ReviewTask
    {
        private int _taskID;
        
        private string _taskname;
        private string _description;
        private string _owner;
        
        private DateTime _plannedclosedate;
        private DateTime? _actualclosedate;

        private RecordsStatus _status;

        private List<ManagentReviewAction> _actions;
        private string _xmlactions;

        private bool _isclosed;

        public ReviewTask()
        {
            this.Status = RecordsStatus.ORIGINAL;
            this.IsClosed = false;
        }

        [XmlAttribute(AttributeName = "TaskID")]
        public int TaskID
        {
            get
            {
                return _taskID;
            }
            set
            {
                _taskID = value;
            }
        }

        [XmlAttribute(AttributeName = "TaskName")]
        public string TaskName
        {
            get
            {
                return _taskname;
            }
            set
            {
                _taskname = value;
            }
        }

        [XmlAttribute(AttributeName = "IsClosed")]
        public bool IsClosed
        {
            get
            {
                return _isclosed;
            }
            set
            {
                _isclosed = value;
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

        [XmlAttribute(AttributeName = "Owner")]
        public string Owner
        {
            get
            {
                return _owner;
            }
            set
            {
                _owner = value;
            }
        }

        [XmlAttribute(AttributeName = "PlannedCloseDate")]
        public DateTime PlannedCloseDate
        {
            get
            {
                return _plannedclosedate;
            }
            set
            {
                _plannedclosedate = value;
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
        public List<ManagentReviewAction> Actions
        {
            get
            {
                return _actions;
            }
            set
            {
                _actions = value;
                this.XMLActions = serializeXML(value);
            }
        }
        
        [XmlAttribute(AttributeName = "XMLActions")]
        public string XMLActions
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
        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                if (obj is List<ManagentReviewAction>)
                {
                    serializer = new XmlSerializer(typeof(List<ManagentReviewAction>));

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