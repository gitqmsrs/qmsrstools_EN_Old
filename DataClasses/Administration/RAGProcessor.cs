using System;
using System.Text;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using LINQConnection;
using System.IO;
namespace QMSRSTools
{
    public class RAGProcessor
    {
        private Stack<object> _operators;
        private Stack<object> _values;

        private Stack<object> _conjvalues;
        private Stack<object> _conjoperators;

        private bool _conjunction;
        private bool _finalresult;

        private QMSRSContextDataContext _context;
        private SqlConnection _con;


        public RAGProcessor()
        {
            this._operators = new Stack<object>();
            this._values = new Stack<object>();

            this._conjvalues = new Stack<object>();
            this._conjoperators = new Stack<object>();

            this._context = new QMSRSContextDataContext();

            this._con = new SqlConnection(this._context.Connection.ConnectionString);
        }

        public bool Result
        {
            get
            {
                return _finalresult;
            }
            set
            {
                _finalresult = value;
            }
        }

        public void ProcessTokens(string condition, string module, int key)
        {
            try
            {
                string[] tokens = condition.Split(' ');

                for (int i = 0; i < tokens.Count(); i++)
                {
                    string token = tokens[i];

                    if (token == " " || token == string.Empty)
                        continue;

                    if (isOperator(token))
                    {
                        this._operators.Push(token);
                    }
                    else
                    {
                        this._values.Push(token);
                    }
                }


                while (_operators.Count != 0)
                {
                    string _operator = _operators.Pop().ToString();

                    if (_operator == "AND" || _operator == "OR")
                    {
                        if (this._conjunction == false)
                            this._conjunction = true;

                        this._conjvalues.Push(this._values.Pop());
                        this._conjoperators.Push(_operator);
                    }
                    else
                    {
                        object param1 = new RAGParameter(_values.Pop(), module, key).Value;
                        object param2 = new RAGParameter(_values.Pop(), module, key).Value;

                        resolveOperation(param1, param2, _operator);
                    }
                }

                /*if there is conjunction and/or to another equation
                 * then add the final result to the conjunction list
                 */

                if (this._conjunction)
                {
                    this._conjvalues.Push(this._values.Pop());

                    processJunction(module, key);
                }


                else
                {
                    object resultval = this._values.Pop();

                    if (resultval != null)
                    {
                        if (Type.GetTypeCode(resultval.GetType()) == TypeCode.Boolean)
                        {
                            this._finalresult = (bool)resultval;
                        }
                    }
                    else
                    {
                        this._finalresult = false;
                    }


                }
            }
            catch { }

        }
        private string reconstructCondition(string condition)
        {
            string[] tokens = condition.Split(' ');

            for (int i = 0; i < tokens.Length; i++)
            {
                if (tokens[i] == "TodayDate")
                {
                    tokens[i] = DateTime.Now.ToString("yyyy-MM-dd");
                }
                if (tokens[i] == "+")
                {
                    string value = "DATEADD(DAY," + tokens[i + 1] + "," + tokens[i - 1] + ")";
                    tokens[i] = value;
                    tokens[i - 1] = string.Empty;
                    tokens[i + 1] = string.Empty;
                }
                if (tokens[i] == "-")
                {
                    string value = "DATEADD(DAY," + Convert.ToInt32(tokens[i + 1]) * -1 + "," + tokens[i - 1] + ")";
                    tokens[i] = value;
                    tokens[i - 1] = string.Empty;
                    tokens[i + 1] = string.Empty;
                }
            }
            return ConvertArraytoString(tokens);
        }

        private string ConvertArraytoString(string[] tokens)
        {
            StringBuilder sb = new StringBuilder();

            foreach (var str in tokens)
            {
                sb.Append(str);
            }
            return sb.ToString();
        }
      
        
        private void processJunction(string module, int key)
        {
            while (this._conjoperators.Count != 0)
            {
                string conjunction = this._conjoperators.Pop().ToString().Trim();

                object param1 = new RAGParameter(_conjvalues.Pop(), module, key).Value;
                object param2 = new RAGParameter(_conjvalues.Pop(), module, key).Value;

                
                resolveOperation(param1, param2, conjunction);
            }

            object resultval = this._conjvalues.Pop();
            if (Type.GetTypeCode(resultval.GetType()) == TypeCode.Boolean)
            {
                this._finalresult = (bool)resultval;
            }
        }
        private void resolveOperation(object param1, object param2, string operation)
        {
            Operation obj;
            switch (operation)
            {
                case "+":
                    obj = new Sum();
                    _values.Push(obj.Calculate(param1, param2));
                    break;
                case "-":
                    obj = new Subtract();
                    _values.Push(obj.Calculate(param1, param2));
                    break;
                case "=":
                    obj = new Equals();
                    _values.Push(obj.Calculate(param1, param2));
                    break;
                case ">=":
                    obj = new GreaterEquals();
                    _values.Push(obj.Calculate(param1, param2));
                    break;
                case ">":
                    obj = new Greater();
                    _values.Push(obj.Calculate(param1, param2));
                    break;

                case "<":
                    obj = new Less();
                    _values.Push(obj.Calculate(param1, param2));
                    break;
                case "<=":
                    obj = new LessEquals();
                    _values.Push(obj.Calculate(param1, param2));
                    break;
                case "AND":
                    obj = new AND();
                    _conjvalues.Push(obj.Calculate(param1, param2));
                    break;
                case "OR":
                    obj = new OR();
                    _conjvalues.Push(obj.Calculate(param1, param2));
                    break;
            }
        }
        public bool isOperator(string token)
        {
            bool _isoperator = false;

            switch (token)
            {
                case "+":
                case "-":
                case "=":
                case ">":
                case "<":
                case ">=":
                case "<=":
                case "!=":
                case "AND":
                case "OR":
                    _isoperator = true;
                    break;
            }
            return _isoperator;
        }
    }
}