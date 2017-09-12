using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "Question")]
    public class Question
    {
        private long _questionID;
        private string _questiontxt;
        private string _questionmode;
        private RecordsStatus _status;

        public Question()
        {
            this.Status = RecordsStatus.ADDED;
        }

        [XmlAttribute(AttributeName = "QuestionID")]
        public long QuestionID
        {
            get
            {
                return _questionID;
            }
            set
            {
                _questionID = value;
            }
        }
        [XmlAttribute(AttributeName = "QuestionText")]
        public string QuestionText
        {
            get
            {
                return _questiontxt;
            }
            set
            {
                _questiontxt = value;
            }
        }
        [XmlAttribute(AttributeName = "QuestionMode")]
        public string QuestionMode
        {
            get
            {
                return _questionmode;
            }
            set
            {
                _questionmode = value;
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