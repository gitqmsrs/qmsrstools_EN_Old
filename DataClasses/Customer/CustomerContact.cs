using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Linq;

namespace QMSRSTools
{
    public class CustomerContact
    {
        private string _contactnumber;
        private string _contacttype;
        private int _contactID;
        private RecordsStatus _status;
      
        public CustomerContact()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }
        public int ContactID
        {
            get
            {
                return _contactID;
            }
            set
            {
                _contactID = value;
            }
        }
        public string Number
        {
            get
            {
                return _contactnumber;
            }
            set
            {
                _contactnumber = value;
            }
        }
        public string Type      
        {
            get
            {
                return _contacttype;
            }
            set
            {
                _contacttype = value;
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
