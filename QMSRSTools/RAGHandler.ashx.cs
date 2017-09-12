using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Drawing;
using System.Drawing.Imaging;
using System.Drawing.Drawing2D;
using System.Data.SqlClient;
using System.IO;
using System.Text;
using System.Configuration;
namespace QMSRSTools
{
    /// <summary>
    /// Summary description for RAGHandler
    /// </summary>
    public class RAGHandler : IHttpHandler
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
       
        public void ProcessRequest(HttpContext context)
        {
            
            context.Response.Clear();
       
            HttpContext.Current.Response.Cache.SetExpires(DateTime.Now.Add(new TimeSpan(0, 0, 10)));
            context.Response.ContentType = "Image";
            Image img = null;

            string module=context.Request.QueryString["module"];
            int keyvalue = Convert.ToInt32(context.Request.QueryString["key"]);

            try
            {
                List<LINQConnection.RAGCondition> equations = _context.RAGConditions.Where(RAG => RAG.Module.EnumName == module)
                    .Select(RAG => RAG).ToList<LINQConnection.RAGCondition>();

                foreach (var equation in equations)
                {
                    RAGProcessor processor = new RAGProcessor();
                    processor.ProcessTokens(equation.Condition, module, keyvalue);

                    if (processor.Result == true)
                    {
                        img = getRAGIcon(equation);

                    }
                }

                if (img == null)
                {
                    img = Image.FromFile(context.Server.MapPath("Images/question_icon.jpg"));
                }
            }
            catch (Exception ex)
            {
                img = Image.FromFile(context.Server.MapPath("Images/question_icon.jpg"));
                
            }

            int width = Convert.ToInt32(context.Request.QueryString["width"]);
            int height = Convert.ToInt32(context.Request.QueryString["height"]);

            img = ResizeImage(img, new Size(width, height), false);
            
            if (img != null)
            {
                MemoryStream m = new MemoryStream();
                img.Save(m, ImageFormat.Png);
               
                img.Dispose();
                m.Dispose();

                context.Response.BinaryWrite(m.ToArray());
            }
        }
        private string getRAGSymbol(LINQConnection.RAGCondition condition)
        {
            var symbol = _context.RAGConditionSymbols.Where(RAG => RAG.RAGSymbolID == condition.RAGSymbolID)
                .Select(RAG => RAG.RAGSymbol).SingleOrDefault();

            return symbol;
        }
        private Image getRAGIcon(LINQConnection.RAGCondition condition)
        {
            Image img = null;

            string connectionstring = ConfigurationManager.ConnectionStrings["AdminToolsConnectionString"].ConnectionString;
            
            SqlConnection con = new SqlConnection(connectionstring);
            using(SqlCommand com=new SqlCommand())
            {
                com.Connection = con;
                com.CommandType = CommandType.Text;
                com.CommandText = "SELECT RAGIcon from dbo.RAGConditionSymbol WHERE RAGSymbolID=@ID";
                com.Parameters.AddWithValue("@ID", condition.RAGSymbolID);
                    
                try
                {
                    con.Open();
                    byte[] imgbyte = (byte[])com.ExecuteScalar();
                    ImageConverter conv = new ImageConverter();
                    img = conv.ConvertFrom(imgbyte) as Image;
                }
                finally
                {
                    con.Close();
                    con.Dispose();
                }
            }
            return img;
        }
        private Image ResizeImage(Image image, Size size, bool preserveAspectRatio)
        {
            int newWidth;
            int newHeight;
            if (preserveAspectRatio)
            {
                int originalWidth = image.Width;
                int originalHeight = image.Height;
                float percentWidth = (float)size.Width / (float)originalWidth;
                float percentHeight = (float)size.Height / (float)originalHeight;
                float percent = percentHeight < percentWidth ? percentHeight : percentWidth;
                newWidth = (int)(originalWidth * percent);
                newHeight = (int)(originalHeight * percent);
            }
            else
            {
                newWidth = size.Width;
                newHeight = size.Height;
            }
            Image newImage = new Bitmap(newWidth, newHeight);
            using (Graphics graphicsHandle = Graphics.FromImage(newImage))
            {
                graphicsHandle.InterpolationMode = InterpolationMode.HighQualityBicubic;
                graphicsHandle.DrawImage(image, 0, 0, newWidth, newHeight);
            }
            return newImage;
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