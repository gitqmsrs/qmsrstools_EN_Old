using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMSRSTools
{
    public class RiskParameter
    {
        private decimal _probability;
        private decimal _timeimpact;
        private decimal _costimpact;
        private decimal _qosimpact;
        private decimal _severity;
        private decimal _severityhuman;
        private decimal _severityenvironment;
        private decimal _complexity;

        public RiskParameter()
        {

        }

        public decimal Probability
        {
            get
            {
                return _probability;
            }
            set
            {
                _probability=value;
            }
        }

        public decimal TimeImpact
        {
            get
            {
                return _timeimpact;
            }
            set
            {
                _timeimpact = value;
            }

        }

        public decimal CostImpact
        {
            get
            {
                return _costimpact;
            }
            set
            {
                _costimpact = value;
            }
        }

        public decimal QOSImpact
        {
            get
            {
                return _qosimpact;
            }
            set
            {
                _qosimpact = value;
            }
        }

        public decimal Severity
        {
            get
            {
                return _severity;
            }
            set
            {
                _severity = value;
            }
        }

        public decimal SeverityHuman
        {
            get
            {
                return _severityhuman;
            }
            set
            {
                _severityhuman = value;
            }
        }

        public decimal SeverityEnvironment
        {
            get
            {
                return _severityenvironment;
            }
            set
            {
                _severityenvironment = value;
            }
        }

        public decimal Complexity
        {
            get
            {
                return _complexity;
            }
            set
            {
                _complexity = value;
            }
        }


    }
}