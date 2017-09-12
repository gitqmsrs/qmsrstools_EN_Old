using System;
using System.Collections.Generic;
using System.Text;
using System.Xml;
using System.Collections;
using System.Text.RegularExpressions;

namespace QMSRSTools
{
    public class Xml_Manager
    {

        public class Column
        {
            public string Name = "";
            public string Value = "";
            public string Color = string.Empty;
        }
        public class Columns : ArrayList
        {
            public int Add(Column column)
            {
                return base.Add(column);
            }
            public new Column this[int index]
            {
                get
                {
                    return ((Column)base[index]);
                }
            }
        }
        public Columns columns = new Columns();

        private string _strGuid;
        public string strGuid { get { return this._strGuid; } set { this._strGuid = value; } }

        public void CreateXmlFile(string ServerPath, string Header, string Sub_Header, string X_Axis_Title, string Y_Axis_Title, string ColWidth, string rotate)
        {
            try
            {
                // Create the Folder if not Exists
                if (!System.IO.Directory.Exists(ServerPath + "\\Reports\\Data"))
                    System.IO.Directory.CreateDirectory(ServerPath + "\\Reports\\Data");

                this.strGuid = "Reports/Data/" + Guid.NewGuid().ToString() + ".xml";
                string fileName = ServerPath + "/" + strGuid;
                XmlDocument xmlDoc = new XmlDocument();
                try
                {
                    xmlDoc.Load(fileName);
                }
                catch (System.IO.FileNotFoundException)
                {
                    #region Create New xml
                    XmlTextWriter XMLWriter = new XmlTextWriter(fileName, System.Text.Encoding.UTF8);
                    XMLWriter.Formatting = Formatting.Indented;
                    XMLWriter.WriteProcessingInstruction("xml", "version='1.0' encoding= 'UTF-8'");
                    XMLWriter.WriteStartElement("graph");
                    XMLWriter.Close();
                    xmlDoc.Load(fileName);
                    #endregion
                }
                XmlNode root = xmlDoc.DocumentElement;
                root.RemoveAll();
                //root.Attributes.Appen
                XmlElement childNode = xmlDoc.CreateElement("general_settings");
                XmlAttribute at = childNode.GetAttributeNode("bg_color");

                #region general_settings
                at = xmlDoc.CreateAttribute("bg_color");
                at.Value = "FFFFFF";
                childNode.Attributes.Append(at);
                // Show BackGround Side 0 or 1
                at = xmlDoc.CreateAttribute("show_background_side");
                at.Value = "0";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("background_side_color");
                at.Value = "D9D9D9";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("floor_color");
                at.Value = "CCCCCC";
                childNode.Attributes.Append(at);
                root.AppendChild(childNode);
                #endregion
                #region header
                childNode = xmlDoc.CreateElement("header");

                at = xmlDoc.CreateAttribute("text");
                //header
                at.Value = Header;
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("font");
                at.Value = "Verdana";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("color");
                at.Value = "000000";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("size");
                at.Value = "18";
                childNode.Attributes.Append(at);

                root.AppendChild(childNode);
                #endregion
                #region subheader
                childNode = xmlDoc.CreateElement("subheader");

                at = xmlDoc.CreateAttribute("text");
                at.Value = Sub_Header;
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("font");
                at.Value = "Verdana";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("color");
                at.Value = "000000";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("size");
                at.Value = "15";
                childNode.Attributes.Append(at);

                root.AppendChild(childNode);
                #endregion
                #region legend_popup
                childNode = xmlDoc.CreateElement("legend_popup");

                at = xmlDoc.CreateAttribute("font");
                at.Value = "Verdana";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("bgcolor");
                at.Value = "FFFFE3";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("font_size");
                at.Value = "10";
                childNode.Attributes.Append(at);

                root.AppendChild(childNode);
                #endregion
                #region Xheaders
                childNode = xmlDoc.CreateElement("Xheaders");

                at = xmlDoc.CreateAttribute("rotate");
                at.Value = rotate;
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("color");
                at.Value = "000000";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("size");
                at.Value = "10";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("title");
                at.Value = X_Axis_Title;
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("title_color");
                at.Value = "000000";
                childNode.Attributes.Append(at);

                root.AppendChild(childNode);
                #endregion
                #region Yheaders
                childNode = xmlDoc.CreateElement("Yheaders");

                at = xmlDoc.CreateAttribute("color");
                at.Value = "000000";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("size");
                at.Value = "10";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("title");
                at.Value = Y_Axis_Title;
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("title_rotate");
                at.Value = "90";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("title_color");
                at.Value = "000000";
                childNode.Attributes.Append(at);

                root.AppendChild(childNode);
                #endregion
                #region grid
                childNode = xmlDoc.CreateElement("grid");

                at = xmlDoc.CreateAttribute("groove");
                at.Value = "1";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("grid_width");
                at.Value = "700";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("grid_height");
                at.Value = "250";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("grid_color");
                at.Value = "000000";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("grid_alpha");
                at.Value = "40";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("grid_thickness");
                at.Value = "1";
                childNode.Attributes.Append(at);

                root.AppendChild(childNode);
                #endregion
                #region bars
                childNode = xmlDoc.CreateElement("bars");

                at = xmlDoc.CreateAttribute("view_value");
                at.Value = "1";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("width");
                at.Value = ColWidth;
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("thickness");
                at.Value = "5";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("alpha");
                at.Value = "100";
                childNode.Attributes.Append(at);

                at = xmlDoc.CreateAttribute("pieces_grow_bar");
                at.Value = "100";
                childNode.Attributes.Append(at);

                root.AppendChild(childNode);
                #endregion
                #region Column Data :- Column name - Column Value - Column Color
                foreach (Column var in columns)
                {
                    //var.Color
                    childNode = xmlDoc.CreateElement("data");

                    at = xmlDoc.CreateAttribute("name");
                   // at.Value = var.Name;/*Column Name */
                    at.Value = Regex.Replace(var.Name, @"\s+", Environment.NewLine);
                   // at.Value = Regex.Replace(var.Name, @"\s+", "&#xA;");
                   
                    childNode.Attributes.Append(at);

                    at = xmlDoc.CreateAttribute("value");
                    at.Value = var.Value;/*Column Value */
                  

                    childNode.Attributes.Append(at);

                    at = xmlDoc.CreateAttribute("color");
                    at.Value = var.Color;/* Column Color*/
                    childNode.Attributes.Append(at);

                    root.AppendChild(childNode);

                }
                #region Not Used
                //       #region Total Raised
                //       childNode = xmlDoc.CreateElement("data");

                //       at = xmlDoc.CreateAttribute("name");
                //       at.Value = "Total Raised";
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("value");
                //       at.Value = TClosed;
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("color");
                //       at.Value = "175BE3";
                //       childNode.Attributes.Append(at);

                //       root.AppendChild(childNode);
                //#endregion
                //       #region Total Closed
                //       childNode = xmlDoc.CreateElement("data");

                //       at = xmlDoc.CreateAttribute("name");
                //       at.Value = "Total Closed";
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("value");
                //       at.Value = TClosed;
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("color");
                //       at.Value = "FFB31A";
                //       childNode.Attributes.Append(at);

                //       root.AppendChild(childNode);
                //       #endregion
                //       #region New
                //       childNode = xmlDoc.CreateElement("data");

                //       at = xmlDoc.CreateAttribute("name");
                //       at.Value = "new";
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("value");
                //       at.Value = New;
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("color");
                //       at.Value = "3C3C3C";
                //       childNode.Attributes.Append(at);

                //       root.AppendChild(childNode);
                //       #endregion
                //       #region Changed
                //       childNode = xmlDoc.CreateElement("data");

                //       at = xmlDoc.CreateAttribute("name");
                //       at.Value = "Changed";
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("value");
                //       at.Value = Changed;
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("color");
                //       at.Value = "FFFD1A";
                //       childNode.Attributes.Append(at);

                //       root.AppendChild(childNode);
                //       #endregion
                //       #region Withdrawn
                //       childNode = xmlDoc.CreateElement("data");

                //       at = xmlDoc.CreateAttribute("name");
                //       at.Value = "Withdrawn";
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("value");
                //       at.Value = Withdrawn;
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("color");
                //       at.Value = "FF1A68";
                //       childNode.Attributes.Append(at);

                //       root.AppendChild(childNode);
                //       #endregion
                //       #region Cancelled
                //       childNode = xmlDoc.CreateElement("data");

                //       at = xmlDoc.CreateAttribute("name");
                //       at.Value = "Cancelled";
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("value");
                //       at.Value = Cancelled;
                //       childNode.Attributes.Append(at);

                //       at = xmlDoc.CreateAttribute("color");
                //       at.Value = "8215D3";
                //       childNode.Attributes.Append(at);

                //       root.AppendChild(childNode);
                //       #endregion 
                //       #endregion
                #endregion
                #endregion
                #region Not Used
                //XmlElement childNode2 = xmlDoc.CreateElement("SecondChildNode");
                //XmlText textNode = xmlDoc.CreateTextNode("hello");
                //textNode.Value = "hello, world";
                //root.AppendChild(childNode);
                //childNode.AppendChild(childNode2);
                //childNode2.SetAttribute("Name", "Value");
                //childNode2.AppendChild(textNode);
                //textNode.Value = "replacing hello world"; 
                #endregion
                xmlDoc.Save(fileName);
            }
            catch (Exception ex)
            {
                WriteError(ex.ToString());
            }
        }
        protected String WriteError(string str)
        {
            string sTr = "";
            sTr = str;
            return sTr;
        }
    }
}