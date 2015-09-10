<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoadMapsFromDatabase.aspx.cs"
    Inherits="RealExample.LoadMapsFromDatabase" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <script type="text/javascript" src="http://open.mapquestapi.com/sdk/js/v7.2.s/mqa.toolkit.js?key=Fmjtd|luubn9082h%2C8g%3Do5-902wu6"></script>
    <script type="text/javascript" src="js/jquery-1.11.1.js"></script>
    <script type="text/javascript">
            $(function() {
                var options = {
                    elt: document.getElementById('map'), // ID of map element on page
                    zoom: 10, // initial zoom level of the map
                    //latLng: { lat: 39.743943, lng: -105.020089 }     // center of map in latitude/longitude
                };

                // construct an instance of MQA.TileMap with the options object
                window.map = new MQA.TileMap(options);

                //download the modules
                MQA.withModule('smallzoom', 'mousewheel', function() {
                    map.addControl(new MQA.SmallZoom());
                    map.enableMouseWheelZoom();
                });
   var offices = <%= this.javaSerial.Serialize(this.officesInMap) %> ; //Here right!
                for (var i = 0; i < offices.length; i++) {
                    var name = offices[i].Name;
                    var lat = offices[i].Latitude;
                    var lng = offices[i].Longtitude;
                    var office = new MQA.Poi({
                        'lat': lat,
                        'lng': lng
                    });
                    office.setRolloverContent(name);
                    office.setInfoContentHTML(name);
                    //office.setDeclutterMode(true);

                    var customIcon = new MQA.Icon('http://www.mapquestapi.com/staticmap/geticon?uri=poi-' + (i + 1) + '.png', 20, 29);
                    office.setIcon(customIcon);
                    map.addShape(office); // add POIs to the map's default shape collection
                }
                map.bestFit();
                
            });
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div id='map' style='width: 480px; height: 400px;'>
    </div>
    </form>
</body>
</html>
