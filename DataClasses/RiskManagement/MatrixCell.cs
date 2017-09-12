using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace QMSRSTools
{
    public class MatrixCell
    {
        //X indicates a row in the matrix
        //Y indicates a column in the matrix
        private int _x;
        private int _y;

        private object _value;

        private RecordsStatus _status;

        public MatrixCell(int px, int py, object v, RecordsStatus status)
        {
            this._x = px;
            this._y = py;
            this._value = v;
        
            this._status = status;
        }


        public MatrixCell(int px, int py,object v)
        {
            this._x = px;
            this._y = py;
            this._value = v;
         
            this.Status = RecordsStatus.ORIGINAL;
        }

        //parameterless constructor
        public MatrixCell()
        {
            this.Status = RecordsStatus.ORIGINAL;
        }
        public int X
        {
            get
            {
                return _x;
            }
            set
            {
                _x = value;
            }
        }

        public int Y
        {
            get
            {
                return _y;
            }
            set
            {
                _y = value;
            }
        }

        public RecordsStatus Status
        {
            get
            {
                return _status;
            }
            set
            {
                _status = value;
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
    }
}