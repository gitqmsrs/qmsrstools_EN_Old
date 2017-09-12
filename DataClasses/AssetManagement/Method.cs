using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "Method")]
    public class Method
    {
        private long _methodID;
        private string _methodname;
        private string _description;
        private RecordsStatus _status;

        public Method()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "MethodID")]
        public long MethodID
        {
            get
            {
                return _methodID;
            }
            set
            {
                _methodID = value;
            }
        }
        [XmlAttribute(AttributeName = "MethodName")]
        public string MethodName
        {
            get
            {
                return _methodname;
            }
            set
            {
                _methodname = value;
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