using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace RealExample
{
    [Serializable]
    public class OfficeListItem
    {
        private bool selected;
        private int iD;
        private string name;
        private string address1;
        private string address2;
        private string city;
        private string state;
        private string zip;
        private string phone;
        private double distance;
        private string discount;
        private string specialty;
        private int specialtyID;
        private int parentProviderID;
        private string parentProviderTin;
        private string parentProviderAddress;
        private List<int> panelIDs;
        private List<int> specialtyIDs;
        private string notes;
        private bool upmcOwnedOffice;

        private double latitude;
        private double longtitude;

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

        public bool UPMCOwnedOffice
        {
            get { return upmcOwnedOffice; }
            set { upmcOwnedOffice = value; }
        }

        public string Notes
        {
            get { return notes; }
            set { notes = value; }
        }

        public List<int> SpecialtyIDs
        {
            get { return specialtyIDs; }
            set { specialtyIDs = value; }
        }

        public List<int> PanelIDs
        {
            get { return panelIDs; }
            set { panelIDs = value; }
        }

        public int SpecialtyID
        {
            get { return specialtyID; }
            set { specialtyID = value; }
        }

        public string Discount
        {
            get { return discount; }
            set { discount = value; }
        }

        public int ParentProviderID
        {
            get { return parentProviderID; }
            set { parentProviderID = value; }
        }

        public string ParentProviderTin
        {
            get { return parentProviderTin; }
            set { parentProviderTin = value; }
        }

        public string ParentProviderAddress
        {
            get { return parentProviderAddress; }
            set { parentProviderAddress = value; }
        }


        public bool Selected
        {
            get { return selected; }
            set { selected = value; }
        }

        public int ID
        {
            get { return iD; }
            set { iD = value; }
        }

        public string Name
        {
            get { return name; }
            set { name = value; }
        }

        public string Address1
        {
            get { return address1; }
            set { address1 = value; }
        }

        public string Address2
        {
            get { return address2; }
            set { address2 = value; }
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

        public string Zip
        {
            get { return zip; }
            set { zip = value; }
        }

        public string Phone
        {
            get { return phone; }
            set { phone = value; }
        }

        public double Distance
        {
            get { return distance; }
            set { distance = value; }
        }

        public string Specialty
        {
            get { return specialty; }
            set { specialty = value; }
        }

        public string FullAddress
        {
            get
            {
                return address1 + (String.IsNullOrEmpty(address2) ? "" : "<br />" + address2) + "<br />" + city + "  " + state + " " + zip;
            }
        }
    }
}
