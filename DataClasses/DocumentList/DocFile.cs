using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Collections.Generic;
using System.Linq;
using System.IO;

namespace QMSRSTools
{
    public enum DocStatus
    {
        Issued = 1,
        Updated = 2,
        Withdrawn = 3,
        Pending = 4,
        Cancelled = 6
    }

    [XmlType(TypeName = "DocFile")]
    public class DocFile
    {
        private long _docID;
        private int _reviewdur;
        private int _reviewdurdays;
       

        private string _docno;
        private string _docftype;
        private string _doctype;
        private string _title;
        private string _project;
        private string _department;
        private string _reviewperiod;
        private string _remarks;
        private string _docstatusstring;
        private string _modulename;
        private string _xmlccnlist;
        private string _modestring;
       
        private DateTime? _issuedate;
        private DateTime? _lastreviewdate;
        private DateTime? _nextreviewdate;
        private DocStatus _docstatus;

        private RecordMode _mode;
        private RecordsStatus _status;
      
        private List<CCN> _ccnlist;
        private Modules _module;
   
     
        public DocFile()
        {
            this.DOCStatus = DocStatus.Pending;
            this.Status = RecordsStatus.ORIGINAL;
            this.Module = Modules.DocumentList;
            this.Mode = RecordMode.Current;
        }

        [XmlAttribute(AttributeName = "DOCID")]   
        public long DOCID
        {
            get
            {
                return _docID;
            }
            set
            {
                _docID = value;
            }
        }
       
        [XmlAttribute(AttributeName = "DOCNo")]   
        public string DOCNo
        {
            get
            {
                return _docno;
            }
            set
            {
                _docno = value;
            }
        }

        [XmlAttribute(AttributeName = "DOCType")]
        public string DOCType
        {
            get
            {
                return _doctype;
            }
            set
            {
                _doctype = value;
            }
        }

        [XmlAttribute(AttributeName = "Project")]
        public string Project
        {
            get
            {
                return _project;
            }
            set
            {
                _project = value;
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

        [XmlAttribute(AttributeName = "DOCFileType")]   
        public string DOCFileType
        {
            get
            {
                return _docftype;
            }
            set
            {
                _docftype = value;
            }
        }
        
        [XmlAttribute(AttributeName = "DOCTitle")]   
        public string DOCTitle
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
        [XmlAttribute(AttributeName = "ReviewDurationDays")]  
        public int ReviewDurationDays
        {
            get
            {
                return _reviewdurdays;
            }
            set
            {
                _reviewdurdays = value;
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
        [XmlElement(ElementName="IssueDate")]   
        public DateTime? IssueDate
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
        [XmlElement(ElementName = "LastReviewDate")]  
        public DateTime? LastReviewDate
        {
            get
            {
                return _lastreviewdate;
            }
            set
            {
                if (value == null)
                {
                    _lastreviewdate = value;
                }
                else
                {
                    _lastreviewdate = Convert.ToDateTime(value);
                }
            }
        }
        [XmlElement(ElementName = "NextReviewDate")]  
        public DateTime? NextReviewDate
        {
            get
            {
                return _nextreviewdate;
            }
            set
            {
                if (value == null)
                {
                    _nextreviewdate = value;
                }
                else
                {
                    _nextreviewdate = Convert.ToDateTime(value);
                }
            }
        }

        [XmlIgnore]
        public DocStatus DOCStatus
        {
            get
            {
                return _docstatus;
            }
            set
            {
                _docstatus = value;
                this.DOCStatusString = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "DOCStatusString")]   
        public string DOCStatusString
        {
            get
            {
                return _docstatusstring;
            }
            set
            {
                _docstatusstring = value;
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
        [XmlAttribute(AttributeName = "XMLCCNList")]
        public string XMLCCNList
        {
            get
            {
                return _xmlccnlist;
            }
            set
            {
                _xmlccnlist = value;
            }
        }
        public List<CCN> CCNList
        {
            get
            {
                return _ccnlist;
            }
            set
            {
                _ccnlist = value;
                this.XMLCCNList = serializeXML(value);
            }
        }
        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                try
                {
                    if (obj is List<CCN>)
                    {
                        serializer = new XmlSerializer(typeof(List<CCN>));
                        writer = new StringWriter();
                        serializer.Serialize(writer, obj);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.InnerException.Message);
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