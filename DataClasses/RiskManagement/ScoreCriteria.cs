using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "ScoreCriteria")]
    public class ScoreCriteria
    {
        private int _scorecriteriaID;
        private string _description;
        private string _risktype;
        private string _comparator;
        private decimal _comparatorvalue;
        private int _rank;
        private RecordsStatus _status;

        public ScoreCriteria()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "ScoreCriteriaID")]
        public int ScoreCriteriaID
        {
            get
            {
                return _scorecriteriaID;
            }
            set
            {
                _scorecriteriaID = value;
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

        [XmlAttribute(AttributeName = "ComparatorValue")]
        public decimal ComparatorValue
        {
            get
            {
                return _comparatorvalue;
            }
            set
            {
                _comparatorvalue = value;
            }
        }

        [XmlAttribute(AttributeName = "Rank")]
        public int Rank
        {
            get
            {
                return _rank;
            }
            set
            {
                _rank = value;
            }
        }

        [XmlAttribute(AttributeName = "RiskType")]
        public string RiskType
        {
            get
            {
                return _risktype;
            }
            set
            {
                _risktype = value;
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