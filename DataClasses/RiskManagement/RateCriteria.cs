using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "RateCriteria")]
    public class RateCriteria
    {
        private int _ratecriteriaID;
        private int _rate;
        private string _comparator;
        private string _description;
        private RecordsStatus _status;

        public RateCriteria()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "RateCriteriaID")]
        public int RateCriteriaID
        {
            get
            {
                return _ratecriteriaID;
            }
            set
            {
                _ratecriteriaID = value;
            }
        }

        [XmlAttribute(AttributeName = "Rate")]
        public int Rate
        {
            get
            {
                return _rate;
            }
            set
            {
                _rate = value;
            }
        }

        [XmlAttribute(AttributeName = "Comparator")]
        public string Comparator
        {
            get
            {
                return _comparator;
            }
            set
            {

                _comparator = value;
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