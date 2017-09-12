using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
namespace QMSRSTools
{
    public enum UserType
    {
        System = 1,
        Employee = 2
    }

    [XmlType(TypeName = "Users")]
    public class Users
    {
        private int _userID;
        private string _employee;
        private string _password;
        private string _username;
        private string _accounttype;
        private string _permissionstr;

        private List<Permission> _permissions;

        private RecordsStatus _status;

        public Users()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "UserID")]
        public int UserID
        {
            get
            {
                return _userID;
            }
            set
            {
                _userID = value;
            }
        }
        [XmlAttribute(AttributeName = "Employee")]
        public string Employee
        {
            get
            {
                return _employee;
            }
            set
            {
                _employee = value;
            }
        }
        [XmlAttribute(AttributeName = "UserName")]
        public string UserName
        {
            get
            {
                return _username;
            }
            set
            {
                _username = value;
            }
        }
        [XmlAttribute(AttributeName = "AccountType")]
        public string AccountType
        {
            get
            {
                return _accounttype;
            }
            set
            {
                _accounttype = value;
            }
        }
        [XmlIgnore]
        public string Password
        {
            get
            {
                return _password;
            }
            set
            {
                _password = value;
            }
        }
        [XmlIgnore]
        public List<Permission> Permissions
        {
            get
            {
                return _permissions;
            }
            set
            {
                _permissions = value;

                this.PermissionsString = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "PermissionsString")]
        public string PermissionsString
        {
            get
            {
                return _permissionstr;
            }
            set
            {
                _permissionstr = value;
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
                    if (obj is List<Permission>)
                    {
                        serializer = new XmlSerializer(typeof(List<Permission>));
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