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
using System.Diagnostics;
namespace QMSRSTools
{
    /// <summary>
    /// Summary description for ImageHandler
    /// </summary>
    public class ImageHandler : IHttpHandler
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
       
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "Image";

            Image img = null;

            string query=context.Request.QueryString["query"];
            SqlConnection con = new SqlConnection(_context.Connection.ConnectionString);

            SqlCommand com = new SqlCommand(query, con);

            if (context.Request.QueryString["value"] != null)
            {
                com.Parameters.AddWithValue("@value", context.Request.QueryString["Value"]);
            }

            if (con.State == ConnectionState.Closed)
            {
                con.Open();

                byte[] imgbyte = null;
                try
                {
                    imgbyte = (byte[])com.ExecuteScalar();
                    ImageConverter conv = new ImageConverter();
                    img = conv.ConvertFrom(imgbyte) as Image;
                }
                catch (Exception ex)
                {
                    img = Image.FromFile(context.Server.MapPath("Images/default.png"));
                }

                con.Close();

            }
            int width = Convert.ToInt32(context.Request.QueryString["width"]);
            int height = Convert.ToInt32(context.Request.QueryString["height"]);


            img = ResizeImage(img, new Size(width, height), false);
           
            if (img != null)
            {
                MemoryStream m = new MemoryStream();
                img.Save(m, ImageFormat.Png);
                context.Response.BinaryWrite(m.ToArray());
            }
        }
        public Image ResizeImage(Image image, Size size, bool preserveAspectRatio)
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