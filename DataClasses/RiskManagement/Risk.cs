using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;

namespace QMSRSTools
{
    public enum RiskType
    {
        ORI = 1,
        EMS = 3,
        OHSAS = 4,
        HACCP = 5
    }

    public enum RiskStatus
    {
        Open = 1,
        Closed = 2,
        Dormant = 3,
        Active = 4,
        Cancelled = 10
    }

    [XmlType(TypeName = "Risk")]
    public class Risk
    {
        private long _riskID;
        private string _riskNo;
        private string _riskname;
        private string _description;

        private RiskStatus _riskstatus;
        
        private string _riskmode;
        private string _riskcategory;
        private string _riskstatusstring;
        private string _risktype;
        private string _riskprobability;
        private string _severity;
        private string _project;
        private string _QOSimpact;
        private string _costimpact;
        private string _timeimpact;
        private string _costcentre1;
        private string _costcentre2;
        private string _owner;
        private string _limitsign;
        private string _modestring;
        private string _severityhuman;
        private string _severityenvironment;
        private string _operationalcomplexity;
        private string _regularity;
        private string _nusiance;
        private string _interestedparties;
        private string _lackinformation;
        private string _policyissue;
        private string _xmlactions;
        
        private DateTime _registerdate;
        private DateTime? _closuredate;
        private DateTime? _assesseddate;
        private DateTime? _duedate;

        private decimal _adjustedimpactcost;
        private decimal _criticallimit;
        private decimal _score;
        private decimal _sir;


        private List<MitigationAction> _actions;

        private RecordMode _mode;
        private RecordsStatus _status;

        public Risk()
        {
            this.Mode = RecordMode.Current;
            this.Status = RecordsStatus.ORIGINAL;
            this.RiskStatus = RiskStatus.Open;
        }

        [XmlAttribute(AttributeName = "RiskID")]
        public long RiskID
        {
            get
            {
                return _riskID;
            }
            set
            {
                _riskID = value;
            }
        }

        [XmlAttribute(AttributeName = "RiskNo")]
        public string RiskNo
        {
            get
            {
                return _riskNo;
            }
            set
            {
                _riskNo = value;
            }
        }

        [XmlAttribute(AttributeName = "RiskName")]
        public string RiskName
        {
            get
            {
                return _riskname;
            }
            set
            {
                _riskname = value;
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

        [XmlAttribute(AttributeName = "RiskMode")]
        public string RiskMode
        {
            get
            {
                return _riskmode;
            }
            set
            {
                _riskmode = value;
            }
        }

        [XmlAttribute(AttributeName = "RiskCategory")]
        public string RiskCategory
        {
            get
            {
                return _riskcategory;
            }
            set
            {
                _riskcategory = value;
            }
        }

        [XmlAttribute(AttributeName = "RiskProbability")]
        public string RiskProbability
        {
            get
            {
                return _riskprobability;
            }
            set
            {
                _riskprobability = value;
            }
        }

        [XmlAttribute(AttributeName = "Severity")]
        public string Severity
        {
            get
            {
                return _severity;
            }
            set
            {
                _severity = value;
            }
        }

        [XmlAttribute(AttributeName = "ProjectName")]
        public string ProjectName
        {
            get
            {
                return _project;
            }
            set
            {
                _project = value;
            }
        }

        [XmlAttribute(AttributeName = "QOSImpact")]
        public string QOSImpact
        {
            get
            {
                return _QOSimpact;
            }
            set
            {
                _QOSimpact = value;
            }
        }

        [XmlAttribute(AttributeName = "CostImpact")]
        public string CostImpact
        {
            get
            {
                return _costimpact;
            }
            set
            {
                _costimpact = value;
            }
        }

        [XmlAttribute(AttributeName = "TimeImpact")]
        public string TimeImpact
        {
            get
            {
                return _timeimpact;
            }
            set
            {
                _timeimpact = value;
            }
        }

        [XmlAttribute(AttributeName = "CostCentre1")]
        public string CostCentre1
        {
            get
            {
                return _costcentre1;
            }
            set
            {
                _costcentre1 = value;
            }
        }

        [XmlAttribute(AttributeName = "CostCentre2")]
        public string CostCentre2
        {
            get
            {
                return _costcentre2;
            }
            set
            {
                _costcentre2 = value;
            }
        }

        [XmlAttribute(AttributeName = "Owner")]
        public string Owner
        {
            get
            {
                return _owner;
            }
            set
            {
                _owner = value;
            }
        }

        [XmlAttribute(AttributeName = "LimitSign")]
        public string LimitSign
        {
            get
            {
                return _limitsign;
            }
            set
            {
                _limitsign = value;
            }
        }

        [XmlAttribute(AttributeName = "SeverityHuman")]
        public string SeverityHuman
        {
            get
            {
                return _severityhuman;
            }
            set
            {
                _severityhuman = value;
            }
        }

        [XmlAttribute(AttributeName = "SeverityEnvironment")]
        public string SeverityEnvironment
        {
            get
            {
                return _severityenvironment;
            }
            set
            {
                _severityenvironment = value;
            }
        }

        [XmlAttribute(AttributeName = "OperationalComplexity")]
        public string OperationalComplexity
        {
            get
            {
                return _operationalcomplexity;
            }
            set
            {
                _operationalcomplexity = value;
            }
        }

        [XmlAttribute(AttributeName = "Nusiance")]
        public string Nusiance
        {
            get
            {
                return _nusiance;
            }
            set
            {
                _nusiance = value;
            }
        }

        [XmlAttribute(AttributeName = "Regularity")]
        public string Regularity
        {
            get
            {
                return _regularity;
            }
            set
            {
                _regularity = value;
            }
        }

        [XmlAttribute(AttributeName = "InterestedParties")]
        public string InterestedParties
        {
            get
            {
                return _interestedparties;
            }
            set
            {
                _interestedparties = value;
            }
        }

        [XmlAttribute(AttributeName = "LackInformation")]
        public string LackInformation
        {
            get
            {
                return _lackinformation;
            }
            set
            {
                _lackinformation = value;
            }
        }

        [XmlAttribute(AttributeName = "PolicyIssue")]
        public string PolicyIssue
        {
            get
            {
                return _policyissue;
            }
            set
            {
                _policyissue = value;
            }
        }

        [XmlAttribute(AttributeName = "RegisterDate")]
        public DateTime RegisterDate
        {
            get
            {
                return _registerdate;
            }
            set
            {
                _registerdate = value;
            }
        }

        [XmlElement(ElementName = "ClosureDate")] 
        public DateTime? ClosureDate
        {
            get
            {
                return _closuredate;
            }
            set
            {
                _closuredate = value;
            }
        }

        [XmlElement(ElementName = "AssessedDate")] 
        public DateTime? AssessedDate
        {
            get
            {
                return _assesseddate;
            }
            set
            {
                _assesseddate = value;
            }
        }


        [XmlElement(ElementName = "DueDate")] 
        public DateTime? DueDate
        {
            get
            {
                return _duedate;
            }
            set
            {
                _duedate = value;
            }
        }

        [XmlAttribute(AttributeName = "AdjustedCostImpact")]
        public decimal AdjustedCostImpact
        {
            get
            {
                return _adjustedimpactcost;
            }
            set
            {
                _adjustedimpactcost = value;
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

        [XmlAttribute(AttributeName = "CriticalLimit")]
        public decimal CriticalLimit
        {
            get
            {
                return _criticallimit;
            }
            set
            {
                _criticallimit = value;
            }
        }

        [XmlAttribute(AttributeName = "SIR")]
        public decimal SIR
        {
            get
            {
                return _sir;
            }
            set
            {
                _sir = value;
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
        public RiskStatus RiskStatus
        {
            get
            {
                return _riskstatus;
            }
            set
            {
                _riskstatus = value;
                this.RiskStatusString = value.ToString();
            }
        }

        [XmlAttribute(AttributeName = "RiskStatusString")]
        public string RiskStatusString
        {
            get
            {
                return _riskstatusstring;
            }
            set
            {
                _riskstatusstring = value;
            }
        }

        [XmlIgnore]
        public RecordMode Mode
        {
            get
            {
                return _mode;
            }
            set
            {
                _mode = value;
                this.ModeString = value.ToString();
            }
        }

        [XmlAttribute(AttributeName = "ModeString")]
        public string ModeString
        {
            get
            {
                return _modestring;
            }
            set
            {
                _modestring = value;
            }
        }

        [XmlIgnore]
        public List<MitigationAction> Actions
        {
            get
            {
                return _actions;
            }
            set
            {
                _actions = value;
                this.XMLActions = serializeXML(value);
            }
        }

        [XmlAttribute(AttributeName = "Actions")]
        public string XMLActions
        {
            get
            {
                return _xmlactions;
            }
            set
            {
                _xmlactions = value;
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

        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                try
                {
                    if (obj is List<MitigationAction>)
                    {
                        serializer = new XmlSerializer(typeof(List<MitigationAction>));
                        writer = new StringWriter();
                        serializer.Serialize(writer, obj);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.InnerException.Message);
                }
            }
            else
            {
                writer = new StringWriter();
            }
            return writer.ToString();
        }

    }

}