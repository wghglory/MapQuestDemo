using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ShowingMultipleLocations
{
    public partial class FrontBackDataTransfer : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            List<Office> offices = new List<Office>()
            {
                new Office{Name="Denver",Lat= 39.740115, Lng=-104.984898},
                new Office{Name="Boulder", Lat=40.014981,Lng=-105.269985},
                new Office{Name="Breckenridge",Lat=39.481706,Lng=-106.037783}
            };

            JavaScriptSerializer ser = new JavaScriptSerializer();
            hfOffices.Value = ser.Serialize(offices);
        }

        public string[] names = { "John", "Pesho", "Maria" };
        public JavaScriptSerializer javaSerial = new JavaScriptSerializer();
    }
}