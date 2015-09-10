using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Script.Serialization;
using System.Data;
using System.Data.SqlClient;

namespace RealExample
{
    public partial class LoadMapsFromDatabase : System.Web.UI.Page
    {
        string connString = System.Configuration.ConfigurationManager.AppSettings["PMConnString"];
        protected List<OfficesInMap> officesInMap;    //method 1,2

        protected JavaScriptSerializer javaSerial = new JavaScriptSerializer();

        protected void Page_Load(object sender, EventArgs e)
        {
            List<OfficesInMap> officesWithGeoInfos = new List<OfficesInMap>();
            List<OfficeListItem> offices = GetOfficesForMap(3, connString);

            foreach (OfficeListItem office in offices)
            {
                OfficesInMap officeWithGeo = new OfficesInMap();
                officeWithGeo.Name = office.Name;
                officeWithGeo.Latitude = office.Latitude;
                officeWithGeo.Longtitude = office.Longtitude;
                officesWithGeoInfos.Add(officeWithGeo);
            }
            officesInMap = officesWithGeoInfos;

        }

        public static List<OfficeListItem> GetOfficesForMap(int panelID, string connString)
        {
            List<OfficeListItem> offices = new List<OfficeListItem>();
            string sql = "SELECT * FROM Panel P JOIN PanelOfficeMapping POM ON P.Panel_ID = POM.Panel_ID JOIN Office O ON POM.Office_ID = O.Office_ID JOIN Geocode GC ON O.Office_ID = GC.Office_ID WHERE P.Panel_ID = @panelId";
            using (SqlDataReader reader = DatabaseConnection.ExecuteReader(sql, CommandType.Text, connString, new SqlParameter("@panelId", panelID)))
            {
                if (reader.HasRows)
                {
                    int officeNameIndex = reader.GetOrdinal("OfficeName");
                    int latIndex = reader.GetOrdinal("latitude");
                    int lngIndex = reader.GetOrdinal("longitude");
                    while (reader.Read())
                    {
                        OfficeListItem office = new OfficeListItem();
                        office.Name = reader.GetString(officeNameIndex);
                        office.Latitude = reader.GetDouble(latIndex);
                        office.Longtitude = reader.GetDouble(lngIndex);
                        offices.Add(office);
                    }
                }
            }
            return offices;
        }
    }
}