<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="MapWithBasicControls.aspx.cs" Inherits="MapByJavascript.MapWithBasicControls" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <%--load the SDK--%>
    <script src="http://open.mapquestapi.com/sdk/js/v7.2.s/mqa.toolkit.js?key=Fmjtd|luubn9082h%2C8g%3Do5-902wu6"></script>
    <script type="text/javascript">

        // An example of using the MQA.EventUtil to hook into the window load event and execute the defined
        // function passed in as the last parameter. You could alternatively create a plain function here and
        // have it executed whenever you like (e.g. <body onload="yourfunction">).

        MQA.EventUtil.observe(window, 'load', function () {

            // create an object for options
            var options = {
                elt: document.getElementById('map'),             // ID of map element on page
                zoom: 10,                                        // initial zoom level of the map
                latLng: { lat: 39.743943, lng: -105.020089 }     // center of map in latitude/longitude
            };

            // construct an instance of MQA.TileMap with the options object
            window.map = new MQA.TileMap(options);

            //// download the modules
            //MQA.withModule('smallzoom', 'mousewheel', function () {
            //    map.addControl(new MQA.SmallZoom());
            //    map.enableMouseWheelZoom();
            //});

            // create a POI by passing in a lat/lng object to the MQA.Poi constructor
            var basic = new MQA.Poi({ lat: 39.743943, lng: -105.020089 });

            // add POI to the map's default shape collection
            map.addShape(basic);

            // download the modules
            MQA.withModule('largezoom', 'viewoptions', 'geolocationcontrol', 'insetmapcontrol', 'mousewheel', function () {

                // add the Large Zoom control
                map.addControl(
                    new MQA.LargeZoom(),
                    new MQA.MapCornerPlacement(MQA.MapCorner.TOP_LEFT, new MQA.Size(5, 5))
                );

                // add the Map/Satellite toggle button
                map.addControl(new MQA.ViewOptions());

                // add the Geolocation button
                map.addControl(
                    new MQA.GeolocationControl(),
                    new MQA.MapCornerPlacement(MQA.MapCorner.TOP_RIGHT, new MQA.Size(10, 50))
                );

                // add the small Inset Map with custom options
                map.addControl(
                    new MQA.InsetMapControl({
                        size: { width: 150, height: 125 },
                        zoom: 3,
                        mapType: 'map',
                        minimized: true
                    }),
                    new MQA.MapCornerPlacement(MQA.MapCorner.BOTTOM_RIGHT)
                );

                // enable zooming with your mouse
                map.enableMouseWheelZoom();

            });

        });

    </script>
</head>

<body>
    <div id="map" style="width: 750px; height: 280px;"></div>
</body>
</html>
