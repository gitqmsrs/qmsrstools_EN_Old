using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "Education")]
    public class Education
    {
        private int _educationID;
        private string _degree;
        private string _awardtitle;
        private string _studymode;
        private string _institute;
        private string _faculty;
        private string _department;
        private string _gradesystem;
        private decimal _gradescore;
        private string _country;
        private string _city;
        private int _countryID;
        private int _stateID;
        private int _cityID;
 
        private DateTime _startdate;
        private DateTime? _enddate;

        private RecordsStatus _status;

        public Education()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }
        
        [XmlAttribute(AttributeName = "EducationID")]
        public int EducationID
        {
            get
            {
                return _educationID;
            }
            set
            {
                _educationID = value;
            }
        }

        [XmlAttribute(AttributeName = "Degree")]
        public string Degree
        {
            get
            {
                return _degree;
            }
            set
            {
                _degree = value;
            }
        }

        [XmlAttribute(AttributeName = "AwardTitle")]
        public string AwardTitle
        {
            get
            {
                return _awardtitle;
            }
            set
            {
                _awardtitle = value;
            }
        }

        [XmlAttribute(AttributeName = "StudyMode")]
        public string StudyMode
        {
            get
            {
                return _studymode;
            }
            set
            {
                _studymode = value;
            }
        }

        [XmlAttribute(AttributeName = "Institute")]
        public string Institute
        {
            get
            {
                return _institute;
            }
            set
            {
                _institute = value;
            }
        }

        [XmlAttribute(AttributeName = "StartDate")]
        public DateTime StartDate
        {
            get
            {
                return _startdate;
            }
            set
            {
                _startdate = value;
            }
        }

        [XmlElement(ElementName = "EndDate")]  
        public DateTime? EndDate
        {
            get
            {
                return _enddate;
            }
            set
            {
                _enddate = value;
            }
        }

        [XmlAttribute(AttributeName = "Faculty")]
        public string Faculty
        {
            get
            {
                return _faculty;
            }
            set
            {
                _faculty = value;
            }
        }

        [XmlAttribute(AttributeName = "Department")]
        public string Department
        {
            get
            {
                return _department;
            }
            set
            {
                _department = value;
            }
        }

        [XmlAttribute(AttributeName = "GradeSystem")]
        public string GradeSystem
        {
            get
            {
                return _gradesystem;
            }
            set
            {
                _gradesystem = value;
            }
        }

        [XmlAttribute(AttributeName = "Score")]
        public decimal Score
        {
            get
            {
                return _gradescore;
            }
            set
            {
                _gradescore = value;
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