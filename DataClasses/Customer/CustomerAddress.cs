using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Linq;
using System.Collections.Generic;
namespace QMSRSTools
{
    [XmlType(TypeName = "CustomerAddress")]
    public class CustomerAddress
    {
        private int _addressID;
        private string _address1;
        private string _address2;
        private string _country;
        private string _city;
        private string _postcode;
        private int _countryID;
        private int _stateID;
        private int _cityID;

        private RecordsStatus _status;
       
        public CustomerAddress()
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
                return _address1;
            }
            set
            {
                _address1 = value;
            }
        }
        [XmlAttribute(AttributeName = "AddressLine2")]
        public string AddressLine2
        {
            get
            {
                return _address2;
            }
            set
            {
                _address2 = value;
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
                return _postcode;
            }
            set
            {
                _postcode = value;
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