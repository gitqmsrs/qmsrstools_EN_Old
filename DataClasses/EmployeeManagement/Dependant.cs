using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    public class Dependant
    {
        private int _dependantID;

        private string _title;
        private string _firstname;
        private string _middlename;
        private string _lastname;
        private string _relation;

        private DateTime _dateofbirth;

        private RecordsStatus _status;
        
        public Dependant()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "DependantID")]
        public int DependantID
        {
            get
            {
                return _dependantID;
            }
            set
            {
                _dependantID = value;
            }
        }
        [XmlAttribute(AttributeName = "Title")]
        public string Title
        {
            get
            {
                return _title;
            }
            set
            {
                _title = value;
            }
        }
        [XmlAttribute(AttributeName = "FirstName")]
        public string FirstName
        {
            get
            {
                return _firstname;
            }
            set
            {
                _firstname = value;
            }
        }
        [XmlAttribute(AttributeName = "MiddleName")]
        public string MiddleName
        {
            get
            {
                return _middlename;
            }
            set
            {
                _middlename = value;
            }
        }
        [XmlAttribute(AttributeName = "LastName")]
        public string LastName
        {
            get
            {
                return _lastname;
            }
            set
            {
                _lastname = value;
            }
        }
        [XmlAttribute(AttributeName = "Relation")]
        public string Relation
        {
            get
            {
                return _relation;
            }
            set
            {
                _relation = value;
            }
        }
        [XmlAttribute(AttributeName = "DateOfBirth")]
        public DateTime DateOfBirth
        {
            get
            {
                return _dateofbirth;
            }
            set
            {
                _dateofbirth = value;
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