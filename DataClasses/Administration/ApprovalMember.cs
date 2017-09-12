using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;

namespace QMSRSTools
{
    public enum ApprovalStatus
    {
        APPROVED = 1,
        DECLINED = 2,
        PENDING = 3
    }

    [XmlType(TypeName = "ApprovalMember")]
    public class ApprovalMember
    {
        private string _member;
        private string _type;
        private int _memberID;

        private ApprovalStatus _approvalstatus;
        private string _approvalstatusstr;
        private string _remarks;

        private RecordsStatus _status;
        public ApprovalMember()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }
       
        [XmlAttribute(AttributeName = "MemberID")]
        public int MemberID
        {
            get
            {
                return _memberID;
            }
            set
            {
                _memberID = value;
            }
        }
        
        [XmlAttribute(AttributeName = "Member")]
        public string Member
        {
            get
            {
                return _member;
            }
            set
            {
                _member = value;
            }
        }
        [XmlAttribute(AttributeName = "MemberType")]
        public string MemberType
        {
            get
            {
                return _type;
            }
            set
            {
                _type = value;
            }
        }

        public ApprovalStatus ApprovalStatus
        {
            get
            {
                return _approvalstatus;
            }
            set
            {
                _approvalstatus = value;
                this.ApprovalStatusString = value.ToString();
            }
        }
        [XmlAttribute(AttributeName = "ApprovalStatus")]
        public string ApprovalStatusString
        {
            get
            {
                return _approvalstatusstr;
            }
            set
            {
                _approvalstatusstr = value;
            }
        }
        [XmlAttribute(AttributeName = "ApprovalRemarks")]
        public string ApprovalRemarks
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