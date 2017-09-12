//class created to store and load the attribute values of the Organization Level Table in the database
using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Collections.Generic;

namespace QMSRSTools
{
    [XmlType(TypeName = "ORGLevel")]
    public class ORGLevel
    {
        private int _ORGLVLID;
        private string _ORGLevel;
        private RecordsStatus _status;

        public ORGLevel()
        {
            this.Status = RecordsStatus.ORIGINAL;
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
        [XmlAttribute(AttributeName = "LevelID")]
        public int LevelID
        {
            get
            {
                return _ORGLVLID;
            }
            set
            {
                _ORGLVLID = value;
            }
        }
        [XmlAttribute(AttributeName = "Level")]
        public string Level
        {
            get
            {
                return _ORGLevel;
            }
            set
            {
                _ORGLevel = value;
            }
        }
    }
}

