using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "RAGLinkAction")]
    public class RAGLinkAction
    {
        private int _linkactionID;
        private string _conjunction;
        private string _sqlstatement;
 
        private RecordsStatus _status;

        public RAGLinkAction()
        {
            this._status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "LinkActionID")]
        public int LinkActionID
        {
            get
            {
                return _linkactionID;
            }
            set
            {
                _linkactionID = value;
            }
        }
        
        [XmlAttribute(AttributeName = "Conjunction")]
        public string Conjunction
        {
            get
            {
                return _conjunction;
            }
            set
            {
                _conjunction = value;
            }
        }
        
        [XmlAttribute(AttributeName = "SQLStatement")]
        public string SQLStatement
        {
            get
            {
                return _sqlstatement;
            }
            set
            {
                _sqlstatement = value;
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