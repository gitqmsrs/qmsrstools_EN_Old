using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Script.Serialization;
namespace QMSRSTools
{
    public class RiskFormulaProcessor
    {

        private RiskParameter _jsonparam;
        private List<string> _tokens;

        public RiskFormulaProcessor(string condition, string jsonparam)
        {

            JavaScriptSerializer serializer = new JavaScriptSerializer();
            this._jsonparam = serializer.Deserialize<RiskParameter>(jsonparam);
                
            ProcessFormula(condition);
        }

        public void ProcessFormula(string condition)
        {
           
            this._tokens = condition.Split(' ').ToList();

            for (int i = 0; i < _tokens.Count(); i++)
            {
                string token = _tokens[i];
   
                if (token == " " || token== string.Empty)
                    continue;

                if (!isOperator(token))
                {
                    _tokens[i] = resolveValue(token);       
                }
            }
        }

        public object evaluate()
        {
            FormulaProcessor obj = new FormulaProcessor(this._tokens);
            return obj.processFormula();
        }

        private string resolveValue(string attribute)
        {
            object result;

            switch (attribute.ToString())
            {
                case "[Probability]":
                    result = _jsonparam.Probability;
                    break;
                case "[TimeImpact]":
                    result = _jsonparam.TimeImpact;
                    break;
                case "[CostImpact]":
                    result = _jsonparam.CostImpact;
                    break;
                case "[QOSImpact]":
                    result = _jsonparam.QOSImpact;
                    break;
                case "[Severity]":
                    result = _jsonparam.Severity;
                    break;
                case "[SeverityHuman]":
                    result = _jsonparam.SeverityHuman;
                    break;
                case "[SeverityEnvironment]":
                    result = _jsonparam.SeverityEnvironment;
                    break;
                case "[Complexity]":
                    result = _jsonparam.Complexity;
                    break;
                default:
                    result = attribute.ToString();
                    break;
            }

            return result.ToString();
        }

        private bool isOperator(string token)
        {
            bool _isoperator = false;

            switch (token)
            {
                case "+":
                case "-":
                case "*":
                _isoperator = true;
                    break;
            }

            return _isoperator;
        }
    }
}