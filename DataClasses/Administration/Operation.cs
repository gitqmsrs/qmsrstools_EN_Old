using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMSRSTools
{
    public abstract class Operation
    {
        abstract public object Calculate(object param1, object param2);
    }

    public class AND : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;
            if (Type.GetTypeCode(param1.GetType()) == TypeCode.Boolean && Type.GetTypeCode(param2.GetType()) == TypeCode.Boolean)
            {
                result = ((bool)param1) && ((bool)param2);
            }
            return result;
        }
    }
    public class OR : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;
            if (Type.GetTypeCode(param1.GetType()) == TypeCode.Boolean && Type.GetTypeCode(param2.GetType()) == TypeCode.Boolean)
            {
                result = ((bool)param1) || ((bool)param2);
            }
            return result;
        }
    }
    public class Less : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;
            if (Type.GetTypeCode(param2.GetType()) == TypeCode.DateTime && Type.GetTypeCode(param1.GetType()) == TypeCode.DateTime)
            {
                result = ((DateTime)param2).Date < ((DateTime)param1).Date ? true : false;
            }
            return result;
        }
    }

    public class LessEquals : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;
            if (Type.GetTypeCode(param2.GetType()) == TypeCode.DateTime && Type.GetTypeCode(param1.GetType()) == TypeCode.DateTime)
            {
                result = ((DateTime)param2).Date <= ((DateTime)param1).Date ? true : false;
            }
            return result;
        }
    }
    public class Greater : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;
            if (Type.GetTypeCode(param2.GetType()) == TypeCode.DateTime && Type.GetTypeCode(param1.GetType()) == TypeCode.DateTime)
            {
                result = ((DateTime)param2).Date > ((DateTime)param1).Date ? true : false;
            }
            return result;
        }
    }
    public class GreaterEquals : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;
            if (Type.GetTypeCode(param2.GetType()) == TypeCode.DateTime && Type.GetTypeCode(param1.GetType()) == TypeCode.DateTime)
            {
                result = ((DateTime)param2).Date >= ((DateTime)param1).Date ? true : false;
            }
            return result;
        }
    }
    public class Equals : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;

            if (Type.GetTypeCode(param2.GetType()) == TypeCode.DateTime && Type.GetTypeCode(param1.GetType()) == TypeCode.DateTime)
            {
                result = ((DateTime)param2).Date == ((DateTime)param1).Date ? true : false;
            }
            return result;
        }
    }
    public class Subtract : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;
            double value;
            switch (Type.GetTypeCode(param2.GetType()))
            {
                case TypeCode.DateTime:
                    switch (Type.GetTypeCode(param1.GetType()))
                    {
                        case TypeCode.Int16:
                        case TypeCode.Int32:
                        case TypeCode.Double:
                        case TypeCode.String:
                            bool isNumeric = Double.TryParse(param1.ToString(), out value);
                            if (isNumeric)
                            {
                                result = ((DateTime)param2).AddDays(value * -1);
                            }
                            break;
                    }
                    break;
                case TypeCode.Int16:
                case TypeCode.Int32:
                case TypeCode.String:
                    switch (Type.GetTypeCode(param1.GetType()))
                    {
                        case TypeCode.DateTime:
                            bool isNumeric = Double.TryParse(param2.ToString(), out value);
                            if (isNumeric)
                            {
                                result = ((DateTime)param1).AddDays(value * -1);
                            }
                            break;
                        case TypeCode.Int16:
                        case TypeCode.Int32:
                        case TypeCode.String:
                            result = int.Parse(param1.ToString()) - int.Parse(param2.ToString());
                            break;
                    }
                    break;
                case TypeCode.Decimal:
                    switch (Type.GetTypeCode(param1.GetType()))
                    {
                        case TypeCode.Decimal:
                            result = (decimal)param1 - (decimal)param2;
                            break;
                    }
                    break;
            }
            return result;
        }
    }
    public class Sum : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;
            double value;

            switch (Type.GetTypeCode(param2.GetType()))
            {
                case TypeCode.DateTime:
                    switch (Type.GetTypeCode(param1.GetType()))
                    {
                        case TypeCode.Int16:
                        case TypeCode.Int32:
                        case TypeCode.Double:
                        case TypeCode.String:
                            bool isNumeric = Double.TryParse(param1.ToString(), out value);
                            if (isNumeric)
                            {
                                result = ((DateTime)param2).AddDays(value);
                            }
                            break;
                    }
                    break;
                case TypeCode.String:
                case TypeCode.Int16:
                case TypeCode.Int32:
                    switch (Type.GetTypeCode(param1.GetType()))
                    {
                        case TypeCode.DateTime:
                            bool isNumeric = Double.TryParse(param2.ToString(), out value);
                            if (isNumeric)
                            {
                                result = ((DateTime)param1).AddDays(value);
                            }
                            break;
                        case TypeCode.Int16:
                        case TypeCode.Int32:
                        case TypeCode.String:
                            result = Decimal.Parse(param2.ToString()) + Decimal.Parse(param1.ToString());
                            break;
                    }
                    break;
            }
            return result;
        }
    }

    public class Multiply : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;

            switch (Type.GetTypeCode(param2.GetType()))
            {
                case TypeCode.String:
                    switch (Type.GetTypeCode(param1.GetType()))
                    {
                        case TypeCode.String:
                            result = Decimal.Parse(param2.ToString()) * Decimal.Parse(param1.ToString());
                            break;
                    }
                    break;
            }
            return result;
        }
    }

    public class Divide : Operation
    {
        public override object Calculate(object param1, object param2)
        {
            object result = null;

            switch (Type.GetTypeCode(param1.GetType()))
            {
                case TypeCode.String:
                    switch (Type.GetTypeCode(param2.GetType()))
                    {
                        case TypeCode.String:
                            result = Decimal.Parse(param1.ToString()) / Decimal.Parse(param2.ToString());
                            break;
                    }
                    break;
            }
            return result;
        }
    }
}