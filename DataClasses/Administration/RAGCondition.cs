using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
namespace QMSRSTools
{
    [XmlType(TypeName = "RAGCondition")]
    public class RAGCondition
    {
        private int _ragconditionId;
        private string _module;
        private string _RAG;
        private string _condition;
      

        private RecordsStatus _status;
        
        public RAGCondition()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "RAGConditionID")]
        public int RAGConditionID
        {
            get
            {
                return _ragconditionId;
            }
            set
            {
                _ragconditionId = value;
            }
        }

        [XmlAttribute(AttributeName = "Module")]
        public string Module
        {
            get
            {
                return _module;
            }
            set
            {
                _module = value;
            }
        }
        [XmlAttribute(AttributeName = "RAG")]
        public string RAG
        {
            get
            {
                return _RAG;
            }
            set
            {
                _RAG = value;
            }
        }
        [XmlAttribute(AttributeName = "Condition")]
        public string Condition
        {
            get
            {
                return _condition;
            }
            set
            {
                _condition = value;
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