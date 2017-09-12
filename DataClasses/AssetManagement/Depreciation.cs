using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "Depreciation")]
    
    public class Depreciation
    {
        private long _depreciationID;
        private decimal _depreciationamount;
        private decimal _accumulativedepreciation;
        private decimal _currentAssetValue;

        private DateTime _depreciationdate;
        
        private string _currency;
        
        private RecordsStatus _status;

        public Depreciation()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "DepreciationID")]
        public long DepreciationID
        {
            get
            {
                return _depreciationID;
            }
            set
            {
                _depreciationID = value;
            }
        }

        [XmlAttribute(AttributeName = "DepreciationAmount")]
        public decimal DepreciationAmount
        {
            get
            {
                return _depreciationamount;
            }
            set
            {
                _depreciationamount = value;
            }
        }

        [XmlAttribute(AttributeName = "DepreciationDate")]
        public DateTime DepreciationDate
        {
            get
            {
                return _depreciationdate;
            }
            set
            {
                _depreciationdate = value;
            }
        }
        [XmlAttribute(AttributeName = "Currency")]
        public string Currency
        {
            get
            {
                return _currency;
            }
            set
            {
                _currency = value;
            }
        }

        [XmlAttribute(AttributeName = "AccumulativeDepreciation")]
        public decimal AccumulativeDepreciation
        {
            get
            {
                return _accumulativedepreciation; 
            }
            set
            {
                _accumulativedepreciation = value;
            }
        }

        [XmlAttribute(AttributeName = "CurrentAssetValue")]
        public decimal CurrentAssetValue
        {
            get
            {
                return _currentAssetValue;
            }
            set
            {
                _currentAssetValue = value;
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