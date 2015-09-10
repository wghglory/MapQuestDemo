<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="DemoMap.aspx.cs" Inherits="ShowingMultipleLocations.DemoMap" %>

<!DOCTYPE html>
<html>
<head>
    <style type="text/css">
        .mqabasicwnd-content {
            white-space: nowrap;
            font-weight: bold;
            font-size: 1.25em;
            color: #000000;
        }
    </style>

    <script src="http://open.mapquestapi.com/sdk/js/v7.2.s/mqa.toolkit.js?key=Fmjtd|luubn9082h%2C8g%3Do5-902wu6"></script>

    <script type="text/javascript">

        MQA.EventUtil.observe(window, 'load', function () {

            var options = {
                elt: document.getElementById('map'),             // ID of map element on page
                zoom: 10,                                        // initial zoom level of the map
                latLng: { lat: 39.743943, lng: -105.020089 }     // center of map in latitude/longitude
            };

            // construct an instance of MQA.TileMap with the options object
            window.map = new MQA.TileMap(options);

            // download the modules
            MQA.withModule('smallzoom', 'mousewheel', function () {
                map.addControl(new MQA.SmallZoom());
                map.enableMouseWheelZoom();
            });

            // setting the rollover content on hover and the info content on click
            var info1 = new MQA.Poi({ lat: 39.740115, lng: -104.984898 });
            info1.setRolloverContent('Rollover for Denver, CO');
            info1.setInfoContentHTML('Content for Denver, CO');

            var customIcon1 = new MQA.Icon('http://www.mapquestapi.com/staticmap/geticon?uri=poi-1.png', 20, 29);
            info1.setIcon(customIcon1);
            map.addShape(info1);

            // setting only the info content will display the HTML content in both the rollover and click windows
            var info2 = new MQA.Poi({ lat: 40.014981, lng: -105.269985 });
            info2.setInfoContentHTML('Rollover & Content for Boulder, CO');

            var customIcon2 = new MQA.Icon('http://www.mapquestapi.com/staticmap/geticon?uri=poi-2.png', 20, 29);
            info2.setIcon(customIcon2);
            map.addShape(info2);

            // setting only the rollover content
            var info3 = new MQA.Poi({ lat: 39.481706, lng: -106.037783 });
            info3.setRolloverContent('Rollover for Breckenridge, CO');

            var customIcon3 = new MQA.Icon('http://www.mapquestapi.com/staticmap/geticon?uri=poi-3.png', 20, 29);
            info3.setIcon(customIcon3);
            map.addShape(info3);

            map.bestFit();
        });

    </script>
</head>

<body>
    <div id='map' style='width: 750px; height: 280px;'></div>
</body>
</html>
