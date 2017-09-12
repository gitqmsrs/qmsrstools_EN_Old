using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "Feedback")]
    public class Feedback
    {
        private string _question;
        private int _answervalue;

        private RecordsStatus _status;

        public Feedback()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "Question")]
        public string Question
        {
            get
            {
                return _question;
            }
            set
            {
                _question = value;
            }
        }

        [XmlAttribute(AttributeName = "AnswerValue")]
        public int AnswerValue
        {
            get
            {
                return _answervalue;
            }
            set
            {
                _answervalue = value;
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