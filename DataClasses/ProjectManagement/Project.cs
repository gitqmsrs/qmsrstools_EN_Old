using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    public enum ProjectStatus
    {
        Dormant=1,
        Cancelled=2,
        Completed=3,
        None=4
    }
    [XmlType(TypeName = "Project")]
    public class Project
    {
        private int _projectID;
        
        private string _projectNo;
        private string _projectname;
        private string _description;
        private string _projectleader;
        private string _projectstatusstr;
        private string _currency;
 
        private decimal _projectvalue;
        private decimal _projectcost;
        private decimal _costatcompletion;
        
        private DateTime _startdate;
        private DateTime _plannedclosedate;
        private DateTime? _actualclosedate;

        private ProjectStatus _projectstatus;

        private RecordsStatus _status;

        public Project()
        {
            this.ProjectStatus = ProjectStatus.None;
            this.Status = RecordsStatus.ORIGINAL;
        }
        [XmlAttribute(AttributeName = "ProjectID")]
        public int ProjectID
        {
            get
            {
                return _projectID;
            }
            set
            {
                _projectID = value;
            }
        }
        [XmlAttribute(AttributeName = "ProjectNo")]
        public string ProjectNo
        {
            get
            {
                return _projectNo;
            }
            set
            {
                _projectNo = value;
            }
        }
        [XmlAttribute(AttributeName = "ProjectName")]
        public string ProjectName
        {
            get
            {
                return _projectname;
            }
            set
            {
                _projectname = value;
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
        [XmlAttribute(AttributeName = "ProjectLeader")]
        public string ProjectLeader
        {
            get
            { 
                return _projectleader;
            }
            set
            {
                _projectleader=value;
            }
        }
        [XmlAttribute(AttributeName = "Currency")]
        public string Currency
        {
            get
            {
                return _currency;
            }
            set
            {
                _currency = value;
            }
        }
        [XmlAttribute(AttributeName = "ProjectValue")]
        public decimal ProjectValue
        {
            get
            {
                return _projectvalue;
            }
            set
            {
                _projectvalue = value;
            }
        }
        [XmlAttribute(AttributeName = "ProjectCost")]
        public decimal ProjectCost
        {
            get
            {
                return _projectcost;
            }
            set
            {
                _projectcost = value;
            }
        }
        [XmlAttribute(AttributeName = "CostAtCompletion")]
        public decimal CostAtCompletion
        {
            get
            {
                return _costatcompletion;
            }
            set
            {
                _costatcompletion = value;
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
        [XmlAttribute(AttributeName = "PlannedCloseDate")]
        public DateTime PlannedCloseDate
        {
            get
            {
                return _plannedclosedate;
            }
            set
            {
                _plannedclosedate = value;
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
            }
        }
        [XmlIgnore]
        public ProjectStatus ProjectStatus
        {
            get
            {
                return _projectstatus;
            }
            set
            {
                _projectstatus = value;

                this.ProjectStatusStr = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ProjectStatus")]
        public string ProjectStatusStr
        {
            get
            {
                return _projectstatusstr;
            }
            set
            {
                _projectstatusstr = value;
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