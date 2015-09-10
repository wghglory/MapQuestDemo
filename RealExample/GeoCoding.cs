using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.IO;
using System.Xml;
using System.Xml.XPath;
using System.Text;
using System.Data;
using System.Xml.Linq;

namespace RealExample
{
    public class GeoCoding
    {
        static string geocodeAddress = System.Configuration.ConfigurationManager.AppSettings["GeoCodeRequestAddress"];
        static string latPath = System.Configuration.ConfigurationManager.AppSettings["latXPath"];
        static string lngPath = System.Configuration.ConfigurationManager.AppSettings["lngXPath"];

        public GeoCoding() { }

        public static int getXMLGeoCoding(string address, string address2, string city, string state, string zip, out double longi, out double lat, out int confidence)
        {
            int callCount = 0;
            double longitutude = 999;
            double latitude = 999;
            bool fail = false;
            confidence = 100;
            do
            {
                string fullAddress = address + " " + address2 + ", " + city + ", " + state + " " + zip;
                string requestUri = geocodeAddress + fullAddress.Replace("&", "and");
                HttpWebRequest httpWebRequest = (HttpWebRequest)WebRequest.Create(requestUri);
                httpWebRequest.Method = WebRequestMethods.Http.Get;
                httpWebRequest.Accept = "application/xml";

                string xmlData = "";

                HttpWebResponse response = (HttpWebResponse)httpWebRequest.GetResponse();
                using (var sr = new StreamReader(response.GetResponseStream()))
                {
                    xmlData = sr.ReadToEnd();
                }
                callCount++;

                XmlDocument doc = new XmlDocument();
                doc.LoadXml(xmlData);

                XmlNode Node;

                Node = doc.SelectSingleNode(latPath);
                if (Node != null)
                    double.TryParse(Node.InnerText, out latitude);

                Node = doc.SelectSingleNode(lngPath);
                if (Node != null)
                    double.TryParse(Node.InnerText, out longitutude);

                if ((longitutude == 999 || latitude == 999) && address2 != "")
                {
                    address2 = "";
                    confidence -= 20;
                }
                else if ((longitutude == 999 || latitude == 999) && address != "")
                {
                    address = "";
                    confidence -= 20;
                }
                else if ((longitutude == 999 || latitude == 999) && city != "")
                {
                    city = "";
                    state = "";
                    confidence -= 40;
                }
                else if ((longitutude == 999 || latitude == 999) && address2 != "" && address != "" && city != "")
                {
                    fail = true;
                    confidence -= 20;
                }
            } while ((longitutude == 999 || latitude == 999) && fail == false);
            longi = longitutude;
            lat = latitude;

            return callCount;
        }

        public static double getGeoDistance(double lat1, double lon1, double lat2, double lon2, char unit = 'M')
        {
            double theta = lon1 - lon2;
            double dist = Math.Sin(degreeToRad(lat1)) * Math.Sin(degreeToRad(lat2)) + Math.Cos(degreeToRad(lat1)) * Math.Cos(degreeToRad(lat2)) * Math.Cos(degreeToRad(theta));
            dist = Math.Acos(dist);
            dist = radToDegree(dist);
            dist = dist * 60 * 1.1515;
            if (unit == 'K')
            {
                dist = dist * 1.609344;
            }
            else if (unit == 'N')
            {
                dist = dist * 0.8684;
            }
            return (dist);
        }

        private static double degreeToRad(double deg)
        {
            return (deg * Math.PI / 180.0);
        }

        private static double radToDegree(double rad)
        {
            return (rad / Math.PI * 180.0);
        }

        public static void GetLatLng(string fullAddress, out double latitude, out double longtitude)
        {
            double lat = 0;
            double lng = 0;
            string url = "http://maps.google.com/maps/api/geocode/xml?address=" + fullAddress + "&sensor=false";
            WebRequest request = WebRequest.Create(url);
            using (WebResponse response = (HttpWebResponse)request.GetResponse())
            {
                using (StreamReader reader = new StreamReader(response.GetResponseStream(), Encoding.UTF8))
                {
                    DataSet dsResult = new DataSet();
                    dsResult.ReadXml(reader);
                    foreach (DataRow row in dsResult.Tables["result"].Rows)
                    {
                        string geometry_id = dsResult.Tables["geometry"].Select("result_id = " + row["result_id"].ToString())[0]["geometry_id"].ToString();
                        DataRow location = dsResult.Tables["location"].Select("geometry_id = " + geometry_id)[0];
                        lat = Convert.ToDouble(location["lat"]);
                        lng = Convert.ToDouble(location["lng"]);
                    }

                    ////method 2: 
                    //string xmlData = reader.ReadToEnd();
                    //XmlDocument doc = new XmlDocument();
                    //doc.LoadXml(xmlData);
                    //XmlNode xnlat = doc.SelectSingleNode("GeocodeResponse/result/geometry/location/lat");
                    //XmlNode xnlng = doc.SelectSingleNode("GeocodeResponse/result/geometry/location/lng");

                    //lat = Convert.ToDouble(xnlat.InnerText);
                    //lng = Convert.ToDouble(xnlng.InnerText);
                }
            }

            latitude = lat;
            longtitude = lng;
        }

    }
}