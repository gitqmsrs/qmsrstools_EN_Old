using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "ManagementReviewAction")]
    public class ManagentReviewAction
    {
        private int _actionID;

        private string _actiontype;
        private string _details;
        private string _followupcomments;
   
        private DateTime _targetclosingdate;
        private DateTime? _delayeddate;
        private DateTime? _completedate;

        private string _actionee;

        private RecordsStatus _status;
    
        private bool _isclosed;

        private Modules _module;

        private string _modulename;

        public ManagentReviewAction()
        {
            this._status = RecordsStatus.ORIGINAL;
            this.Module = Modules.ManagementReviewActions;
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
        [XmlAttribute(AttributeName = "ActionType")]
        public string ActionType
        {
            get
            {
                return _actiontype;
            }
            set
            {
                _actiontype= value;
            }
        }
        [XmlAttribute(AttributeName = "Details")]
        public string Details
        {
            get
            {
                return _details;
            }
            set
            {
                _details = value;
            }
        }
        [XmlAttribute(AttributeName = "FollowUpComments")]
        public string FollowUpComments
        {
            get
            {
                return _followupcomments;
            }
            set
            {
                _followupcomments = value;
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
        [XmlAttribute(AttributeName = "TargetClosingDate")]
        public DateTime TargetClosingDate
        {
            get
            {
                return _targetclosingdate;
            }
            set
            {
                _targetclosingdate = value;
            }
        }
        [XmlElement(ElementName = "DelayedDate")] 
        public DateTime? DelayedDate
        {
            get
            {
                return _delayeddate;
            }
            set
            {
                _delayeddate = value;
            }
        }
        [XmlElement(ElementName = "CompleteDate")] 
        public DateTime? CompleteDate
        {
            get
            {
                return _completedate;
            }
            set
            {
                _completedate = value;
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
        public Modules Module
        {
            get
            {
                return _module;
            }
            set
            {
                _module = value;
                this.ModuleName = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ModuleName")]
        public string ModuleName
        {
            get
            {
                return _modulename;
            }
            set
            {
                _modulename = value;
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