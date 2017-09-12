using System;
using System.Xml.Serialization;
using System.Globalization;
using System.Collections.Generic;
using System.IO;
using System.Web.Script.Serialization;
namespace QMSRSTools
{
    public enum PositionStatus
    {
        FILLED = 1,
        VACANT = 2
    }

    [XmlType(TypeName = "Position")]
    public class Position
    {
        private int _positionID;
        private string _title;
        private string _description;
        private DateTime _opendate;
        private DateTime _closedate;
        private PositionStatus _posstatus;
        private string _posstatusstr;
        private string _supervisor;
        private string _unit;
        private RecordsStatus _status;
        private List<Skill> _skills;
        private string _xmlskills;
        private string _jsonskills;

        public Position()
        {
            this.Status = RecordsStatus.ORIGINAL;
            this.POSStatus = PositionStatus.VACANT;
        }

        [XmlAttribute(AttributeName = "PositionID")]
        public int PositionID
        {
            get
            {
                return _positionID;
            }
            set
            {
                _positionID = value;
            }
        }

        [XmlAttribute(AttributeName = "Title")]
        public string Title
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

        [XmlAttribute(AttributeName = "Unit")]
        public string Unit
        {
            get
            {
                return _unit;
            }
            set
            {
                _unit = value;
            }
        }

        [XmlAttribute(AttributeName = "OpenDate")]
        public DateTime OpenDate
        {
            get
            {
                return _opendate;
            }
            set
            {
                _opendate = value;
            }
        }

        [XmlAttribute(AttributeName = "CloseDate")]
        public DateTime CloseDate
        {
            get
            {
                return _closedate;
            }
            set
            {
                _closedate = value;
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
        public PositionStatus POSStatus
        {
            get
            {
                return _posstatus;
            }
            set
            {
                _posstatus = value;

                this.POSStatusStr = value.ToString();
            }
        }


        [XmlAttribute(AttributeName = "POSStatus")]
        public string POSStatusStr
        {
            get
            {
                return _posstatusstr;
            }
            set
            {
                _posstatusstr = value;
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

        [XmlAttribute(AttributeName = "XMLSkills")]
        public string XMLSkills
        {
            get
            {
                return _xmlskills;
            }
            set
            {
                _xmlskills = value;
            }
        }

        [XmlAttribute(AttributeName = "Supervisor")]
        public string Supervisor
        {
            get
            {
                return _supervisor;
            }
            set
            {
                _supervisor = value;
            }
        }
        public List<Skill> Skills
        {
            get
            {
                return _skills;
            }
            set
            {
                _skills = value;

                this.XMLSkills = serializeXML(value);
                this.JSONSkills = serializeToJSon(value);
            }
        }
        [XmlAttribute(AttributeName = "JSONSkills")]
        public string JSONSkills
        {

            get
            {
                return _jsonskills;
            }
            set
            {
                _jsonskills = value;
            }
        }
        private string serializeToJSon(object obj)
        {
            string result = string.Empty;

            if (obj != null)
            {
                try
                {
                    if (obj is List<Skill>)
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
        private string serializeXML(object obj)
        {
            XmlSerializer serializer = null;
            StringWriter writer = null;

            if (obj != null)
            {
                try
                {
                    if (obj is List<Skill>)
                    {
                        serializer = new XmlSerializer(typeof(List<Skill>));
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