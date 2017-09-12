using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.Web.Script.Serialization;
using System.IO;

namespace QMSRSTools
{
    [XmlType(TypeName = "Address")]
    public class Address
    {
        private int _addressID;
        
        private string _addressline1;
        private string _addressline2;
        private string _country;
        private string _city;
        private string _postalcode;
        private int _countryID;
        private int _stateID;
        private int _cityID;

        private List<Contact> _contacts;
        private string _jsoncontacts;

        private RecordsStatus _status;

        public Address()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "AddressID")]   
        public int AddressID
        {
            get
            {
                return _addressID;
            }
            set
            {
                _addressID = value;
            }
        }

        [XmlAttribute(AttributeName = "AddressLine1")]
        public string AddressLine1
        {
            get
            {
                return _addressline1;
            }
            set
            {
                _addressline1 = value;
            }
        }

        [XmlAttribute(AttributeName = "AddressLine2")]
        public string AddressLine2
        {
            get
            {
                return _addressline2;
            }
            set
            {
                _addressline2 = value;
            }
        }

        [XmlAttribute(AttributeName = "CountryID")]
        public int CountryID
        {
            get
            {
                return _countryID;
            }
            set
            {
                _countryID = value;
            }
        }

        [XmlAttribute(AttributeName = "Country")]
        public string Country
        {
            get
            {
                return _country;
            }
            set
            {
                _country = value;
            }
        }

        [XmlAttribute(AttributeName = "StateID")]
        public int StateID
        {
            get
            {
                return _stateID;
            }
            set
            {
                _stateID = value;
            }
        }
        [XmlAttribute(AttributeName = "CityID")]
        public int CityID
        {
            get
            {
                return _cityID;
            }
            set
            {
                _cityID = value;
            }
        }

        [XmlAttribute(AttributeName = "City")]
        public string City
        {
            get
            {
                return _city;
            }
            set
            {
                _city = value;
            }
        }

        [XmlAttribute(AttributeName = "PostalCode")]
        public string PostalCode
        {
            get
            {
                return _postalcode;
            }
            set
            {
                _postalcode = value;
            }
        }
        [XmlIgnore]
        public List<Contact> Contacts
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

        private string serializeToJSon(object obj)
        {
            string result = string.Empty;

            if (obj != null)
            {
                try
                {
                    if (obj is List<Contact>)
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