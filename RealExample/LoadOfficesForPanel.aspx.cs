using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Web.Script.Serialization;
using System.Text.RegularExpressions;
using System.Diagnostics;

namespace RealExample
{
    public partial class LoadOfficesForPanel : System.Web.UI.Page
    {
        string connString = System.Configuration.ConfigurationManager.AppSettings["PMConnString"];
        protected List<OfficesInMap> officesInMap;    //method 1,2
        //protected List<OfficeListItem> officesInMap;     //method 3
        //protected List<OfficesWithNameAddress> officesInMap;   //method 3
        protected JavaScriptSerializer javaSerial = new JavaScriptSerializer();
        //protected string officesInMap;   //method 4

        protected void Page_Load(object sender, EventArgs e)
        {
            //=======================method 1, 2: use c# code to get lat, lng:===================================
            double lng;
            double lat;
            //int confidence;

            List<OfficeListItem> offices = new List<OfficeListItem>();
            List<OfficesInMap> officesWithGeoInfos = new List<OfficesInMap>();
            offices = getOfficesForPanel(4020, connString);

            foreach (OfficeListItem office in offices)
            {
                string address = office.Address1;
                string address2 = office.Address2;
                string city = office.City;
                string state = office.State;
                string zip = office.Zip;

                string fullAddress = address + ", " + city + ", " + state + ", " + zip;
                //GeoCoding.getXMLGeoCoding(address, address2, city, state, zip, out lng, out lat, out confidence); //time consuming
                GeoCoding.GetLatLng(fullAddress, out lat, out lng);  //my google map geocode
                OfficesInMap officeWithGeo = new OfficesInMap();
                officeWithGeo.Name = office.Name;
                officeWithGeo.Latitude = lat;
                officeWithGeo.Longtitude = lng;
                officesWithGeoInfos.Add(officeWithGeo);
            }
            officesInMap = officesWithGeoInfos;

            //=============method 3: use MapQuest to get lat, lng: some address cannot find lat/lng==============

            //List<OfficeListItem> officesAllDetail = getOfficesForPanel(4020, connString);
            //List<OfficesWithNameAddress> offices2Map = new List<OfficesWithNameAddress>();
            //foreach (OfficeListItem office in officesAllDetail)
            //{
            //    OfficesWithNameAddress officewithNameAddr = new OfficesWithNameAddress();
            //    officewithNameAddr.Name = office.Name;
            //    string street = office.Address1;

            //    //string text = "841 Hospital Road, Suite 2100";
            //    //bool a = Regex.IsMatch(text, @"(.*Road|Street|St|Avenue).*");
            //    string newstreet = Regex.Match(street, @"(.*((Road)|(Street)|(Avenue)|(Lane)|(Drive))).*").Groups[1].Value;
            //    officewithNameAddr.Street = newstreet;

            //    officewithNameAddr.City = office.City;
            //    officewithNameAddr.State = office.State;
            //    officewithNameAddr.PostalCode = office.Zip;
            //    offices2Map.Add(officewithNameAddr);

            //}
            ////offices2Map.RemoveAt(5); offices2Map.RemoveAt(4); offices2Map.RemoveAt(4);
            //officesInMap = offices2Map;

            //=====================method 4: use MapQuest to get lat, lng:====================

            //List<OfficeListItem> offices = new List<OfficeListItem>();
            //List<OfficesWithNameAddress> officesWithNameAddress = new List<OfficesWithNameAddress>();
            //offices = getOfficesForPanel(3505, connString);
            //foreach (OfficeListItem office in offices)
            //{
            //    OfficesWithNameAddress officewithNameAddr = new OfficesWithNameAddress();
            //    officewithNameAddr.Name = office.Name;

            //    officewithNameAddr.Street = office.Address1;

            //    officewithNameAddr.City = office.City;
            //    officewithNameAddr.State = office.State;
            //    officewithNameAddr.PostalCode = office.Zip;
            //    officesWithNameAddress.Add(officewithNameAddr);
            //}

            //JavaScriptSerializer javaSerial = new JavaScriptSerializer();
            //string officesJson = javaSerial.Serialize(officesWithNameAddress);
            //officesInMap = officesJson.Replace("\"Street\"", "street").Replace("\"City\"", "city").Replace("\"State\"", "state").Replace("\"PostalCode\"", "postalCode").Replace("\"Name\"", "name");

        }




        public static List<OfficeListItem> getOfficesForPanel(int panelID, string connString, double latitude = 999, double longitude = 999)
        {
            List<OfficeListItem> offices = new List<OfficeListItem>();
            DataSet dataSet = new DataSet();

            try
            {
                using (DatabaseConnection dbConn = new DatabaseConnection(connString))
                {
                    dbConn.AddParameter("@PANELID", panelID, ParameterDirection.Input);
                    if (longitude != 999) dbConn.AddParameter("@LNG", longitude, ParameterDirection.Input);
                    if (latitude != 999) dbConn.AddParameter("@LAT", latitude, ParameterDirection.Input);
                    dbConn.GetData("PM_GetOfficeListFromPanel", CommandType.StoredProcedure, "Office", ref dataSet);
                    dbConn.ClearParameters();

                    foreach (DataRow dr in dataSet.Tables["Office"].Rows)
                    {
                        OfficeListItem office = new OfficeListItem();
                        office.ID = (int)dr["Office_ID"];
                        office.Name = dr["OfficeName"] is DBNull ? "" : (string)dr["OfficeName"];
                        office.Address1 = dr["Address1"] is DBNull ? "" : (string)dr["Address1"];
                        office.Address2 = dr["Address2"] is DBNull ? "" : (string)dr["Address2"];
                        office.Phone = dr["PhoneNumber"] is DBNull ? "" : (string)dr["PhoneNumber"];
                        office.City = dr["City"] is DBNull ? "" : (string)dr["City"];
                        office.State = dr["State"] is DBNull ? "" : (string)dr["State"];
                        office.Zip = dr["Zip"] is DBNull ? "" : (string)dr["Zip"];
                        office.ParentProviderID = dr["provider_ID"] is DBNull ? -1 : (int)dr["provider_ID"];
                        office.ParentProviderTin = dr["TIN"] is DBNull ? "" : (string)dr["TIN"];
                        office.ParentProviderAddress = dr["BillingAddress"] is DBNull ? "" : (string)dr["BillingAddress"];
                        office.Distance = dr["Distance"] is DBNull ? -1 : Convert.ToDouble((string)dr["Distance"]);

                        office.Discount = dr["Amount"] is DBNull ? "-1" : Convert.ToString(dr["Amount"]);
                        if (office.Discount != "-1" && office.Discount != "0")
                            office.Discount = "Yes";
                        else
                            office.Discount = "No";

                        dbConn.AddParameter("@OFFICEID", office.ID, ParameterDirection.Input);
                        DataSet ds = new DataSet();
                        dbConn.GetData("PM_GetOfficeSpecialty", CommandType.StoredProcedure, "specialty", ref ds);
                        foreach (DataRow row in ds.Tables["specialty"].Rows)
                        {
                            office.Specialty = office.Specialty + "," + (row["specialty"] is DBNull ? "" : (string)row["specialty"]);
                        }
                        if (office.Specialty != null)
                            office.Specialty = office.Specialty.Substring(1);

                        dbConn.ClearParameters();

                        offices.Add(office);
                    }
                }
            }
            catch
            {
                throw;
            }
            return offices;
        }



    }
}