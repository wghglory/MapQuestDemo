<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RendorMap.aspx.cs" Inherits="Geocoding.RendorMap" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="css/base.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var HOST_URL = "http://open.mapquestapi.com";
        var SAMPLE_ADVANCED_POST = HOST_URL + '/geocoding/v1/address?key=YOUR_KEY_HERE&callback=renderOptions';
        var advancedOptions = '';
        var outFormat = '';

        //being called when button clicks 
        function showOptionsURL(type) {
            advancedOptions = SAMPLE_ADVANCED_POST;
            var location = document.getElementById('location').value;
            //I CHANGED
            var street = document.getElementById('street').value;
            var city = document.getElementById('city').value;
            var state = document.getElementById('state').value;
            var postalCode = document.getElementById('postalCode').value;
            //I CHANGED
            var thumbMaps = document.getElementById('thumbMaps').value;
            var maxResults = document.getElementById('maxResults').value;
            var delimiter = document.getElementById('delimiter').value;

            var inFormat = document.getElementById('inFormat').value;
            outFormat = 'json'; //TODO: document.getElementById('outFormat').value;

            if (inFormat == 'kvp') {
                advancedOptions += '&inFormat=' + inFormat;
                advancedOptions += '&outFormat=' + outFormat;
                advancedOptions += '&location=' + location;
                if (thumbMaps == "false") {
                    advancedOptions += '&thumbMaps=' + thumbMaps;
                }
                if (maxResults != "") {
                    advancedOptions += '&maxResults=' + maxResults;
                }

                switch (document.getElementById('boundingBox').selectedIndex) {
                    case 0:
                        if (type == '') {
                            document.getElementById('location').value = ""; // "Lancaster,PA";
                        }

                        break;
                    case 1:
                        if (type == '') {
                            document.getElementById('location').value = "Red Lion";
                        }

                        break;
                    case 2:
                        advancedOptions += '&boundingBox=39.715056,-75.811158,39.5098,-75.491781';
                        if (type == '') {
                            document.getElementById('location').value = "Red Lion";
                        }

                        break;
                }
                if (document.getElementById('outFormat').value == 'file' && delimiter != '') {
                    advancedOptions += '&delimiter=' + delimiter;
                }

            } else if (inFormat == 'json') {  //json={"location":{"street": "1090 N Charlotte St","city":"Lancaster","state":"PA","postalCode":"17603"}}
                advancedOptions += '&outFormat=' + outFormat;
                advancedOptions += '&inFormat=json';
                advancedOptions += "&json=";
                var jsonText = '{';
                jsonText += '"location":{"street":"';
                if (location.length > 0) {
                    jsonText += location;
                }
                //I CHANGED
                if (location == "") {
                    jsonText += (street + '",');
                    jsonText += ('"city":"' + city + '",');
                    jsonText += ('"state":"' + state + '",');
                    jsonText += ('"postalCode":"' + postalCode);
                }
                //I CHANGED
                jsonText += '"}';

                jsonText += ',options:{';
                jsonText += 'thumbMaps:' + thumbMaps;
                if (maxResults != "") {
                    jsonText += ',maxResults:' + maxResults;
                }

                switch (document.getElementById('boundingBox').selectedIndex) {
                    case 0:
                        if (type == '') {
                            document.getElementById('location').value = "Lancaster,PA";
                        }

                        break;
                    case 1:
                        if (type == '') {
                            document.getElementById('location').value = "Red Lion";
                        }

                        break;
                    case 2:
                        jsonText += ',boundingBox:{ul:{lat:39.715056,lng:-75.811158},lr:{lat:39.5098,lng:-75.491781}}';
                        if (type == '') {
                            document.getElementById('location').value = "Red Lion";
                        }

                        break;
                }
                if (document.getElementById('outFormat').value == "file" && delimiter != "") {
                    jsonText += ',delimiter:"' + delimiter + '"';
                }

                jsonText += '}}';
                advancedOptions += jsonText;
            } else if (inFormat == 'xml') {
                advancedOptions += '&outFormat=' + outFormat;
                advancedOptions += '&inFormat=xml';
                advancedOptions += "&xml=";
                var xmlText = '<address>';
                xmlText += '<location><street>';
                if (location.length > 0) {
                    xmlText += location;
                }
                xmlText += '</street></location>';

                xmlText += '<options>';
                xmlText += '<thumbMaps>' + thumbMaps + '</thumbMaps>';
                if (maxResults != "") {
                    xmlText += '<maxResults>' + maxResults + '</maxResults>';
                }

                switch (document.getElementById('boundingBox').selectedIndex) {
                    case 0:
                        if (type == '') {
                            document.getElementById('location').value = "Lancaster,PA";
                        }

                        break;
                    case 1:
                        if (type == '') {
                            document.getElementById('location').value = "Red Lion";
                        }

                        break;
                    case 2:
                        xmlText += '<boundingBox><ul><latLng><lat>39.715056</lat><lng>-75.811158</lng></latLng></ul><lr><latLng><lat>39.5098</lat><lng>-75.491781</lng></latLng></lr></boundingBox>';
                        if (type == '') {
                            document.getElementById('location').value = "Red Lion";
                        }

                        break;
                }
                if (document.getElementById('outFormat').value == 'file' && delimiter != '') {
                    xmlText += '<delimiter>' + delimiter + '</delimiter>';
                }

                xmlText += '</options></address>';
                advancedOptions += xmlText;
            }

            var safe = advancedOptions;
            document.getElementById('optionsSampleUrl').innerHTML = safe.replace(/</g, '&lt;').replace(/>/g, '&gt;');
        };

        //querystring callback response content
        function renderOptions(response) {
            var html = '';
            var i = 0;
            var j = 0;

            if (outFormat == "json") {
                if (response.info.statuscode && (response.info.statuscode != 200)) {
                    var text = "Whoops!  There was an error during the request:\n";
                    if (response.info.messages) {
                        for (i = 0; i < response.info.messages.length; i++) {
                            text += response.info.messages[i] + "\n";
                        }
                    }

                    document.getElementById('optionsNarrative').innerHTML = text;
                    return;
                }

                var locations = response.results[0].locations;
                if (locations.length > 1) { // Location ambiguities!
                    html = "<p>Ambiguous addresses found in request:</p><table>";
                    for (i = 0; i < locations.length; i++) {
                        var location = locations[i];

                        html += '<tr><td>';
                        html += ' ' + (location.adminArea5 || ' ');
                        html += ' ' + (location.adminArea4 || ' ');
                        html += ' ' + (location.adminArea3 || ' ');
                        html += ' ' + (location.adminArea2 || ' ');
                        html += ' ' + (location.adminArea1 || ' ');
                        html += '</td>';
                        if (location.mapUrl) {
                            html += '<td>';
                            html += '<img src="' + location.mapUrl + '"/>';
                            html += '</td>';
                        }
                        html += '</tr>';
                    }
                    html += '</table>';
                    document.getElementById('optionsNarrative').innerHTML = html;
                    return;
                }

                if (locations.length == 1) {
                    html = "<p>Location:</p>";
                    var location = locations[0];

                    html += 'Country: ' + location.adminArea1;
                    html += '<br/>';
                    html += 'State: ' + location.adminArea3;
                    html += '<br/>';
                    html += 'County: ' + location.adminArea4;
                    html += '<br/>';
                    html += 'City: ' + location.adminArea5;
                    html += '<br/>';
                    html += 'Response Code:' + location.geocodeQualityCode;
                    html += '<br/>';
                    html += 'Lat: ' + location.latLng.lat + "   Lng: " + location.latLng.lng;
                    html += '<br/>';
                    html += 'Static Map: ' + '<img src="' + location.mapUrl + '"/>';

                    document.getElementById('optionsNarrative').innerHTML = html;
                    return;
                }
            }
            else if (outFormat == "geojson") {

            }
            else {

            }

            document.getElementById('optionsNarrative').innerHTML = html;
        }

        //being called when button clicks
        function doOptions() {
            document.getElementById('optionsNarrative').innerHTML = 'Pending...';
            var script = document.createElement('script');
            script.type = 'text/javascript';
            showOptionsURL('buttonClick');
            var newURL = advancedOptions.replace('YOUR_KEY_HERE', 'Fmjtd|luubn9082h%2C8g%3Do5-902wu6');   //APP_KEY
            script.src = newURL;
            document.body.appendChild(script);
        };

    </script>
</head>
<%--http://open.mapquestapi.com/geocoding/v1/address?key=YOUR_KEY_HERE&inFormat=json&json={"location":{"street": "1090 N Charlotte St","city":"Lancaster","state":"PA","postalCode":"17603"}}--%>
<body>
    <form id="form1" runat="server">
    <div class="bodyblock">
        <div style="border: 1px solid black; padding: 5px;">
            <a id="optionssample"></a>
            <h2>
                Geocode Options Sample</h2>
            <div id="narrative" class="code">
            </div>
            <div id="optionsSampleUrl" class="code">
            </div>
            <br />
            <table>
                <thead>
                    <tr>
                        <th>
                            Option
                        </th>
                        <th>
                            Value(s)
                        </th>
                        <th>
                            Notes
                        </th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>
                            <b>location:</b>
                        </td>
                        <td padding="5px" colspan="2">
                            <input type="text" value="" name="location" id="location" style="width: 99%;" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="3" padding="5px">
                            OR
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>street:</b>
                        </td>
                        <td padding="5px" colspan="2">
                            <input type="text" value="" name="street" id="street" style="width: 99%;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>city:</b>
                        </td>
                        <td padding="5px" colspan="2">
                            <input type="text" value="" name="city" id="city" style="width: 99%;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>state:</b>
                        </td>
                        <td padding="5px" colspan="2">
                            <input type="text" value="" name="state" id="state" style="width: 99%;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>zip:</b>
                        </td>
                        <td padding="5px" colspan="2">
                            <input type="text" value="" name="postalCode" id="postalCode" style="width: 99%;" />
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>boundingBox:</b>
                        </td>
                        <td>
                            <select name="boundingBox" id="boundingBox" onchange="showOptionsURL('');">
                                <option value="">None</option>
                                <option value="ambiguous">Ambiguous (No boundingBox)</option>
                                <option value="fastest">Ambiguous (With boundingBox)</option>
                            </select>
                            <div>
                                If the "Ambiguous (With boundingBox)" option is selected, the boundingBox used will
                                be: UL: 39.715056, -75.811158, LR: 39.5098, -75.491781, an area which includes Red
                                Lion, DE.
                            </div>
                        </td>
                        <td>
                            Changing this from <code>"None"</code> will change the location text
                            <br />
                            Notice: Having the boundingBox will change the order of the locations so locations
                            within the bounding box region are pushed to the top of the list. (In this case,
                            the boundingBox covers the upper portion of Delaware, so the result located in Delaware
                            is moved to the top of the list)
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>thumbMaps:</b>
                        </td>
                        <td>
                            <select name="thumbMaps" id="thumbMaps" onchange="showOptionsURL('');">
                                <option value="true">True</option>
                                <option value="false">False</option>
                            </select>
                        </td>
                        <td>
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>maxResults:</b>
                        </td>
                        <td>
                            <input type="text" name="maxResults" id="maxResults" onchange="showOptionsURL('');"
                                size="10" />
                        </td>
                        <td>
                            This option will only have an effect if the location above is ambiguous
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <b>Input Format:</b>
                        </td>
                        <td>
                            <select name="inFormat" id="inFormat" onchange="showOptionsURL('');">
                                <option value="json">JSON</option>
                                <option value="kvp">Key/Value pairs</option>
                                <option value="xml">XML</option>
                            </select>
                        </td>
                        <td>
                            Uses <code>"json="</code> or <code>"xml="</code> if appropriate.
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <nobr>
                        <b>Output Format:</b>
                    </nobr>
                        </td>
                        <td>
                            <select name="outFormat" id="outFormat" onchange="showOptionsURL('');">
                                <option value="json">JSON</option>
                                <option value="geojson">GeoJSON</option>
                                <option value="xml">XML</option>
                                <option value="csv">CSV</option>
                            </select>
                        </td>
                        <td>
                            Default is JSON (Currently only JSON works)
                        </td>
                    </tr>
                    <tr>
                        <td>
                            <nobr>
                        <b>Delimiter:</b>
                    </nobr>
                        </td>
                        <td>
                            <select name="delimiter" id="delimiter" onchange="showOptionsURL('');">
                                <option value="">None</option>
                                <option value=",">Comma</option>
                                <option value="|">Pipe</option>
                                <option value=":">Colon</option>
                                <option value=";">Semicolon</option>
                            </select>
                        </td>
                        <td>
                            Default is none. This option will only have an effect if <code>outFormat=csv</code>.
                        </td>
                    </tr>
                </tbody>
            </table>
            <p>
                <input type="button" value="Run" onclick="doOptions();" id="testOptions" />
                (Output will be displayed below)
            </p>
            <div id="optionsNarrative">
            </div>
        </div>
    </div>
    </form>
</body>
</html>
