using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
using System.Xml.Serialization;
namespace QMSRSTools
{
     [XmlType(TypeName = "DocFileType")]
    public class DocFileType
    {
        private string _extension;
        private long _docfiletypeid;
        private string _filetype;
        private string _contenttype;
        private string _icon;

        private RecordsStatus _status;

        public DocFileType()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }

        [XmlAttribute(AttributeName = "DocFileTypeID")]
        public long DocFileTypeID
        {
            get
            {
                return _docfiletypeid;
            }
            set
            {
                _docfiletypeid = value;
            }
        }

        [XmlAttribute(AttributeName = "Extension")]
        public string Extension
        {
            get
            {
                return _extension;
            }
            set
            {
                _extension = value;
            }
        }
        
        [XmlIgnore]
        public string Icon
        {
            get
            {
                return _icon;
            }
            set
            {
                _icon = value;

            }
        }

        [XmlAttribute(AttributeName = "ContentType")]
        public string ContentType
        {
            get
            {
                return _contenttype;
            }
            set
            {
                _contenttype = value;
            }
        }
        [XmlAttribute(AttributeName = "FileType")]
        public string FileType
        {
            get
            {
                return _filetype;
            }
            set
            {
                _filetype = value;
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