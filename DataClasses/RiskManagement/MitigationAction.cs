using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "MitigationAction")] 
    public class MitigationAction
    {
        private int _actionID;
        private string _mitigationtype;
        private string _potentialimpact;
        private string _countermeasures;
        private string _actions;
        private string _actionee;

        private bool _isclosed;
        
        private DateTime _targetclosedate;
        private DateTime? _actualclosedate;

        private RecordsStatus _status;

        public MitigationAction()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "ActionID")]
        public int ActionID
        {
            get
            {
                return _actionID;
            }
            set
            {
                _actionID = value;
            }
        }

        [XmlAttribute(AttributeName = "MitigationType")]
        public string MitigationType
        {
            get
            {
                return _mitigationtype;
            }
            set
            {
                _mitigationtype = value;
            }
        }

        [XmlAttribute(AttributeName = "PotentialImpact")]
        public string PotentialImpact
        {
            get
            {
                return _potentialimpact;
            }
            set
            {
                _potentialimpact = value;
            }
        }

        [XmlAttribute(AttributeName = "Countermeasures")]
        public string Countermeasures
        {
            get
            {
                return _countermeasures;
            }
            set
            {
                _countermeasures = value;
            }
        }

        [XmlAttribute(AttributeName = "Actions")]
        public string Actions
        {
            get
            {
                return _actions;
            }
            set
            {
                _actions = value;
            }
        }

        [XmlAttribute(AttributeName = "Actionee")]
        public string Actionee
        {
            get
            {
                return _actionee;
            }
            set
            {
                _actionee = value;
            }
        }

        [XmlAttribute(AttributeName = "TargetCloseDate")]
        public DateTime TargetCloseDate
        {
            get
            {
                return _targetclosedate;
            }
            set
            {
                _targetclosedate = value;
            }
        }

        [XmlElement(ElementName = "ActualCloseDate")]
        public DateTime? ActualCloseDate
        {
            get
            {
                return _actualclosedate;
            }
            set
            {
                _actualclosedate = value;

                if (value != null)
                {
                    this.IsClosed = true;
                }
            }
        }

        [XmlAttribute(AttributeName = "IsClosed")]
        public bool IsClosed
        {
            get
            {
                return _isclosed;
            }
            set
            {
                _isclosed = value;
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
