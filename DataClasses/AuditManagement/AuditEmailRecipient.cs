using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
namespace QMSRSTools
{
    public class AuditEmailRecipient
    {
        private string _employee;
    
        public string Employee
        {
            get
            {
                return _employee;
            }
            set
            {
                _employee = value;
            }
        }
    }
}