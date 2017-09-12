using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text.RegularExpressions;
using System.Data;
using System.Data.SqlClient;

namespace QMSRSTools
{
    public class EmailParameter
    {
        private string _pattern = "^\\[[a-zA-Z]+\\]$";
        private LINQConnection.QMSRSContextDataContext _context;
        private SqlConnection _con;

        public EmailParameter()
        {
            _context = new LINQConnection.QMSRSContextDataContext();
            _con = new SqlConnection(_context.Connection.ConnectionString);

        }
        public object getParameterValue(object param, string modulename, long keyval)
        {
            object value = null;

            var module = _context.Modules.Single(MOD => MOD.EnumName == modulename);

            //define sql command to build SQL query for a table where the details is stored in dbo.Modules table

            using (SqlCommand com = new SqlCommand())
            {
                com.Connection = this._con;
                com.CommandType = CommandType.Text;
                com.CommandText = "SELECT " + param.ToString() + " FROM " + string.Concat(new string[] { module.SchemaName, ".", module.SQLModuleName }) +
                    " WHERE " + module.PrimaryKey + "= @parameter";
                com.Parameters.AddWithValue("@parameter", keyval);

                try
                {
                    this._con.Open();
                    //set the value of the parameter
                    value = (object)com.ExecuteScalar();
                }
                catch (SqlException ex)
                {
                    throw new Exception(ex.Message);
                }
                finally
                {
                    this._con.Close();
                }
            }

            return value;
        }
        public bool isReal(object param)
        {
            if (Regex.IsMatch(param.ToString(), _pattern))
            {
                return false;
            }
            else
            {
                return true;
            }
        }
    }
}