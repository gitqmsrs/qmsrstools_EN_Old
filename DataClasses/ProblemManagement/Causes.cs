using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
using System.IO;
namespace QMSRSTools
{
    [XmlType(TypeName = "Causes")]
    public class Causes
    {
        private int _causeID;
        private string _name;
        private string _description;
        private List<Causes> _children;
        private int _parentID;
        private RecordsStatus _status;
        private int _selectedCauseID;
        private bool _isSelected;
        private int _node_id;

        public Causes()
        {
            this.Status = RecordsStatus.ORIGINAL;
            this.isSelected = false;
        }

        [XmlAttribute(AttributeName = "CauseID")]
        public int CauseID
        {
            get
            {
                return _causeID;
            }
            set
            {
                _causeID = value;
            }
        }
        public int ParentID
        {
            get
            {
                return _parentID;
            }
            set
            {
                _parentID = value;
            }

        }
        [XmlIgnore]
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

        [XmlAttribute(AttributeName = "name")]
        public string name
        {
            get
            {
                return _name;
            }
            set
            {
                _name = value;
            }
        }
        public List<Causes> children
        {
            get
            {
                return _children;
            }
            set
            {
                _children = value;
            }
        }

        public RecordsStatus Status
        {
            get
            {
                return this._status;
            }
            set
            {
                this._status = value;
            }
        }
        public int SelectedCauseID
        {
            get
            {
                return _selectedCauseID;
            }
            set
            {
                _selectedCauseID = value;
            }

        }

        [XmlIgnore]
        public bool isSelected
        {
            get
            {
                return _isSelected;
            }
            set
            {
                _isSelected = value;
            }
        }

        [XmlIgnore]
        public int id
        {
            get
            {
                return _node_id;
            }
            set
            {
                _node_id = value;
            }
        }
    }
}