using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "GenericType")]
    public class GenericType
    {
        private int _typeid;
        private string _typename;
        private string _description;
        private RecordsStatus _status;

        public GenericType()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "TypeID")]
        public int TypeID
        {
            get
            {
                return _typeid;
            }
            set
            {
                _typeid = value;
            }
        }
        [XmlAttribute(AttributeName = "TypeName")]
        public string TypeName
        {
            get
            {
                return _typename;
            }
            set
            {
                _typename = value;
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