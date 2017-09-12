using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "Employee")]
    public class Employee
    {
        private int _employeeID;
        private string _personnelID;

        private DateTime _dob;
        private RecordsStatus _status;
        
        private List<Contract> _contracts;
        private List<Nationality> _nationalities;
        private List<ResidenceDocument> _residencedoc;
        private List<Address> _address;
        private List<Education> _education;
        private List<Dependant> _dependant;

        private string _xmlcontract;
        private string _xmladdress;
        private string _xmlresidence;
        private string _xmleducation;
        private string _xmldependant;

        private string _title;
        private string _firstname;
        private string _middlename;
        private string _lastname;
        private string _knownas;
        private string _nameformat;
        private string _completename;
        private string _cob;
        private string _religion;
        private string _gender;
        private string _marital;
        private string _emailaddress;
        private string _remarks;
        private string _empimg;
        
        public Employee()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "EmployeeID")]   
        public int EmployeeID
        {
            get
            {
                return _employeeID;
            }
            set
            {
                _employeeID = value;
            }
        }

        [XmlAttribute(AttributeName = "PersonnelID")]
        public string PersonnelID
        {
            get
            {
                return _personnelID;
            }
            set
            {
                _personnelID = value;
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
        [XmlAttribute(AttributeName = "CompleteName")]
        public string CompleteName
        {
            get
            {
                return _completename;
            }
            set
            {
                _completename = value;
            }
        }
        [XmlAttribute(AttributeName = "KnownAs")]
        public string KnownAs
        {
            get
            {
                return _knownas;
            }
            set
            {
                _knownas = value;
            }
        }
        [XmlAttribute(AttributeName = "DOB")]
        public DateTime DOB
        {
            get
            {
                return _dob;
            }
            set
            {
                _dob = value;
            }
        }
        [XmlAttribute(AttributeName = "COB")]
        public string COB
        {
            get
            {
                return _cob;
            }
            set
            {
                _cob = value;
            }
        }
        [XmlAttribute(AttributeName = "Religion")]
        public string Religion
        {
            get
            {
                return _religion;
            }
            set
            {
                _religion = value;
            }
        }
        [XmlAttribute(AttributeName = "Gender")]
        public string Gender
        {
            get
            {
                return _gender;
            }
            set
            {
                _gender = value;
            }
        }
        [XmlAttribute(AttributeName = "MaritalStatus")]
        public string MaritalStatus
        {
            get
            {
                return _marital;
            }
            set
            {
                _marital = value;
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
        [XmlAttribute(AttributeName = "Remarks")]
        public string Remarks
        {
            get
            {
                return _remarks;
            }
            set
            {
                _remarks = value;
            }
        }
        public string EMPImg
        {
            get
            {
                return _empimg;
            }
            set
            {
                _empimg = value;
            }
        }
        [XmlIgnore]
        public List<Contract> Contracts
        {
            get
            {
                return _contracts;
            }
            set
            {
                _contracts = value;

                this.XMLContract = serializeXML(value);
            }
        }

        [XmlAttribute(AttributeName = "XMLContract")]
        public string XMLContract
        {
            get
            {
                return _xmlcontract;
            }
            set
            {
                _xmlcontract = value;
            }
        }

        [XmlIgnore]
        public List<Dependant> Dependant
        {
            get
            {
                return _dependant;
            }
            set
            {
                _dependant = value;

                this.XMLDependant = serializeXML(value);
            }
        }

        [XmlAttribute(AttributeName = "XMLDependant")]
        public string XMLDependant
        {
            get
            {
                return _xmldependant;
            }
            set
            {
                _xmldependant = value;
            }
        }

        [XmlIgnore]
        public List<Nationality> Nationalities
        {
            get
            {
                return _nationalities;
            }
            set
            {
                _nationalities = value;
            }
        }
        [XmlIgnore]
        public List<ResidenceDocument> ResidenceDoc
        {
            get
            {
                return _residencedoc;
            }
            set
            {
                _residencedoc = value;
                this.XMLResidence = serializeXML(value);
            }
        }

        [XmlAttribute(AttributeName = "XMLResidence")]
        public string XMLResidence
        {
            get
            {
                return _xmlresidence;
            }
            set
            {
                _xmlresidence = value;
            }
        }

        [XmlIgnore]
        public List<Address> Address
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

        [XmlIgnore]
        public List<Education> Education
        {
            get
            {
                return _education;
            }
            set
            {
                _education = value;
                this.XMLEducation = serializeXML(value);
            }
        }

        [XmlAttribute(AttributeName = "XMLEducation")]
        public string XMLEducation
        {
            get
            {
                return _xmleducation;
            }
            set
            {
                _xmleducation = value;
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
                if (obj is List<Contract>)
                {
                    serializer = new XmlSerializer(typeof(List<Contract>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
                else if (obj is List<ResidenceDocument>)
                {
                    serializer = new XmlSerializer(typeof(List<ResidenceDocument>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
                else if (obj is List<Address>)
                {
                    serializer = new XmlSerializer(typeof(List<Address>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
                else if (obj is List<Education>)
                {
                    serializer = new XmlSerializer(typeof(List<Education>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
                else if (obj is List<Dependant>)
                {
                    serializer = new XmlSerializer(typeof(List<Dependant>));

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
    }
}