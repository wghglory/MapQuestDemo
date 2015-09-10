<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="GetGeoCode.aspx.cs" Inherits="MapByJavascript.GetGeoCode" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <script src="http://open.mapquestapi.com/sdk/js/v7.1.s/mqa.toolkit.js?key=Kmjtd%7Cluua2qu7n9%2C7a%3Do5-lzbgq"></script>
    <script type="text/javascript">

        MQA.EventUtil.observe(window, 'load', function () {

            var options = {
                elt: document.getElementById('map'),             // ID of map element on page
                zoom: 10,                                        // initial zoom level of the map
                latLng: { lat: 38.892088, lng: -77.01993}       // center of map in latitude/longitude
            };

            // construct an instance of MQA.TileMap with the options object
            window.map = new MQA.TileMap(options);

            // download the modules
            MQA.withModule('geocoder', 'smallzoom', 'mousewheel', function () {

                map.addControl(new MQA.SmallZoom());
                map.enableMouseWheelZoom();

                // passes an array of locations to be geocoded and a function to be called when geocoding is complete
                map.geocodeAndAddLocations([
                        'washington dc',
                        { street: '1600 pennsylvania ave nw', postalCode: '20500' }
                    ], processRawData);

                // show the raw data of the geocoded locations
                function processRawData(response) {
                    var html = '';
                    var i = 0;
                    var j = 0;

                    if (response.results.length > 0 && response.results[0].locations.length > 0) { // location ambiguities
                        html = '<table>';

                        for (i = 0; i < response.results.length; i++) {
                            html += '<tr><td colspan="2"><b>Location ' + (i + 1) + '</b></td></tr>';

                            // if more than one location was found, there was not a good match for the supplied input
                            for (j = 0; j < response.results[i].locations.length; j++) {
                                var location = response.results[i].locations[j];
                                html += '<tr><td>';
                                html += ' ' + (location.street || ' ');
                                html += ' ' + (location.adminArea5 || ' ');
                                html += ' ' + (location.adminArea4 || ' ');
                                html += ' ' + (location.adminArea3 || ' ');
                                html += ' ' + (location.adminArea2 || ' ');
                                html += ' ' + (location.postalCode || ' ');
                                html += ' ' + (location.adminArea1 || ' ');
                                html += 'Lat: ' + location.latLng.lat + "   Lng: " + location.latLng.lng;
                                html += '<br />';
                                html += '<i>Geocode Quality: ' + (location.geocodeQualityCode) + '</i>';
                                html += '</td>';

                                if (location.mapUrl) {
                                    html += '<td>';
                                    html += '<img src="' + location.mapUrl + '"/>';
                                    html += '</td>';
                                }
                                html += '</tr>';
                            }
                        }

                        html += '</table>';
                        document.getElementById('rawData').innerHTML = html;
                        return;
                    }

                    if (response.info.messages) {
                        html += '<br><b>Errors:</b><br>';
                        for (i = 0; i < response.info.messages.length; i++) {
                            html += response.info.messages[i] + '<br>';
                        }
                    }

                    document.getElementById('rawData').innerHTML = html;
                }
            });
        });

    </script>
</head>
<body>
    <div id='map' style='width: 750px; height: 280px;'>
    </div>
    <div id='rawData' style="width: 820px;">
    </div>
</body>
</html>
