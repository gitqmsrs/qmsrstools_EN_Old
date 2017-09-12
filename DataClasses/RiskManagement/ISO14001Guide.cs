using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "ISO14001Guide")]
    public class ISO14001Guide
    {
        private int _guideID;
        private string _category;
        private string _guideline;
        private int _value;
        private decimal _score;

        private RecordsStatus _status;

        public ISO14001Guide()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "GuideID")]
        public int GuideID
        {
            get
            {
                return _guideID;
            }
            set
            {
                _guideID = value;
            }

        }

        [XmlAttribute(AttributeName = "Category")]
        public string Category
        {
            get
            {
                return _category;
            }
            set
            {
                _category = value;
            }
        }

        [XmlAttribute(AttributeName = "Guideline")]
        public string Guideline
        {
            get
            {
                return _guideline;
            }
            set
            {
                _guideline = value;
            }
        }

       
        [XmlAttribute(AttributeName = "Value")]
        public int Value
        {
            get
            {
                return _value;
            }
            set
            {
                _value = value;
            }
        }

        [XmlAttribute(AttributeName = "Score")]
        public decimal Score
        {
            get
            {
                return _score;
            }
            set
            {
                _score = value;
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