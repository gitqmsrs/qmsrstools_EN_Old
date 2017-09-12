using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMSRSTools
{
    /// <summary>
    /// Summary description for FormulaHandler
    /// </summary>
    public class FormulaHandler : IHttpHandler
    {
        private LINQConnection.QMSRSContextDataContext _context = new LINQConnection.QMSRSContextDataContext();
      
        public void ProcessRequest(HttpContext context)
        {
            context.Response.ContentType = "text/plain"; 
            
            context.Response.Clear();

            string jsonparam = context.Request.QueryString["param"];
            string risktype = context.Request.QueryString["risktype"];


            var condition = _context.RiskFormulas.Where(RP => RP.RiskType.RiskType1 == risktype).Select(RP => RP).SingleOrDefault();
            if (condition != null)
            {

                RiskFormulaProcessor obj = new RiskFormulaProcessor(condition.Formula,jsonparam);
                object result = obj.evaluate();

                context.Response.Write(result);
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