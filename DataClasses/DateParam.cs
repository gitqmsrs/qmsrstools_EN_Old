using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;


namespace QMSRSTools
{
    public class DateParam
    {
        private DateTime _startdate;
        private DateTime _enddate;

        public DateParam()
        {

        }

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

        public DateTime EndDate
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
    }
}