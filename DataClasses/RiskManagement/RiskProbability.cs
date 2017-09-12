using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "RiskProbability")]
    public class RiskProbability
    {
        private long _riskprobabilityID;
        private decimal _probability;
        private string _criteria;
        private RecordsStatus _status;

        public RiskProbability()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "RiskProbabilityID")]
        public long RiskProbabilityID
        {
            get
            {
                return _riskprobabilityID;
            }
            set
            {
                _riskprobabilityID = value;
            }
        }

       
        [XmlAttribute(AttributeName = "Probability")]
        public decimal Probability        
        {
            get
            {
                return _probability;
            }
            set
            {
                _probability = value;
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