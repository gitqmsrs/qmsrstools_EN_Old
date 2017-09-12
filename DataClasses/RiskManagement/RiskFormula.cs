using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "RiskFormula")]
    public class RiskFormula
    {
        private int _formulaID;
        private string _formula;
        private string _risktype;

        private RecordsStatus _status;


        public RiskFormula()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "FormulaID")]
        public int FormulaID
        {
            get
            {
                return _formulaID;
            }
            set
            {
                _formulaID = value;
            }
        }

        [XmlAttribute(AttributeName = "Formula")]
        public string Formula
        {
            get
            {
                return _formula;
            }
            set
            {
                _formula = value;
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