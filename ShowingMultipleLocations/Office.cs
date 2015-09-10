using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ShowingMultipleLocations
{
    public class Office
    {
        private double _lat;
        private double _lng;
        private string _name;

        public string Name
        {
            get { return _name; }
            set { _name = value; }
        }

        public double Lng
        {
            get { return _lng; }
            set { _lng = value; }
        }

        public double Lat
        {
            get { return _lat; }
            set { _lat = value; }
        }
    }
}