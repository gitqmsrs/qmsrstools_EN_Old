using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.Web.Script.Serialization;
using System.IO;
namespace QMSRSTools
{
    public enum CCNType
    {
        ISSUE = 1,
        UPDATE = 2,
        WITHDRAW = 3
    }
    public enum CCNStatus
    {
        Open = 1,
        Closed = 2,
        Cancelled = 3
    }
    [XmlType(TypeName = "CCN")]
    public class CCN
    {
        private int _ccnID;
        private string _version;
        private string _ccntypestr;
        private string _ccndetails;
        private string _docurl;
        private string _originator;
        private string _owner;
        private string _documentfile;
        private string _documentfilename;
        private string _documentfileurl;
        private string _ccnstatusstr;
        private string _memberstr;
        private string _jsonmembers;
        private string _modulename;
        
        private CCNType _ccntype;
        private CCNStatus _ccnstatus;
        private RecordsStatus _status;
        private ApprovalMember _member;
        private List<ApprovalMember> _members;
        private Modules _module;
   
        private DateTime _originationdate;
        
        public CCN()
        {
            this._ccntype = CCNType.ISSUE;
            this._status = RecordsStatus.ORIGINAL;
            this._ccnstatus = CCNStatus.Open;
            this._module = Modules.DocumentChangeRequest;
        }
        [XmlAttribute(AttributeName = "CCNID")]
        public int CCNID
        {
            get
            {
                return _ccnID;
            }
            set
            {
                _ccnID = value;
            }
        }
        public string DOCURL
        {
            get
            {
                return _docurl;
            }
            set
            {
                _docurl = value;
            }
        }
        [XmlAttribute(AttributeName = "Version")]
        public string Version
        {
            get
            {
                return _version;
            }
            set
            {
                _version = value;
            }
        }
        [XmlAttribute(AttributeName = "OrginationDate")]
        public DateTime OrginationDate
        {
            get
            {
                return _originationdate;
            }
            set
            {
                _originationdate = value;
            }
        }
        public CCNType CCNType
        {
            get
            {
                return _ccntype;
            }
            set
            {
                _ccntype = value;
                this.CCNTypeString = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "CCNType")]
        public string CCNTypeString
        {
            get
            {
                return _ccntypestr;
            }
            set
            {
                _ccntypestr = value;
            }
        }
        [XmlAttribute(AttributeName = "CCNDetails")]
        public string CCNDetails
        {
            get
            {
                return _ccndetails;
            }
            set
            {
                _ccndetails = value;
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

        public string DocumentFile
        {
            get
            {
                return _documentfile;
            }
            set
            {
                _documentfile = value;
            }
        }
        [XmlAttribute(AttributeName = "DocumentFileName")]
        public string DocumentFileName
        {
            get
            {
                return _documentfilename;
            }
            set
            {
                _documentfilename = value;
            }
        }
        [XmlAttribute(AttributeName = "DocumentFileURL")]
        public string DocumentFileURL
        {

            get
            {
                return _documentfileurl;
            }
            set
            {
                _documentfileurl = value;
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
        public CCNStatus CCNStatus
        {
            get
            {
                return _ccnstatus;
            }
            set
            {
                _ccnstatus = value;
                this.CCNStatusString = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "CCNStatus")]
        public string CCNStatusString
        {
            get
            {
                return _ccnstatusstr;
            }
            set
            {
                _ccnstatusstr = value;
            }
        }

        public ApprovalMember Member
        {
            get
            {
                return _member;
            }
            set
            {
                _member = value;
                this.MemberString = serializeXML(value);
            }
        }
        [XmlAttribute(AttributeName = "MemberString")]
        public string MemberString
        {
            get
            {
                return _memberstr;
            }
            set
            {
                _memberstr = value;
            }
        }
        public List<ApprovalMember> Members
        {
            get
            {
                return _members;
            }
            set
            {
                _members = value;
                this.JSONMembers = serializeToJSon(value);
            }
        }
        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                if (obj is ApprovalMember)
                {
                    serializer = new XmlSerializer(typeof(ApprovalMember));

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
        private string serializeToJSon(object obj)
        {
            string result = string.Empty;

            if (obj != null)
            {
                try
                {
                    if (obj is List<ApprovalMember>)
                    {
                        JavaScriptSerializer serializer = new JavaScriptSerializer();
                        result = serializer.Serialize(obj);
                    }
                }
                catch (Exception ex)
                {
                    throw new Exception(ex.InnerException.Message);
                }
            }
            return result;
        }
        [XmlAttribute(AttributeName = "JSONMembers")]
        public string JSONMembers
        {
            get
            {
                return this._jsonmembers;
            }
            set
            {
                this._jsonmembers = value;
            }
        }
    }
}