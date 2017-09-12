using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;

namespace QMSRSTools
{
    public enum AttendanceStatus
    {
        Attended = 1,
        Absent = 2,
        Undetermined = 3
    }

    [XmlType(TypeName = "Enroller")]
    public class Enroller
    {
        private string _employee;
        private string _otherneednotes;
        private string _specialneednotes;
        private string _entrollerlevel;
        private string _attendancestatus;
        private string _xmlfeedback;

        private bool _isvegetarian;
        private bool _isvegan;
        private bool _otherneeds;
        private bool _specialneeds;
        private bool _hasprovidedfeedback;

        private RecordsStatus _status;

        private List<Feedback> _feedback;

        public Enroller()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

      
        [XmlAttribute(AttributeName = "Enroller")]
        public string Employee
        {
            get
            {
                return _employee;
            }
            set
            {
                _employee = value;
            }
        }
        [XmlAttribute(AttributeName = "AttendanceStatus")]
        public string AttendanceStatus
        {
            get
            {
                return _attendancestatus;
            }
            set
            {
                _attendancestatus = value;
            }
        }
        [XmlAttribute(AttributeName = "IsVegetarian")]
        public bool IsVegetarian
        {
            get
            {
                return _isvegetarian;
            }
            set
            {
                _isvegetarian = value;
            }
        }
        [XmlAttribute(AttributeName = "IsVegan")]
        public bool IsVegan
        {
            get
            {
                return _isvegan;
            }
            set
            {
                _isvegan = value;
            }
        }
        [XmlAttribute(AttributeName = "HasProvidedFeedback")]
        public bool HasProvidedFeedback
        {
            get
            {
                return _hasprovidedfeedback;
            }
            set
            {
                _hasprovidedfeedback = value;
            }
        }
        [XmlAttribute(AttributeName = "OtherNeeds")]
        public bool OtherNeeds
        {
            get
            {
                return _otherneeds;
            }
            set
            {
                _otherneeds = value;
            }
        }
        [XmlAttribute(AttributeName = "SpecialNeeds")]
        public bool SpecialNeeds
        {
            get
            {
                return _specialneeds;
            }
            set
            {
                _specialneeds = value;
            }
        }
        [XmlAttribute(AttributeName = "EnrollerLevel")]
        public string EnrollerLevel
        {
            get
            {
                return _entrollerlevel;
            }
            set
            {
                _entrollerlevel = value;
            }
        }
        [XmlAttribute(AttributeName = "OtherNeedNotes")]
        public string OtherNeedNotes
        {
            get
            {
                return _otherneednotes;
            }
            set
            {
                _otherneednotes = value;
            }
        }

        [XmlAttribute(AttributeName = "SpecialNeedNotes")]
        public string SpecialNeedNotes
        {
            get
            {
                return _specialneednotes;
            }
            set
            {
                _specialneednotes = value;
            }
        }
        
        [XmlIgnore]
        public List<Feedback> FeedbackList
        {
            get
            {
                return _feedback;
            }
            set
            {
                _feedback = value;
                this.XMLFeedback = serializeXML(value);
            }
        }

        [XmlAttribute(AttributeName = "XMLFeedback")]
        public string XMLFeedback
        {
            get
            {
                return _xmlfeedback;
            }
            set
            {
                _xmlfeedback = value;
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
                    if (obj is List<Feedback>)
                    {
                        serializer = new XmlSerializer(typeof(List<Feedback>));
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