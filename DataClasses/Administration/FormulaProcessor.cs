/* Reference Dynamic Formula Processing Library, Derek Bartram, http://www.codeproject.com/Articles/25578/Dynamic-Formula-Processing-Library*/

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Collections;

namespace QMSRSTools
{
    public class FormulaProcessor
    {
        private string _prefix;

        public FormulaProcessor(List<string> tokens)
        {
            this._prefix = getPrefixNotation(tokens);
        }

        /*
         * 1. Reverse the input string.
         * 2. Examine the next element in the input.
         * 3. If it is operand, add it to output string.
         * 4. If it is Closing parenthesis, push it on stack.
         * 5. If it is an operator, then
         *    5.1  If stack is empty, push operator on stack.
         *    5.2  If the top of stack is closing parenthesis, push operator on stack.
         *    5.3  If it has same or higher priority than the top of stack, push operator on stack.
         *    5.4  Else pop the operator from the stack and add it to output string, repeat step 5.
         * 6. If it is a opening parenthesis, pop operators from stack and add them to output string until a closing parenthesis is encountered. Pop and discard the closing parenthesis.
         * 7. If there is more input go to step 2.
         * 8. If there is no more input, unstack the remaining operators and add them to output string.
         * 9. Reverse the output string.
         */

        public string getPrefixNotation(List<string> tokens)
        {           
            string reversedinput = string.Empty;

            Stack s = new Stack();
 
            for (int i=tokens.Count()-1 ;i>=0; i--)
            {
                string token = tokens[i];

                if (token == ")")
                {
                    s.Push(token);
                }
                else if (token == "(")
                {
                    try
                    {
                        while (s.Peek().ToString().Equals(")") != true)
                        {
                            reversedinput = s.Pop().ToString() + " " + reversedinput;
                        }
                    }
                    catch (Exception)
                    {
                        throw new Exception("Missing ) in formula");
                    }
                }
                else if (isOperator(token))
                {
                    if (s.Count > 0)
                    {
                        int topValue = operatorRank(s.Peek().ToString());
                        int tokenValue = operatorRank(token);
                        if (tokenValue < topValue)
                        {
                            while (s.Count > 0 && s.Peek().Equals(")") != true)
                            {
                                reversedinput = s.Pop().ToString() + " " + reversedinput;
                            }

                            s.Push(token);
                        }
                        else
                        {
                            s.Push(token);
                        }
                    }
                    else
                    {
                        s.Push(token);
                    }
                }

                else
                {
                    reversedinput = token + " " + reversedinput;
                }
            }

            while (s.Count > 0)
            {
                if (s.Peek().Equals(")") != true)
                {
                    reversedinput = s.Pop().ToString() + " " + reversedinput;
                }
                else
                {
                    s.Pop(); //discard )
                }
            }

           return reversedinput;
        }

        public object processFormula()
        {
            List<string> tokens = _prefix.Split(' ').ToList();

            Stack s = new Stack();
 
            for (int i = tokens.Count() - 1; i >= 0; i--)
            {
                string token = tokens[i];

                if (token.ToString() == " " || token.ToString() == string.Empty)
                    continue;

                if (isOperator(token))
                {
                    object operand1 = s.Pop();
                    object operand2 = s.Pop();

                    object result = resolveOperation(operand1, operand2, token.Trim());

                    s.Push(result.ToString());
                }
                else
                {
                    s.Push(token);
                }
            }

            return s.Pop();
        }

        private object resolveOperation(object param1, object param2, string operation)
        {
            Operation obj;

            object result = 0;

            switch (operation)
            {
                case "+":
                    obj = new Sum();
                     result=obj.Calculate(param1, param2);
                    break;
                case "-":
                    obj = new Subtract();
                    result = obj.Calculate(param1, param2);
                    break;
                case "=":
                    obj = new Equals();
                    result = obj.Calculate(param1, param2);
                    break;
                case ">=":
                    obj = new GreaterEquals();
                    result = obj.Calculate(param1, param2);
                    break;
                case ">":
                    obj = new Greater();
                    result = obj.Calculate(param1, param2);
                    break;
                case "<":
                    obj = new Less();
                    result = obj.Calculate(param1, param2);
                    break;
                case "<=":
                    obj = new LessEquals();
                    result = obj.Calculate(param1, param2);
                    break;
                case "AND":
                    obj = new AND();
                    result = obj.Calculate(param1, param2);
                    break;
                case "OR":
                    obj = new OR();
                    result = obj.Calculate(param1, param2);
                    break;
                case "*":
                    obj = new Multiply();
                    result = obj.Calculate(param1, param2);
                    break;
                case "/":
                    obj = new Divide();
                    result = obj.Calculate(param1, param2);
                    break;
            }

            return result;
        }

        private int operatorRank(string value)
        {
            if (value == "-")
            {
                return 0;
            }
            else if (value == "+")
            {
                return 1;
            }
            else if (value == "*")
            {
                return 2;
            }
            else if (value == "/")
            {
                return 3;
            }
            else if (value == "^")
            {
                return 4;
            }
            else if (value == ")")
            {
                return 5;
            }
            else if (value == "(")
            {
                return 6;
            }
            else
            {
                throw new Exception("Unknown Operator");
            }
        }

        private bool isOperator(string token)
        {
            bool _isoperator = false;

            switch (token.ToString())
            {
                case "+":
                case "-":
                case "*":
                case "/":
                    _isoperator = true;
                    break;
            }

            return _isoperator;
        }
    }
}