using System;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
using System.Web.Compilation;
using AjaxControlToolkit;
namespace QMSRSTools
{
    public class ControlRenderer : IHttpHandler
    {
        /// <summary>
        /// You will need to configure this handler in the Web.config file of your 
        /// web and register it with IIS before being able to use it. For more information
        /// see the following link: http://go.microsoft.com/?linkid=8101007
        /// </summary>
        #region IHttpHandler Members

        public bool IsReusable
        {
            // Return false in case your Managed Handler cannot be reused for another request.
            // Usually this would be false in case you have some state information preserved per request.
            get { return false; }
        }

        public void ProcessRequest(HttpContext context)
        {
            //write your handler implementation here.
            string url = string.Empty;
            string extension = string.Empty;
            if (context.Request.QueryString["url"] != null)
            {
                url = context.Request.QueryString["URL"];
            }
            if (context.Request.QueryString["Extension"] != null)
            {
                extension = context.Request.QueryString["Extension"];
            }
            if (url != string.Empty)
            {
                string htmlString = RenderHtml(url + "." + extension);
                
                context.Response.ContentType = "text/plain";
                context.Response.Write(htmlString);
                context.Response.End();
            }
        }
        private string RenderHtml(string url)
        {
            Page page = null;
            StringWriter writer = null;

            string[] ext = url.Split('.');
            if (ext[ext.Length - 1] == "ascx")
            {
                page = new Page();

                HtmlForm form = new HtmlForm();
                Control control = page.LoadControl(url);

                form.Controls.Add(control);

                HtmlHead header = new HtmlHead();
                header.Attributes.Add("runat", "server");

                page.Controls.Add(header);
                page.Controls.Add(form);


                if (ToolkitScriptManager.GetCurrent(page) == null)
                {
                    form.Controls.Add(new ToolkitScriptManager());
                }
            }
            else
            {
                Type type = BuildManager.GetCompiledType(url);
                page = (Page)Activator.CreateInstance(type);
            }
           

            writer = new StringWriter();
            HttpContext.Current.Server.Execute(page, writer, false);
            
            return writer.ToString();
        }

        #endregion
    }
}
