using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
namespace QMSRSTools
{
    [XmlType(TypeName = "CourseSchedule")]
    public class CourseSchedule
    {
        private int _scheduleID;

        private DateTime _sessiondate;
   
        private string _starttime;
        private string _endtime;

        private string _instructortype;
        private string _externalinstructor;
        private string _internalinstructor;


        private string _venue;
       
        private RecordsStatus _status;

        [XmlAttribute(AttributeName = "ScheduleID")]
        public int ScheduleID
        {
            get
            {
                return _scheduleID;
            }
            set
            {
                _scheduleID = value;
            }
        }

        [XmlAttribute(AttributeName = "StartTime")]
        public string StartTime
        {
            get
            {
                return _starttime;
            }
            set
            {
                _starttime = value;
            }
        }

        [XmlAttribute(AttributeName = "EndTime")]
        public string EndTime
        {
            get
            {
                return _endtime;
            }
            set
            {
                _endtime = value;
            }
        }

        [XmlAttribute(AttributeName = "SessionDate")]
        public DateTime SessionDate
        {
            get
            {
                return _sessiondate;
            }
            set
            {
                _sessiondate = value;
            }
        }

        [XmlAttribute(AttributeName = "IntructorType")]
        public string IntructorType
        {
            get
            {
                return _instructortype;
            }
            set
            {
                _instructortype = value;
            }
        }
        [XmlAttribute(AttributeName = "ExternalIntructor")]
        public string ExternalIntructor
        {
            get
            {
                return _externalinstructor;
            }
            set
            {
                _externalinstructor = value;
            }
        }
        [XmlAttribute(AttributeName = "InternalIntructor")]
        public string InternalIntructor
        {
            get
            {
                return _internalinstructor;
            }
            set
            {
                _internalinstructor = value;
            }
        }
        [XmlAttribute(AttributeName = "Venue")]
        public string Venue
        {
            get
            {
                return _venue;
            }
            set
            {
                _venue = value;
                
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