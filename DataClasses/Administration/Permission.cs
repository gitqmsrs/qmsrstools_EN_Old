using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "Permission")]
    public class Permission
    {
        private int _keyID;
        private string _key;
        private RecordsStatus _status;

        public Permission()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }
        [XmlAttribute(AttributeName = "KeyID")]
        public int KeyID
        {
            get
            {
                return _keyID;
            }
            set
            {
                _keyID = value;
            }
        }
        [XmlAttribute(AttributeName = "Key")]
        public string Key
        {
            get
            {
                return _key;
            }
            set
            {
                _key = value;
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