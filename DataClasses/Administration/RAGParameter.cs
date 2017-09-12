using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Data;
using System.Data.SqlClient;

namespace QMSRSTools
{
    public class RAGParameter
    {
        private object _value;
        private string _pattern = "^\\[[a-zA-Z]+\\]$";
        private LINQConnection.QMSRSContextDataContext _context;
        private SqlConnection _con;

        public RAGParameter(object param, string module, int keyval)
        {
            _context = new LINQConnection.QMSRSContextDataContext();
            _con = new SqlConnection(_context.Connection.ConnectionString);

            //if the value is SQL parameter
            if (!isReal(param))
            {
                setParameterValue(param, module, keyval);
            }
            else if (param.ToString() == "TodayDate")
            {
                this.Value = DateTime.Now;
            }
            else
            {
                this.Value = param;
            }
        }
        private void setParameterValue(object param, string modulename, int keyval)
        {
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
                    this.Value = (object)com.ExecuteScalar();
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
        }
        public object Value
        {
            get
            {
                return _value;
            }
            set
            {
                _value = value;
            }
        }

        private bool isReal(object param)
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