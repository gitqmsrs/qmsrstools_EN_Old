using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "StandardCost")]
    public class StandardCost
    {
        private int _stdcostID;
        private string _riskcriteria;
        private decimal _stdcost;
        private RecordsStatus _status;

        public StandardCost()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "STDCostID")]
        public int STDCostID
        {
            get
            {
                return _stdcostID;
            }
            set
            {
                _stdcostID = value;
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

        [XmlAttribute(AttributeName = "STDCost")]
        public decimal STDCost
        {
            get
            {
                return _stdcost;
            }
            set
            {
                _stdcost = value;
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