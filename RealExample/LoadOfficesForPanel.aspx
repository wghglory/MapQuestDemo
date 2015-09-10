<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoadOfficesForPanel.aspx.cs"
    Inherits="RealExample.LoadOfficesForPanel" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <script type="text/javascript" src="http://open.mapquestapi.com/sdk/js/v7.2.s/mqa.toolkit.js?key=Fmjtd|luubn9082h%2C8g%3Do5-902wu6"></script>
    <script type="text/javascript" src="js/jquery-1.11.1.js"></script>
    <script src="js/json2.js" type="text/javascript"></script>
    <script src="js/batch.js" type="text/javascript"></script>
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


//==========method 1: store c# list into hidden field, NEED LAT/LNG AS PARAMETER============================  
                //            var offices = eval($("#hfOffices").val());

                //            $.each(offices, function (i, item) {
                //                var name = offices[i].Name;
                //                var lat = offices[i].Lat;
                //                var lng = offices[i].Lng;
                //                var office = new MQA.Poi({ 'lat': lat, 'lng': lng });
                //                office.setRolloverContent(name);
                //                office.setInfoContentHTML(name);
                //                //office.setDeclutterMode(true);

                //                var customIcon = new MQA.Icon('http://www.mapquestapi.com/staticmap/geticon?uri=poi-' + (i+1) + '.png', 20, 29);
                //                office.setIcon(customIcon);
                //                map.addShape(office);  // add POIs to the map's default shape collection
                //            })
                //map.bestFit();


//======method 2: create public/protected fields, I like this better. NEED LAT/LNG AS PARAMETER==============================================

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


//=======================================method 3: get lat/lng from mapquest============================================
//                            //NOT WORKING, RESPONSE BACK and get the last location....idea 1!
//                                var lat;
//                                var lng;
//                                var name;
//                                var offices = <%= this.javaSerial.Serialize(this.officesInMap) %> ;

//                                for (var i = 0; i < offices.length; i++) {
//                                    showOptionsURL(offices[i]);
//                                }

//                                function showOptionsURL(office) {
//                                    requestUrl = 'http://open.mapquestapi.com/geocoding/v1/address?key=YOUR_KEY_HERE'; //&callback=renderOptions';

//                                    //            var street = "29 oakville ct";
//                                    //            var city = "pittsburgh"
//                                    //            var state = "PA";
//                                    //            var postalCode = 15220;  
//                                   
//                                        name = office.Name;
//                                        var street = office.Address1 + " " + office.Address2;
//                                        var city = office.City;
//                                        var state = office.State;
//                                        var postalCode = office.Zip;

//                                        //json={"location":{"street": "1090 N Charlotte St","city":"Lancaster","state":"PA","postalCode":"17603"}}
//                                        requestUrl += '&outFormat=json';
//                                        requestUrl += '&inFormat=json';
//                                        requestUrl += "&json=";
//                                        var jsonText = '{';
//                                        jsonText += '"location":{"street":"';
//                                        jsonText += (street + '",');
//                                        jsonText += ('"city":"' + city + '",');
//                                        jsonText += ('"state":"' + state + '",');
//                                        jsonText += ('"postalCode":"' + postalCode);
//                                        jsonText += '"}}';
//                                        requestUrl += jsonText;
//                                        requestUrl = requestUrl.replace('YOUR_KEY_HERE', 'Fmjtd|luubn9082h%2C8g%3Do5-902wu6'); //APP_KEY

//                                        $.ajax({
//                                            url: requestUrl,
//                                            type: "post",
//                                            cache: false, //强迫当前请求必须去后台拿数据，不能用客户端缓存。
//                                            success: renderOptions,
//                                            dataType: "json",
//                                            async:false
//                                        });
//                                    
//                                };

//                                //RETURN THE LAST LOCATION...
//                                function renderOptions(response) {
//                                    if (response.info.statuscode && (response.info.statuscode != 200)) {
//                                        alert("Whoops!  There was an error during the request:\n");
//                                        return;
//                                    }

//                                    var locations = response.results[0].locations;
//                                    //            if (locations.length > 1) { // Location ambiguities!
//                                    //                alert("Ambiguous addresses found in request");
//                                    //              
//                                    //            }

//                                    if(locations==null) return;

//                                    var location = locations[0];
//                                    lat = location.latLng.lat;
//                                    lng = location.latLng.lng;

//                                    alert(lng);

//                                    var office = new MQA.Poi({
//                                        'lat': lat,
//                                        'lng': lng
//                                    });
//                                    office.setRolloverContent(name);
//                                    office.setInfoContentHTML(name);
//                                    //office.setDeclutterMode(true);

//                                    var customIcon = new MQA.Icon('http://www.mapquestapi.com/staticmap/geticon?uri=poi-' + (1) + '.png', 20, 29);
//                                    office.setIcon(customIcon);
//                                    map.addShape(office); // add POIs to the map's default shape collection
//                                    map.bestFit();
//                                    return;
//                            
//                                }
//                                map.bestFit();

//=========================method 3: get lat/lng from mapquest, working============================================
//          
//                                var lat;
//                                var lng;
//                                var name;                         
//                                showOptionsURL();

//                                function showOptionsURL(office) {
//                                    

//                                    var offices = <%= this.javaSerial.Serialize(this.officesInMap) %> ;
//                                     
//                                    for (var i = 0; i < offices.length; i++) {
//                                        name = offices[i].Name;
//                                        var street = offices[i].Street;   //.Address1;
//                                        var city = offices[i].City;
//                                        var state = offices[i].State;
//                                        var postalCode = offices[i].PostalCode   //.Zip;

//                                        requestUrl = 'http://open.mapquestapi.com/geocoding/v1/address?key=YOUR_KEY_HERE'; //&callback=renderOptions';
//                                        //json={"location":{"street": "1090 N Charlotte St","city":"Lancaster","state":"PA","postalCode":"17603"}}
//                                        requestUrl += '&outFormat=json';
//                                        requestUrl += '&inFormat=json';
//                                        requestUrl += "&json=";
//                                        var jsonText = '{';
//                                        jsonText += '"location":{"street":"';
//                                        jsonText += (street + '",');
//                                        jsonText += ('"city":"' + city + '",');
//                                        jsonText += ('"state":"' + state + '",');
//                                        jsonText += ('"postalCode":"' + postalCode);
//                                        jsonText += '"}}';
//                                        requestUrl += jsonText;
//                                        requestUrl = requestUrl.replace('YOUR_KEY_HERE', 'Fmjtd|luubn9082h%2C8g%3Do5-902wu6'); //APP_KEY

//                                        $.ajax({
//                                            url: requestUrl,
//                                            type: "post",
//                                            cache: false, //强迫当前请求必须去后台拿数据，不能用客户端缓存。
//                                            success: renderOptions,
//                                            dataType: "json",
//                                            async:false  //同步！
//                                        });
//                                     }
//                                    
//                                };

//                                //RETURN THE LAST LOCATION...
//                                function renderOptions(response) {
//                                    if (response.info.statuscode && (response.info.statuscode != 200)) {
//                                        alert("Whoops!  There was an error during the request:\n");
//                                        return;
//                                    }

//                                    var locations = response.results[0].locations;
//                                    //            if (locations.length > 1) { // Location ambiguities!
//                                    //                alert("Ambiguous addresses found in request");
//                                    //              
//                                    //            }

//                            
//                                    var location = locations[0];
// 
//                                    //if location not found must return, or error
//                                    if(location == null) {                              
//                                          alert("one place geocode cannot be ensured!");
//                                          return;
//                                    }

//                                    lat = location.latLng.lat;
//                                    lng = location.latLng.lng;


//                                    var office = new MQA.Poi({
//                                        'lat': lat,
//                                        'lng': lng
//                                    });
//                                    office.setRolloverContent(name);
//                                    office.setInfoContentHTML(name);
//                                    //office.setDeclutterMode(true);

//                                    var customIcon = new MQA.Icon('http://www.mapquestapi.com/staticmap/geticon?uri=poi-' + (1) + '.png', 20, 29);
//                                    office.setIcon(customIcon);
//                                    map.addShape(office); // add POIs to the map's default shape collection
//                                    //map.bestFit();
//                                    //return;
//                            
//                                }
//                                map.bestFit();


//=======================================method 4: just give locations: some locations cannot be found========================================
                //                MQA.withModule('geocoder', 'smallzoom', 'mousewheel', function() {

                //                    map.addControl(new MQA.SmallZoom());
                //                    map.enableMouseWheelZoom();

                //                    var offices = <%= this.officesInMap %> ;

                //                    // override the POI construction function to customize the Rollover and InfoWindow states
                //                    MQA.Geocoder.constructPOI = function(location) {
                //                        var lat = location.latLng.lat,
                //                            lng = location.latLng.lng,
                //                            street = location.street,
                //                            city = location.adminArea5,
                //                            state = location.adminArea3,       
                //                            p = new MQA.Poi({
                //                                lat: lat,
                //                                lng: lng
                //                            });

                //                        p.setRolloverContent('<div style="white-space: nowrap">' + street + ', ' + city + ', ' + state + '</div>');
                //                        p.setInfoTitleHTML(p.getRolloverContent());
                //                        p.setInfoContentHTML('<div style="white-space: nowrap">' + street + ', ' + city + ', ' + state + '<br />LatLng: ' + lat + ', ' + lng + '</div>');

                //                        return p;
                //                    };

                //                    // executes a geocode and adds the result to the map
                //                    map.geocodeAndAddLocations(
                //                        // ['washington dc', {street: '29 oakville ct',city: 'Pittsburgh',state: 'PA',postalCode: '15220'},
                //                        // {street: '600 Grant Street',city: 'Pittsburgh',state: 'PA',postalCode: '15219'}]
                //                        offices
                //                    );
                //                });

            });
    </script>
</head>
<body>
    <form id="Form1" runat="server">
    <div id='map' style='width: 600px; height: 500px;'>
    </div>
    <%--<asp:HiddenField ID="hfOffices" runat="server" />--%>
    </form>
</body>
</html>
