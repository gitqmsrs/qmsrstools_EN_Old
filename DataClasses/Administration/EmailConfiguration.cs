using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Xml.Serialization;
using System.IO;
using System.Diagnostics;
namespace QMSRSTools
{
    public class EmailConfiguration
    {
        private Modules _module;
        private string _action;
        private Stack<object> _values;
        private Stack<string> _parsedvalues;
        private LINQConnection.QMSRSContextDataContext _context;
        private long _keyvalue;
        private List<int> _recipients;

        public EmailConfiguration()
        {
            _context = new LINQConnection.QMSRSContextDataContext();
            this._values = new Stack<object>();
            this._parsedvalues = new Stack<string>();
            this._recipients = new List<int>();
        }

        public Modules Module
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

        public List<int> Recipients
        {
            get
            {
                return _recipients;
            }
            set
            {
                _recipients = value;
            }
        }
        public string Action
        {
            get
            {
                return _action;
            }
            set
            {
                _action = value;
            }
        }

        public long KeyValue
        {
            get
            {
                return this._keyvalue;
            }
            set
            {
                this._keyvalue = value;
            }
        }

        public string GetSerializedEmail()
        {
            var emailtemplate = _context.AT_EmailsTemplates
                .Where(TEMP => TEMP.Module.EnumName == _module.ToString()
                    && TEMP.Action.ActionNameEng == _action)
                    .Select(TEMP => TEMP).SingleOrDefault();

            if (emailtemplate != null)
            {

                EmailSender obj = new EmailSender();
                obj.EmailFrom = emailtemplate.EmailFrom;
                obj.SMTPServer = emailtemplate.AT_SMTPserver.SMTPserver;
                obj.Subject = ProcessEmailText(emailtemplate.EmailSubject);
                obj.Body = ProcessEmailText(emailtemplate.EmailBody);

                if (emailtemplate.AT_EmailRecipients != null)
                {
                    foreach (var recipient in emailtemplate.AT_EmailRecipients)
                    {
                        var employee = _context.Employees.Where(EMP => EMP.EmployeeID == recipient.EmployeeID)
                            .Select(EMP => EMP).SingleOrDefault();

                        if (recipient.IsTo == true)
                        {
                            obj.AddEmailTo(employee.EmailAddress);

                        }

                        if (recipient.IsCC == true)
                        {
                            obj.AddEmailCC(employee.EmailAddress);
                        }

                        if (recipient.IsBCC == true)
                        {
                            obj.AddEmailBCC(employee.EmailAddress);
                        }
                    }
                }

               
                var xml = new XmlSerializer(typeof(EmailSender));

                StringWriter str = new StringWriter();
                xml.Serialize(str, obj);

                return str.ToString();
            }
            return null;
        }

        public bool GenerateEmail()
        {
            bool isGenerated = false;

            var emailtemplate = _context.AT_EmailsTemplates
            .Where(TEMP =>  TEMP.Module.EnumName == _module.ToString()
            && TEMP.Action.ActionNameEng == _action).Select(TEMP => TEMP).SingleOrDefault();

            if (emailtemplate != null)
            {

                EmailSender obj = new EmailSender();
                obj.EmailFrom = emailtemplate.EmailFrom;
                obj.SMTPServer = emailtemplate.AT_SMTPserver.SMTPserver;
                obj.UserName = emailtemplate.AT_SMTPserver.UserName;
                obj.Password = emailtemplate.AT_SMTPserver.Password;
                obj.Subject = ProcessEmailText(emailtemplate.EmailSubject);
                obj.Body = ProcessEmailText(emailtemplate.EmailBody);
                
                
                if (this.Recipients != null)
                {
                    foreach (var recipient in this.Recipients)
                    {
                        var employee = _context.Employees.Where(EMP => EMP.EmployeeID == recipient)
                            .Select(EMP => EMP).SingleOrDefault();

                        obj.AddEmailTo(employee.EmailAddress);
                    }
                }

                obj.Send();
                isGenerated = true;
            }

            return isGenerated;
        }

        public string ProcessEmailText(string condition)
        {
            string[] tokens = condition.Split(' ');

            for (int i = 0; i < tokens.Count(); i++)
            {
                string token = tokens[i];
                this._values.Push(token);
            }
            EmailParameter param = new EmailParameter();
                
            while (this._values.Count > 0)
            {
                object entity = _values.Pop();
                
                if (!param.isReal(entity))
                {
                    condition = condition.Replace(entity.ToString(), param.getParameterValue(entity, _module.ToString(), _keyvalue).ToString());
                }
            }

            return condition;
        }
    }
}