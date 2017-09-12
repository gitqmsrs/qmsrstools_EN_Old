using System;
using System.Collections;
using System.Linq;
using System.Text;
using System.Web;
using System.Net;
using System.Net.Mail;
using System.Collections.Generic;
using System.Xml.Serialization;

namespace QMSRSTools
{
    [XmlType(TypeName = "EmailSender")]
    public class EmailSender
    {
        #region Properites Variables
     
        private string _EmailFrom;

        private ArrayList _EmailTo;
        private ArrayList _EmailCC;
        private ArrayList _EmailBCC;
       
        private string _TO;
        private string _CC;
        private string _BCC;
        
        string _Subject = "";
        string _Body = "";
        string _SMTPServer = "";
        string _UserName = "";
        string _Password = "";

        #endregion

        public EmailSender()
        {
            this._EmailTo = new ArrayList();
            this._EmailCC = new ArrayList();
            this._EmailBCC = new ArrayList();
        }

        #region Properites
        /// <summary>
        /// Email From
        /// </summary>
        [XmlAttribute(AttributeName = "EmailFrom")]   
        public string EmailFrom
        {
            set { _EmailFrom = value; }
            get { return _EmailFrom; }

        }
        /// <summary>
        /// Email To
        /// </summary>
        public void AddEmailTo(string address)
        {
            this._EmailTo.Add(address);
        }
        /// <summary>
        /// Email CC
        /// </summary>
        public void AddEmailCC(string address)
        {
            this._EmailCC.Add(address);
        }
        /// <summary>
        /// Email CC
        /// </summary>
        public void AddEmailBCC(string address)
        {
            this._EmailBCC.Add(address);
        }

        [XmlAttribute(AttributeName = "GetTo")]   
        public string GetTo
        {
            get
            {
                _TO = string.Join(",", (string[])this._EmailTo.ToArray(typeof(string)));
                return _TO;
            }
            set
            {
                _TO = value;
            }
        }
        [XmlAttribute(AttributeName = "GetCC")]   
        public string GetCC
        {
            get
            {
                _CC = string.Join(",", (string[])this._EmailCC.ToArray(typeof(string)));
                return _CC;
            }
            set
            {
                _CC = value;
            }
        }
        [XmlAttribute(AttributeName = "GetBCC")]  
        public string GetBCC
        {
            get
            {
                _BCC = string.Join(",", (string[])this._EmailBCC.ToArray(typeof(string)));
                return _BCC;
            }
            set
            {
                _BCC = value;
            }
        }

        /// <summary>
        /// Email Subject
        /// </summary>

        [XmlAttribute(AttributeName = "Subject")]  
        public string Subject
        {
            set { _Subject = value; }
            get { return _Subject; }

        }
        /// <summary>
        /// Email Body
        /// </summary>
        [XmlAttribute(AttributeName = "Body")]  
        public string Body
        {
            set { _Body = value; }
            get { return _Body; }

        }
        /// <summary>
        /// SMTP Server
        /// </summary>
        [XmlIgnore]
        public string SMTPServer
        {
            set { _SMTPServer = value; }
            get { return _SMTPServer; }

        }

        /// <summary>
        /// UserName
        /// </summary>
        [XmlIgnore]
        public string UserName
        {
            set { _UserName = value; }
            get { return _UserName; }

        }

        /// <summary>
        /// Password
        /// </summary>
        [XmlIgnore]
        public string Password
        {
            set { _Password = value; }
            get { return _Password; }

        }

        #endregion

 

        #region SendEmail
        public void Send()
        {
            try
            {
                MailMessage Email = new MailMessage();
                MailAddress address = new MailAddress(EmailFrom, EmailFrom);

                Email.From = address;
                if (this._EmailTo.Count > 0)
                {
                    Email.To.Add(this.GetTo);
                }
                if (this._EmailCC.Count > 0)
                {
                    Email.CC.Add(this.GetCC);
                }
                if (this._EmailBCC.Count > 0)
                {
                    Email.Bcc.Add(this.GetBCC);
                }
                Email.Subject = this.Subject;
                Email.Body = this.Body;


                SmtpClient EmailClient = new SmtpClient(SMTPServer, 587);  
                NetworkCredential credential = new NetworkCredential (UserName, Password); 
                EmailClient.Credentials = credential; 

                EmailClient.Send(Email);
            }
            catch (Exception ex)
            {
                throw new Exception(ex.Message);
            }
        }

        #endregion
    }
}