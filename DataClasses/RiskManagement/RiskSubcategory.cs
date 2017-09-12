using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Xml.Serialization;
namespace QMSRSTools
{
    [XmlType(TypeName = "RiskSubcategory")]
    public class RiskSubcategory
    {
        private int _subcategoryID;
        private int _statusInt;
        private string _subcategory;
        private string _category;
        private string _description;

        private RecordsStatus _status;

        public RiskSubcategory()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }
        [XmlAttribute(AttributeName = "SubCategoryID")]
        public int SubCategoryID
        {
            get
            {
                return _subcategoryID;
            }
            set
            {
                _subcategoryID = value;
            }
        }
        [XmlAttribute(AttributeName = "Category")]
        public string Category
        {
            get
            {
                return _category;
            }
            set
            {
                _category = value;
            }
        }

        [XmlAttribute(AttributeName = "SubCategory")]
        public string name
        {
            get
            {
                return _subcategory;
            }
            set
            {
                _subcategory = value;
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
                this.StatusInt = (int)value;
            }
        }
        [XmlAttribute(AttributeName = "Status")]
        public int StatusInt
        {
            get
            {
                return _statusInt;
            }
            set
            {
                _statusInt = value;
            }
        }
    }
}