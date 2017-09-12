/*This class represents data of all asset calibration, asset maintenance, and asset eletrical test
 *Since they all have the same input
 */

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    
    [XmlType(TypeName = "AssetExtensions")]
    public class AssetExtensions
    {
        private long _extensionID;
        
        private string _extensionprovider;
        private string _currency;
        private string _purchaseordernumber;
        private string _actionneededorcomment;
        private string _resultstring;
        private string _modulename;

        private bool _trend;

        private decimal _extensioncost;
        
        private DateTime _extensiondate;
        private DateTime? _extensionduedate;

        private Result _result;

        private RecordsStatus _status;

        private Modules _module;

        public AssetExtensions()
        {
            this.Result = Result.PENDING;
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "ExtensionID")]
        public long ExtensionID
        {
            get
            {
                return _extensionID;
            }
            set
            {
                _extensionID = value;
            }
        }
        [XmlAttribute(AttributeName = "ExtensionProvider")]
        public string ExtensionProvider
        {
            get
            {
                return _extensionprovider;
            }
            set
            {
                _extensionprovider = value;
            }
        }
        [XmlAttribute(AttributeName = "PurchaseOrderNumber")]
        public string PurchaseOrderNumber
        {
            get
            {
                return _purchaseordernumber;
            }
            set
            {
                _purchaseordernumber = value;
            }
        }
        [XmlAttribute(AttributeName = "ActionNeededOrComment")]
        public string ActionNeededOrComment
        {
            get
            {
                return _actionneededorcomment;
            }
            set
            {
                _actionneededorcomment = value;
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
        [XmlAttribute(AttributeName = "ExtensionCost")]
        public decimal ExtensionCost
        {
            get
            {
                return _extensioncost;
            }
            set
            {
                _extensioncost = value;
            }

        }
        [XmlAttribute(AttributeName = "ExtensionDate")]
        public DateTime ExtensionDate
        {
            get
            {
                return _extensiondate;
            }
            set
            {
                _extensiondate = value;
            }
        }
        [XmlElement(ElementName = "ExtensionDueDate")]
        public DateTime? ExtensionDueDate
        {
            get
            {
                return _extensionduedate;
            }
            set
            {
                _extensionduedate = value;
            }
        }
        [XmlAttribute(AttributeName = "Trend")]
        public bool Trend
        {
            get
            {
                return _trend;
            }
            set
            {
                _trend = value;
            }
        }
        [XmlIgnore]
        public Result Result
        {
            get
            {
                return _result;
            }
            set
            {
                _result = value;
                this.ResultString = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ResultString")]
        public string ResultString
        {
            get
            {
                return _resultstring;
            }
            set
            {
                _resultstring = value;
            }
        }
        [XmlIgnore]
        public Modules Module
        {
            get
            {
                return _module;
            }
            set
            {
                _module = value;
                this.ModuleName = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ModuleName")]
        public string ModuleName
        {
            get
            {
                return _modulename;
            }
            set
            {
                _modulename = value;
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