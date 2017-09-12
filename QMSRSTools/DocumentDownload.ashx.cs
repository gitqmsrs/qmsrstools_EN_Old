using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMSRSTools
{
    /// <summary>
    /// Summary description for DocumentDownload
    /// </summary>
    public class DocumentDownload : IHttpHandler
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();

        public void ProcessRequest(HttpContext context)
        {
            int ID = Convert.ToInt32(context.Request.QueryString["key"]);
            string module = context.Request.QueryString["module"];
            switch (module)
            {
                case "DCR":
                    var CCN = _context.ChangeControlNotes.Where(C => C.CCNID == ID).Select(C => C).SingleOrDefault();
                    if (CCN != null)
                    {
                        Byte[] bytes = (Byte[])CCN.DocumentFile.ToArray();
                        context.Response.Buffer = true;
                        context.Response.Charset = "";
                        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                        context.Response.ContentType = CCN.Document.DocumentFileType.ContentType;
                        context.Response.AddHeader("content-disposition", "attachment;filename="
                        + CCN.DocumentFileName);
                        context.Response.BinaryWrite(bytes);
                        context.Response.Flush();
                        context.Response.End();
                    }
                    break;
                case "QR":
                    var record = _context.Records.Where(QR => QR.RecordID == ID).Select(QR => QR).SingleOrDefault();
                    if (record != null)
                    {
                        Byte[] bytes = (Byte[])record.RecordFile.ToArray();
                        context.Response.Buffer = true;
                        context.Response.Charset = "";
                        context.Response.Cache.SetCacheability(HttpCacheability.NoCache);
                        context.Response.ContentType = record.DocumentFileType.ContentType;
                        context.Response.AddHeader("content-disposition", "attachment;filename="
                        + record.RecordFileName);
                        context.Response.BinaryWrite(bytes);
                        context.Response.Flush();
                        context.Response.End();
                    }
                    break;
            }
        }

        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}