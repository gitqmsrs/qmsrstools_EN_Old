using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Collections.Generic;

namespace QMSRSTools
{
    [XmlType(TypeName = "Skill")]
    public class Skill
    {
        private int _skillID;
        private string _skillkey;
        private string _description;
        private RecordsStatus _status;

        public Skill()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }
        [XmlAttribute(AttributeName = "SkillID")]
        public int SkillID
        {
            get
            {
                return _skillID;
            }
            set
            {
                _skillID = value;
            }
        }
        [XmlAttribute(AttributeName = "SKL")]
        public string SKL
        {
            get
            {
                return _skillkey;
            }
            set
            {
                _skillkey = value;
            }
        }
        [XmlAttribute(AttributeName = "DESC")]
        public string DESC
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