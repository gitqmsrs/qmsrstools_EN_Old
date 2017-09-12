using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    public enum ImpactType
    {
        Cost = 1,
        Time = 2,
        QOS = 3
    }


    [XmlType(TypeName = "Impact")]
    public class Impact
    {
        private int _impactID;
        private ImpactType _impacttype;
        private string _description1;
        private string _description2;
        private string _riskcriteria;

        private RecordsStatus _status;

        public Impact()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "ImpactID")]
        public int ImpactID
        {
            get
            {
                return _impactID;
            }
            set
            {
                _impactID = value;
            }
        }

        [XmlIgnore]
        public ImpactType ImpactType
        {
            get
            {
                return _impacttype;
            }
            set
            {
                _impacttype = value;
            }
        }

        [XmlAttribute(AttributeName = "Description1")]
        public string Description1
        {
            get
            {
                return _description1;
            }
            set
            {

                _description1 = value;
            }
        }

        [XmlAttribute(AttributeName = "Description2")]
        public string Description2
        {
            get
            {
                return _description2;
            }
            set
            {

                _description2 = value;
            }
        }

        [XmlAttribute(AttributeName = "RiskCriteria")]
        public string RiskCriteria
        {
            get
            {
                return _riskcriteria;
            }
            set
            {
                _riskcriteria = value;
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