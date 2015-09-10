<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BasicMap.aspx.cs" Inherits="MapByJavascript.BasicMap" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--load the SDK--%>
    <script src="http://open.mapquestapi.com/sdk/js/v7.2.s/mqa.toolkit.js?key=Fmjtd|luubn9082h%2C8g%3Do5-902wu6"></script>

    <script type="text/javascript">
        var APP_KEY = 'Fmjtd|luubn9082h%2C8g%3Do5-902wu6';
        // An example of using the MQA.EventUtil to hook into the window load event and execute the defined
        // function passed in as the last parameter. You could alternatively create a plain function here and
        // have it executed whenever you like (e.g. <body onload="yourfunction">).

        MQA.EventUtil.observe(window, 'load', function () {

            // create an object for options
            var options = {
                elt: document.getElementById('map'),           // ID of map element on page
                zoom: 10,                                      // initial zoom level of the map
                latLng: { lat: 39.743943, lng: -105.020089 },  // center of map in latitude/longitude
                mtype: 'map',                                  // map type (map, sat, hyb); defaults to map
                bestFitMargin: 0,                              // margin offset from map viewport when applying a bestfit on shapes
                zoomOnDoubleClick: true                        // enable map to be zoomed in when double-clicking on map
            };

            // construct an instance of MQA.TileMap with the options object
            window.map = new MQA.TileMap(options);
        });

    </script>
    <title></title>
</head>
<body>
    <form id="form1" runat="server">
        <div id="map" style="width: 1000px; height: 400px;"></div>
    </form>
</body>
</html>
