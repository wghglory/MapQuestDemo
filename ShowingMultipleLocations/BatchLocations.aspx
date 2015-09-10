<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BatchLocations.aspx.cs"
    Inherits="ShowingMultipleLocations.BatchLocations" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<head>
    <script src="http://open.mapquestapi.com/sdk/js/v7.1.s/mqa.toolkit.js?key=Fmjtd|luubn9082h%2C8g%3Do5-902wu6"></script>
    <script type="text/javascript">
            MQA.EventUtil.observe(window, 'load', function() {

                var options = {
                    elt: document.getElementById('map'), // ID of map element on page
                    zoom: 10, // initial zoom level of the map
                    //latLng: { lat: 38.892088, lng: -77.01993}       // center of map in latitude/longitude
                };

                // construct an instance of MQA.TileMap with the options object
                window.map = new MQA.TileMap(options);

                // download the modules
                MQA.withModule('geocoder', 'smallzoom', 'mousewheel', function() {

                    map.addControl(new MQA.SmallZoom());
                    map.enableMouseWheelZoom();

                    // override the POI construction function to customize the Rollover and InfoWindow states
                    MQA.Geocoder.constructPOI = function(location) {
                        var lat = location.latLng.lat,
                            lng = location.latLng.lng,
                            street = location.street,
                            city = location.adminArea5,
                            state = location.adminArea3,
                            p = new MQA.Poi({
                                lat: lat,
                                lng: lng
                            });

                        p.setRolloverContent('<div style="white-space: nowrap">' + street + ', ' + city + ', ' + state + '</div>');
                        p.setInfoTitleHTML(p.getRolloverContent());
                        p.setInfoContentHTML('<div style="white-space: nowrap">' + street + ', ' + city + ', ' + state + '<br />LatLng: ' + lat + ', ' + lng + '</div>');

                        return p;
                    };

                    // executes a geocode and adds the result to the map
                    map.geocodeAndAddLocations([
                        'washington dc', {
                            street: '29 oakville ct',
                            city: 'Pittsburgh',
                            state: 'PA',
                            postalCode: '15220'
                        }, {
                            street: '600 Grant Street',
                            city: 'Pittsburgh',
                            state: 'PA',
                            postalCode: '15219'
                        }
                    ]);
                });
            });
    </script>
</head>
<body>
    <div id='map' style='width: 750px; height: 280px;'>
    </div>
</body>
</html>
