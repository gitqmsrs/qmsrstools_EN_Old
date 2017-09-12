using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMSRSTools
{
    public class Contact
    {
        private string _contactnumber;
        private string _contacttype;
        private int _contactID;
        private RecordsStatus _status;
      
        public Contact()
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