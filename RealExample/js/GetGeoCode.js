


var SAMPLE_ADVANCED_POST = 'http://open.mapquestapi.com/geocoding/v1/address?key=YOUR_KEY_HERE&callback=renderOptions';
var advancedOptions = '';
var outFormat = '';

//being called when button clicks 
function showOptionsURL(type) {
    advancedOptions = SAMPLE_ADVANCED_POST;

    var street = document.getElementById('street').value;
    var city = document.getElementById('city').value;
    var state = document.getElementById('state').value;
    var postalCode = document.getElementById('postalCode').value;

    outFormat = 'json'; //TODO: document.getElementById('outFormat').value;

    if (inFormat == 'json') {  //json={"location":{"street": "1090 N Charlotte St","city":"Lancaster","state":"PA","postalCode":"17603"}}
        advancedOptions += '&outFormat=' + outFormat;
        advancedOptions += '&inFormat=json';
        advancedOptions += "&json=";
        var jsonText = '{';
       
            jsonText += (street + '",');
            jsonText += ('"city":"' + city + '",');
            jsonText += ('"state":"' + state + '",');
            jsonText += ('"postalCode":"' + postalCode);

        jsonText += '"}';




        jsonText += '}}';
        advancedOptions += jsonText;
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
