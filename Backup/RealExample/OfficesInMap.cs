using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RealExample
{
    public class OfficesInMap
    {
        private string name;
        private double latitude;
        private double longtitude;

        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        public double Longtitude
        {
            get { return longtitude; }
            set { longtitude = value; }
        }

        public double Latitude
        {
            get { return latitude; }
            set { latitude = value; }
        }
    }
}