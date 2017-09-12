using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "TaskActionType")]
    public class TaskActionType
    {
        private long _typeID;
        private string _type;
        private string _description;
        private RecordsStatus _status;

        public TaskActionType()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }
        [XmlAttribute(AttributeName = "TypeID")]
        public long TypeID
        {
            get
            {
                return _typeID;
            }
            set
            {
                _typeID = value;
            }
        }
        [XmlAttribute(AttributeName = "TypeName")]
        public string TypeName
        {
            get
            {
                return _type;
            }
            set
            {
                _type = value;
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