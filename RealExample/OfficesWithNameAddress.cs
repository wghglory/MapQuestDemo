﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace RealExample
{
    [Serializable]
    public class OfficesWithNameAddress
    {
        private string name;
        private string street;
        private string city;
        private string state;
        private string postalCode;

       

        public string Street
        {
            get { return street; }
            set { street = value; }
        }

        public string Name
        {
            get { return name; }
            set { name = value; }
        }


        public string City
        {
            get { return city; }
            set { city = value; }
        }

        public string State
        {
            get { return state; }
            set { state = value; }
        }

        public string PostalCode
        {
            get { return postalCode; }
            set { postalCode = value; }
        }


    }
}