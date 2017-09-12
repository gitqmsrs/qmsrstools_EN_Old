using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;

namespace QMSRSTools
{
    [XmlType(TypeName = "Action")]   
    public class Action
    {
        private long _actionID;

        private string _title;
        private string _actiontype;
        private string _owner;
        private string _feedback;
        private string _description;
        private string _modulename;

        private bool _isclosed;

        private DateTime _startdate;
        private DateTime _plannedend;
        private DateTime? _actualclosedate;

        private RecordsStatus _status;
        private Modules _module;
       
        public Action()
        {
            this._status = RecordsStatus.ORIGINAL;
            this.Module = Modules.ProblemAction;
        }

        [XmlAttribute(AttributeName = "ActionID")]
        public long ActionID
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

        [XmlAttribute(AttributeName = "name")]
        public string name
        {
            get
            {
                return _title;
            }
            set
            {
                _title = value;
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
        [XmlAttribute(AttributeName = "ActioneeFeedback")]
        public string ActioneeFeedback
        {
            get
            {
                return _feedback;
            }
            set
            {
                _feedback = value;
            }
        }
        [XmlAttribute(AttributeName = "StartDate")]
        public DateTime StartDate
        {
            get
            {
                return _startdate;
            }
            set
            {
                _startdate = value;
            }
        }
        [XmlAttribute(AttributeName = "PlannedEndDate")]
        public DateTime PlannedEndDate
        {
            get
            {
                return _plannedend;
            }
            set
            {
                _plannedend = value;
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
        [XmlAttribute(AttributeName = "ActionType")]
        public string ActionType
        {
            get
            {
                return _actiontype;
            }
            set
            {
                _actiontype = value;
            }
        }
        [XmlAttribute(AttributeName = "Actionee")]
        public string Actionee
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

    }
}