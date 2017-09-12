using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "CourseVenue")]
    public class CourseVenue
    {
        private int _venueID;
        
        private string _venuename;
        private string _addressline1;
        private string _addressline2;
        private string _country;
        private string _city;
        private string _website;
        private string _nameformat;

        private RecordsStatus _status;

        [XmlAttribute(AttributeName = "VenueID")]
        public int VenueID
        {
            get
            {
                return _venueID;
            }
            set
            {
                _venueID = value;
            }

        }
        
        [XmlAttribute(AttributeName = "VenueName")]
        public string VenueName
        {
            get
            {
                return _venuename;
            }
            set
            {
                _venuename = value;
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

        [XmlAttribute(AttributeName = "NameFormat")]
        public string NameFormat
        {
            get
            {
                return _nameformat;
            }
            set
            {
                _nameformat = value;
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