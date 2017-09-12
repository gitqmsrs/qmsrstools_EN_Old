using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Linq;
using System.Collections.Generic;
using System.Web.Script.Serialization;
using System.IO;

namespace QMSRSTools
{
    [XmlType(TypeName = "Customer")]
    public class Customer
    {
        private int _customerID;
        private string _customerno;
        private string _name;
        private string _contactperson;
        private string _emailaddress;
        private string _website;
        private string _customertype;
        private string _xmladdress;
        private string _jsoncontacts;

        private RecordsStatus _status;
        private CustomerAddress _address;
        private List<CustomerContact> _contacts;
       
        public Customer()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "CustomerID")]
        public int CustomerID
        {
            get
            {
                return _customerID;
            }
            set
            {
                _customerID = value;
            }
        }

        [XmlAttribute(AttributeName = "CustomerType")]
        public string CustomerType
        {
            get
            {
                return _customertype;
            }
            set
            {
                _customertype = value;
            }
        }

        [XmlAttribute(AttributeName = "CustomerName")]
        public string CustomerName
        {
            get
            {
                return _name;
            }
            set
            {
                _name = value;
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

        [XmlAttribute(AttributeName = "CustomerNo")]
        public string CustomerNo
        {
            get
            {
                return _customerno;
            }
            set
            {
                _customerno = value;
            }
        }

        [XmlAttribute(AttributeName = "ContactPerson")]
        public string ContactPerson
        {
            get
            {
                return _contactperson;
            }
            set
            {
                _contactperson = value;
            }
        }

        [XmlAttribute(AttributeName = "EmailAddress")]
        public string EmailAddress
        {
            get
            {
                return _emailaddress;
            }
            set
            {
                _emailaddress = value;
            }
        }

        [XmlAttribute(AttributeName = "Website")]
        public string Website
        {
            get
            {
                return _website;
            }
            set
            {
                _website = value;
            }
        }

        public CustomerAddress Address
        {
            get
            {
                return _address;
            }
            set
            {
                _address = value;
                this.XMLAddress = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "XMLAddress")]
        public string XMLAddress
        {
            get
            {
                return _xmladdress;
            }
            set
            {
                _xmladdress = value;
            }
        }
        public List<CustomerContact> Contacts
        {
            get
            {
                return _contacts;
            }
            set
            {
                _contacts = value;

                this.JSONContacts = serializeToJSon(value);
            }
        }
        [XmlAttribute(AttributeName = "JSONContacts")]
        public string JSONContacts
        {
            get
            {
                return _jsoncontacts;
            }
            set
            {
                _jsoncontacts = value;
            }
        }

        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                if (obj is CustomerAddress)
                {
                    serializer = new XmlSerializer(typeof(CustomerAddress));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }

            }
            else
            {
                writer = new StringWriter();
            }
            return writer.ToString();
        }

        private string serializeToJSon(object obj)
        {
            string result = string.Empty;

            if (obj != null)
            {
                try
                {
                    if (obj is List<CustomerContact>)
                    {
                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        result = serializer.Serialize(obj);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.InnerException.Message);
                }
            }
            return result;
        }
    }
}