using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "RiskCriteria")]
    public class RiskCriteria
    {
        private int _riskcriteriaID;
        private string _criteria;
        private string _description;
        private string _risktype;
        private RecordsStatus _status;

        public RiskCriteria()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "RiskCriteriaID")]
        public int RiskCriteriaID
        {
            get
            {
                return _riskcriteriaID;
            }
            set
            {
                _riskcriteriaID = value;
            }
        }

        [XmlAttribute(AttributeName = "Criteria")]
        public string Criteria
        {
            get
            {
                return _criteria;
            }
            set
            {
                _criteria = value;
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