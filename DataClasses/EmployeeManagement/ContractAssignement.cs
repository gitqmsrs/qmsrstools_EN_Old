using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{

    [XmlType(TypeName = "ContractAssignement")]
    public class ContractAssignement
    {
        private int _assignmentID;
        private string _position;
        private DateTime _doa;
        private RecordsStatus _status;

        public ContractAssignement()
        {
            this.Status = RecordsStatus.ORIGINAL;
        
        }
        [XmlAttribute(AttributeName = "AssignmentID")]   
        public int AssignmentID
        {
            get
            {
                return _assignmentID;
            }
            set
            {
                _assignmentID = value;
            }
        }
        
        [XmlAttribute(AttributeName = "Position")] 
        public string Position
        {
            get
            {
                return _position;
            }
            set
            {
                _position = value;
            }
        }
        [XmlAttribute(AttributeName = "DOA")] 
        public DateTime DOA
        {
            get
            {
                return _doa;
            }
            set
            {
                _doa = value;
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