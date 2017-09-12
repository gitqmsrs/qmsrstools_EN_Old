using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;

namespace QMSRSTools
{
    public enum Result
    {
        PASS = 1,
        FAIL = 2,
        PENDING = 3
    }

    [XmlType(TypeName = "Asset")]
    public class Asset
    {
        private long _assetID;
        
        private string _tag;
        private string _othertag;
        private string _description;
        private string _serialno;
        private string _barcode;
        private string _model;
        private string _assetcategory;
        private string _supplier;
        private string _owner;
        private string _anotherowner;
        private string _externalowner;
        private string _department;
        private string _currency;
        private string _depreciationmethod;
        private string _assetstatus;
        private string _remarks;
        private string _costcentre;
        private string _othercostcentre;
        private string _acquisitionmethod;
        private string _billingcategory;
        private string _accountingcode;
        private string _retirement;
        private string _retirementremarks;
        private string _externalpurchaseorder;
        private string _manufacturer;
        private string _calibrationperiod;
        private string _calibrationstatus;
        private string _calibrationdocument;
        private string _maintenanceperiod;
        private string _maintenancedocument;
        private string _maintenancestatus;
        private string _electricalteststatus;
        private string _electricaltestdocument;
        private string _electricaltestperiod;
        private string _workrequestno;
        private string _floorno;
        private string _roomno;
        private string _modestring;

        private string _depreciableperiod;
      

        private decimal _purchaseprice;
        private decimal _currentvalue;

        private int _depreciablelife;
        private int _calibrationfreq;
        private int _maintenancefreq;
        private int _electricaltestfreq;

        private bool _isbillable;
        private bool _hascalibration;
        private bool _hasmaintenance;
        private bool _haselectricaltest;

        private DateTime _purchasedate;
        private DateTime _installationdate;
        private DateTime _acquisitiondate;
        private DateTime? _disposaldate;
        private DateTime? _maintenancedate;
        private DateTime? _maintenanceduedate;
        private DateTime? _electricaltestdate;
        private DateTime? _electricaltestduedate;

        private List<Depreciation> _depreciationlist;
        private List<AssetExtensions> _calibrationlist;
        private List<AssetExtensions> _maintenancelist;
        private List<AssetExtensions> _electricaltestlist;

        private string _xmldepreciation;
        private string _xmlcalibration;
        private string _xmlmaintenance;
        private string _xmlelectrical;

        private RecordsStatus _status;
        private RecordMode _mode;
        public Asset()
        {
            this.Status = RecordsStatus.ORIGINAL;
            this.Mode = RecordMode.Current;

        }
        [XmlAttribute(AttributeName = "AssetID")]
        public long AssetID
        {
            get
            {
                return _assetID;
            }
            set
            {
                _assetID = value;
            }
        }
        [XmlAttribute(AttributeName = "TAG")]
        public string TAG
        {
            get
            {
                return _tag;
            }
            set
            {
                _tag = value;
            }
        }
        [XmlAttribute(AttributeName = "OtherTAG")]
        public string OtherTAG
        {
            get
            {
                return _othertag;
            }
            set
            {
                _othertag = value;
            }
        }
        [XmlAttribute(AttributeName = "SerialNo")]
        public string SerialNo
        {
            get
            {
                return _serialno;
            }
            set
            {
                _serialno = value;
            }
        }
        [XmlAttribute(AttributeName = "BARCode")]
        public string BARCode
        {
            get
            {
                return _barcode;
            }
            set
            {
                _barcode = value;
            }
        }
        [XmlAttribute(AttributeName = "Model")]
        public string Model
        {
            get
            {
                return _model;
            }
            set
            {
                _model = value;
            }
        }
        [XmlAttribute(AttributeName = "Description")]
        public string Description
        {
            get
            {
                return _description;
            }
            set
            {
                _description = value;
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
        [XmlAttribute(AttributeName = "AssetCategory")]
        public string AssetCategory
        {
            get
            {
                return _assetcategory;
            }
            set
            {
                _assetcategory = value;
            }
        }
        [XmlAttribute(AttributeName = "Supplier")]
        public string Supplier
        {
            get
            {
                return _supplier;
            }
            set
            {
                _supplier = value;
            }
        }
        [XmlAttribute(AttributeName = "Owner")]
        public string Owner
        {
            get
            {
                return _owner;
            }
            set
            {
                _owner = value;
            }
        }
        [XmlAttribute(AttributeName = "AnotherOwner")]
        public string AnotherOwner
        {
            get
            {
                return _anotherowner;
            }
            set
            {
                _anotherowner = value;
            }
        }
        [XmlAttribute(AttributeName = "ExternalOwner")]
        public string ExternalOwner
        {
            get
            {
                return _externalowner;
            }
            set
            {
                _externalowner = value;
            }
        }
        [XmlAttribute(AttributeName = "Department")]
        public string Department
        {
            get
            {
                return _department;
            }
            set
            {
                _department = value;
            }
        }
        [XmlAttribute(AttributeName = "FloorNo")]
        public string FloorNo
        {
            get
            {
                return _floorno;
            }
            set
            {
                _floorno = value;
            }
        }

        [XmlAttribute(AttributeName = "RoomNo")]
        public string RoomNo
        {
            get
            {
                return _roomno;
            }
            set
            {
                _roomno = value;
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
        [XmlAttribute(AttributeName = "DepreciationMethod")]
        public string DepreciationMethod
        {
            get
            {
                return _depreciationmethod;
            }
            set
            {
                _depreciationmethod = value;
            }
        }
        [XmlAttribute(AttributeName = "AssetStatus")]
        public string AssetStatus
        {
            get
            {
                return _assetstatus;
            }
            set
            {
                _assetstatus = value;
            }
        }
        [XmlAttribute(AttributeName = "WorkRequestNO")]
        public string WorkRequestNO
        {
            get
            {
                return _workrequestno;
            }
            set
            {
                _workrequestno = value;
            }
        }
        [XmlAttribute(AttributeName = "CostCentre")]
        public string CostCentre
        {
            get
            {
                return _costcentre;
            }
            set
            {
                _costcentre = value;
            }
        }
        [XmlAttribute(AttributeName = "OtherCostCentre")]
        public string OtherCostCentre
        {
            get
            {
                return _othercostcentre;
            }
            set
            {
                _othercostcentre = value;
            }
        }
        [XmlAttribute(AttributeName = "AcquisitionMethod")]
        public string AcquisitionMethod
        {
            get
            {
                return _acquisitionmethod;
            }
            set
            {
                _acquisitionmethod = value;
            }
        }
        [XmlAttribute(AttributeName = "BillingCategory")]
        public string BillingCategory
        {
            get
            {
                return _billingcategory;
            }
            set
            {
                _billingcategory = value;
            }
        }
        [XmlAttribute(AttributeName = "AccountingCode")]
        public string AccountingCode
        {
            get
            {
                return _accountingcode;
            }
            set
            {
                _accountingcode = value;
            }
        }
        [XmlAttribute(AttributeName = "Retirement")]
        public string Retirement
        {
            get
            {
                return _retirement;
            }
            set
            {
                _retirement = value;
            }
        }
        [XmlAttribute(AttributeName = "RetirementRemarks")]
        public string RetirementRemarks
        {
            get
            {
                return _retirementremarks;
            }
            set
            {
                _retirementremarks = value;
            }
        }
        [XmlAttribute(AttributeName = "ExternalPurchaseOrder")]
        public string ExternalPurchaseOrder
        {
            get
            {
                return _externalpurchaseorder;
            }
            set
            {
                _externalpurchaseorder = value;
            }
        }
        [XmlAttribute(AttributeName = "Manufacturer")]
        public string Manufacturer
        {
            get
            {
                return _manufacturer;
            }
            set
            {
                _manufacturer = value;
            }
        }
        [XmlAttribute(AttributeName = "CalibrationStatus")]
        public string CalibrationStatus
        {
            get
            {
                return _calibrationstatus;
            }
            set
            {
                _calibrationstatus = value;
            }
        }
        [XmlAttribute(AttributeName = "CalibrationDocument")]
        public string CalibrationDocument
        {
            get
            {
                return _calibrationdocument;
            }
            set
            {
                _calibrationdocument = value;
            }
        }
        [XmlAttribute(AttributeName = "CalibrationPeriod")]
        public string CalibrationPeriod
        {
            get
            {
                return _calibrationperiod;
            }
            set
            {
                _calibrationperiod = value;
            }
        }
        [XmlAttribute(AttributeName = "MaintenanceStatus")]
        public string MaintenanceStatus
        {
            get
            {
                return _maintenancestatus;
            }
            set
            {
                _maintenancestatus = value;
            }
        }
        [XmlAttribute(AttributeName = "MaintenanceDocument")]
        public string MaintenanceDocument
        {
            get
            {
                return _maintenancedocument;
            }
            set
            {
                _maintenancedocument = value;
            }
        }
        [XmlAttribute(AttributeName = "MaintenancePeriod")]
        public string MaintenancePeriod
        {
            get
            {
                return _maintenanceperiod;
            }
            set
            {
                _maintenanceperiod = value;
            }
        }
        [XmlAttribute(AttributeName = "ElectricalTestStatus")]
        public string ElectricalTestStatus
        {
            get
            {
                return _electricalteststatus;
            }
            set
            {
                _electricalteststatus = value;
            }
        }
        [XmlAttribute(AttributeName = "ElectricalTestDocument")]
        public string ElectricalTestDocument
        {
            get
            {
                return _electricaltestdocument;
            }
            set
            {
                _electricaltestdocument = value;
            }
        }
        [XmlAttribute(AttributeName = "ElectricalTestPeriod")]
        public string ElectricalTestPeriod
        {
            get
            {
                return _electricaltestperiod;
            }
            set
            {
                _electricaltestperiod = value;
            }
        }
        [XmlAttribute(AttributeName = "DepreciablePeriod")]
        public string DepreciablePeriod
        {
            get
            {
                return _depreciableperiod;
            }
            set
            {
                _depreciableperiod = value;
            }
        }
        [XmlAttribute(AttributeName = "PurchasePrice")]
        public decimal PurchasePrice
        {
            get
            {
                return _purchaseprice;
            }
            set
            {
                _purchaseprice = value;
                this.CurrentValue = value;
            }
        }

        [XmlAttribute(AttributeName = "CurrentValue")]
        public decimal CurrentValue
        {
            get
            {
                return _currentvalue;
            }
            set
            {
                _currentvalue = value;
            }
        }
        [XmlAttribute(AttributeName = "DepreciableLife")]
        public int DepreciableLife
        {
            get
            {
                return _depreciablelife;
            }
            set
            {
                _depreciablelife = value;
            }
        }
        [XmlAttribute(AttributeName = "MaintenanceFrequency")]
        public int MaintenanceFrequency
        {
            get
            {
                return _maintenancefreq;
            }
            set
            {
                _maintenancefreq = value;
            }
        }
        [XmlAttribute(AttributeName = "CalibrationFrequency")]
        public int CalibrationFrequency
        {
            get
            {
                return _calibrationfreq;
            }
            set
            {
                _calibrationfreq = value;
            }
        }
        [XmlAttribute(AttributeName = "ElectricalTestFrequency")]
        public int ElectricalTestFrequency
        {
            get
            {
                return _electricaltestfreq;
            }
            set
            {
                _electricaltestfreq = value;
            }
        }
        [XmlAttribute(AttributeName = "PurchaseDate")]
        public DateTime PurchaseDate
        {
            get
            {
                return _purchasedate;
            }
            set
            {
                _purchasedate = value;
            }
        }
        [XmlAttribute(AttributeName = "InstallationDate")]
        public DateTime Installationdate
        {
            get
            {
                return _installationdate;
            }
            set
            {
                _installationdate = value;
            }
        }
        [XmlAttribute(AttributeName = "AcquisitionDate")]
        public DateTime AcquisitionDate
        {
            get
            {
                return _acquisitiondate;
            }
            set
            {
                _acquisitiondate = value;
            }
        }
        [XmlElement(ElementName = "DisposalDate")]
        public DateTime? DisposalDate
        {
            get
            {
                return _disposaldate;
            }
            set
            {
                _disposaldate = value;
            }
        }
        [XmlElement(ElementName = "MaintenanceDate")]
        public DateTime? MaintenanceDate
        {
            get
            {
                return _maintenancedate;
            }
            set
            {
                _maintenancedate = value;
            }
        }
        [XmlElement(ElementName = "MaintenanceDueDate")]
        public DateTime? MaintenanceDueDate
        {
            get
            {
                return _maintenanceduedate;
            }
            set
            {
                _maintenanceduedate = value;
            }
        }
        [XmlElement(ElementName = "ElectricalTestDate")]
        public DateTime? ElectricalTestDate
        {
            get
            {
                return _electricaltestdate;
            }
            set
            {
                _electricaltestdate = value;
            }
        }
        [XmlElement(ElementName = "ElectricalTestDueDate")]
        public DateTime? ElectricalTestDueDate
        {
            get
            {
                return _electricaltestduedate;
            }
            set
            {
                _electricaltestduedate = value;
            }
        }
        [XmlAttribute(AttributeName = "IsBillable")]
        public bool IsBillable
        {
            get
            {
                return _isbillable;
            }
            set
            {
                _isbillable = value;
            }
        }

        [XmlAttribute(AttributeName = "HasCalibration")]
        public bool HasCalibration
        {
            get
            {
                return _hascalibration;
            }
            set
            {
                _hascalibration = value;
            }
        }

        [XmlAttribute(AttributeName = "HasMaintenance")]
        public bool HasMaintenance
        {
            get
            {
                return _hasmaintenance;
            }
            set
            {
                _hasmaintenance = value;
            }
        }

        [XmlAttribute(AttributeName = "HasElectricalTest")]
        public bool HasElectricalTest
        {
            get
            {
                return _haselectricaltest;
            }
            set
            {
                _haselectricaltest = value;
            }
        }
        [XmlIgnore]
        public List<Depreciation> DepreciationList
        {
            get
            {
                return _depreciationlist;
            }
            set
            {
                _depreciationlist = value;
                this.XMLDepreciation = serializeXML(value);
            }
        }

        [XmlIgnore]
        public List<AssetExtensions> CalibrationList
        {
            get
            {
                return _calibrationlist;
            }
            set
            {
                _calibrationlist = value;
                this.XMLCalibration = serializeXML(value);

            }
        }

        [XmlIgnore]
        public List<AssetExtensions> MaintenanceList
        {
            get
            {
                return _maintenancelist;
            }
            set
            {
                _maintenancelist = value;
                this.XMLMaintenance = serializeXML(value);

            }
        }

        [XmlIgnore]
        public List<AssetExtensions> ElectricalTestList
        {
            get
            {
                return _electricaltestlist;
            }
            set
            {
                _electricaltestlist = value;
                this.XMLElectrical = serializeXML(value);

            }
        }

        [XmlAttribute(AttributeName = "XMLElectrical")]
        public string XMLElectrical
        {
            get
            {
                return _xmlelectrical;
            }
            set
            {
                _xmlelectrical = value;

            }
        }
        [XmlAttribute(AttributeName = "XMLCalibration")]
        public string XMLCalibration
        {
            get
            {
                return _xmlcalibration;
            }
            set
            {
                _xmlcalibration = value;

            }
        }


        [XmlAttribute(AttributeName = "XMLMaintenance")]
        public string XMLMaintenance
        {
            get
            {
                return _xmlmaintenance;
            }
            set
            {
                _xmlmaintenance = value;

            }
        }
        [XmlAttribute(AttributeName = "XMLDepreciation")]
        public string XMLDepreciation        
        {
            get
            {
                return _xmldepreciation;
            }
            set
            {
                _xmldepreciation = value;
                
            }
        }
        [XmlIgnore]
        public RecordMode Mode
        {
            get
            {
                return _mode;
            }
            set
            {
                _mode = value;
                this.ModeString = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ModeString")]
        public string ModeString
        {
            get
            {
                return _modestring;
            }
            set
            {
                _modestring = value;
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
                if (obj is List<Depreciation>)
                {
                    serializer = new XmlSerializer(typeof(List<Depreciation>));

                    writer = new StringWriter();
                    serializer.Serialize(writer, obj);
                }
                else if (obj is List<AssetExtensions>)
                {
                    serializer = new XmlSerializer(typeof(List<AssetExtensions>));

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