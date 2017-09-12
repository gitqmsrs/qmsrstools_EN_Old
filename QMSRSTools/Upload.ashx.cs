using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.IO;
namespace QMSRSTools
{
    /// <summary>
    /// Summary description for Upload
    /// </summary>
    public class Upload : IHttpHandler
    {

        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain";
            context.Response.Expires = -1;
            try
            {
                var file = context.Request.Files[0];

                string savepath = "";
                string tempPath = "";
                tempPath = System.Configuration.ConfigurationManager.AppSettings["FolderPath"];
                savepath = context.Server.MapPath(tempPath);
                string filename = file.FileName;

                if (!Directory.Exists(savepath))
                    Directory.CreateDirectory(savepath);

                file.SaveAs(savepath + @"\" + filename);

                var serializer = new System.Web.Script.Serialization.JavaScriptSerializer();

                var result = new { name = savepath + "\\" + filename };
                context.Response.Write(serializer.Serialize(result));
                context.Response.StatusCode = 200;
            }
            catch (Exception ex)
            {
                context.Response.Write("Error: " + ex.Message);
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