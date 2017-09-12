using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "ContractGroup")]
    public class ContractGroup
    {
        private int _groupID;
        private int _duration;
        
        private string _groupname;
        private string _description;
        private string _period;

        private bool _isconstraint;

        private RecordsStatus _status;

        [XmlAttribute(AttributeName = "GroupID")]
        public int GroupID
        {
            get
            {
                return _groupID;
            }
            set
            {
                _groupID = value;
            }
        }

        [XmlAttribute(AttributeName = "GroupName")]
        public string GroupName
        {
            get
            {
                return _groupname;
            }
            set
            {
                _groupname = value;
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
        [XmlAttribute(AttributeName = "Duration")]
        public int Duration
        {
            get
            {
                return _duration;
            }
            set
            {
                _duration = value;
            }
        }
        [XmlAttribute(AttributeName = "Period")]
        public string Period
        {
            get
            {
                return _period;
            }
            set
            {
                _period = value;
            }
        }
        [XmlAttribute(AttributeName = "IsConstraint")]
        public bool IsConstraint
        {
            get
            {
                return _isconstraint;
            }
            set
            {
                _isconstraint = value;
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