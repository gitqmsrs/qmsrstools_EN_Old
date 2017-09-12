using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "CostCentre")]
    public class CostCentre
    {
        private int _costcentreID;
        private string _costcentreno;
        private string _costcentrename;
        private string _unit;
        private string _manager;
        private RecordsStatus _status;

        public CostCentre()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "CostCentreID")]
        public int CostCentreID
        {
            get
            {
                return _costcentreID;
            }
            set
            {
                _costcentreID = value;
            }
        }

        [XmlAttribute(AttributeName = "CostCentreNo")]
        public string CostCentreNo
        {
            get
            {
                return _costcentreno;
            }
            set
            {
                _costcentreno = value;
            }
        }

        [XmlAttribute(AttributeName = "CostCentreName")]
        public string CostCentreName
        {
            get
            {
                return _costcentrename;
            }
            set
            {
                _costcentrename = value;
            }
        }

        [XmlAttribute(AttributeName = "ORGUnit")]
        public string ORGUnit
        {
            get
            {
                return _unit;
            }
            set
            {
                _unit = value;
            }
        }

        [XmlAttribute(AttributeName = "Manager")]
        public string Manager
        {
            get
            {
                return _manager;
            }
            set
            {
                _manager = value;
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