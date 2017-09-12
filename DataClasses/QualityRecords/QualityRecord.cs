using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Collections.Generic;
using System.Linq;
using System.IO;

namespace QMSRSTools
{
    public enum QualityRecordStatus
    {
        Retained = 1,
        Disposed = 2,
        Cancelled = 3
    }

    [XmlType(TypeName = "QualityRecord")]
    public class QualityRecord
    {
        private int _recordID;
        private int _reviewdur;
        private int _retentiondur;
 
        private string _recordno;
        private string _title;
        private string _department;
        private string _reviewperiod;
        private string _retentionperiod; 
        private string _remarks;
        private string _recordstatusstring;
        private string _modestring;
        private string _recordfileurl;
        private string _recordfilename;
        private string _recordfile;
        private string _originator;
        private string _owner;
        private string _recordfiletype;
        private string _modulename;

        private QualityRecordStatus _recordstatus;

        private DateTime _issuedate;
        private DateTime? _reviewdate;
       
        private RecordMode _mode;
        private RecordsStatus _status;


        public QualityRecord()
        {
            this.IssueDate = DateTime.Now;
            this.RecordStatus = QualityRecordStatus.Retained;
            this.Mode = RecordMode.Current;

        }

        [XmlAttribute(AttributeName = "RecordID")]
        public int RecordID
        {
            get
            {
                return _recordID;
            }
            set
            {
                _recordID = value;
            }
        }

        [XmlAttribute(AttributeName = "RecordNo")]
        public string RecordNo
        {
            get
            {
                return _recordno;
            }
            set
            {
                _recordno = value;
            }
        }

        [XmlAttribute(AttributeName = "IssueDate")]
        public DateTime IssueDate
        {

            get
            {
                return _issuedate;
            }
            set
            {
                _issuedate = value;
            }
        }
        
        [XmlElement(ElementName = "ReviewDate")] 
        public DateTime? ReviewDate
        {

            get
            {
                return _reviewdate;
            }
            set
            {
                _reviewdate = value;
            }
        }

        [XmlAttribute(AttributeName = "RecordStatusString")]
        public string RecordStatusString
        {
            get
            {
                return _recordstatusstring;
            }
            set
            {
                _recordstatusstring = value;
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

        [XmlAttribute(AttributeName = "ReviewPeriod")]
        public string ReviewPeriod
        {
            get
            {
                return _reviewperiod;
            }
            set
            {
                _reviewperiod = value;
            }
        }

        [XmlAttribute(AttributeName = "RetentionPeriod")]
        public string RetentionPeriod
        {
            get
            {
                return _retentionperiod;
            }
            set
            {
                _retentionperiod = value;
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

        [XmlAttribute(AttributeName = "Originator")]
        public string Originator
        {
            get
            {
                return _originator;
            }
            set
            {
                _originator = value;
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

        [XmlAttribute(AttributeName = "RecordFileType")]
        public string RecordFileType
        {
            get
            {
                return _recordfiletype;
            }
            set
            {
                _recordfiletype = value;
            }
        }

        [XmlAttribute(AttributeName = "RecordFileURL")]
        public string RecordFileURL
        {
            get
            {
                return _recordfileurl;
            }
            set
            {
                _recordfileurl = value;
            }
        }

        public string RecordFile
        {
            get
            {
                return _recordfile;
            }
            set
            {
                _recordfile = value;
            }
        }

        [XmlAttribute(AttributeName = "RecordFileName")]
        public string RecordFileName
        {
            get
            {
                return _recordfilename;
            }
            set
            {
                _recordfilename = value;
            }
        }

        [XmlAttribute(AttributeName = "ReviewDuration")]
        public int ReviewDuration
        {
            get
            {
                return _reviewdur;
            }
            set
            {
                _reviewdur = value;
            }
        }

        [XmlAttribute(AttributeName = "RetentionDuration")]
        public int RetentionDuration
        {
            get
            {
                return _retentiondur;
            }
            set
            {
                _retentiondur = value;
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
        public QualityRecordStatus RecordStatus
        {
            get
            {
                return _recordstatus;
            }
            set
            {
                _recordstatus = value;

                this._recordstatusstring = value.ToString();
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
    }

}