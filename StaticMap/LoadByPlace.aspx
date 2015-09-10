<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoadByPlace.aspx.cs" Inherits="StaticMap.LoadByPlace" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/base.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var HOST_URL = "http://open.mapquestapi.com";
        var APP_KEY = 'Fmjtd|luubn9082h%2C8g%3Do5-902wu6';
        var SAMPLE_POST_PLACE = HOST_URL + '/staticmap/v4/getplacemap?key=Fmjtd|luubn9082h%2C8g%3Do5-902wu6';    //YOUR_KEY_HERE';
        var placeURL = '';

        function showPlaceURL() {
            placeURL = SAMPLE_POST_PLACE;
            var location = document.getElementById('location').value;
            var size = document.getElementById('size').value;
            var type = document.getElementById('type').value;
            var zoom = document.getElementById('zoom').value;
            var imagetype = document.getElementById('imagetype').value;
            var showicon = document.getElementById('showicon').value;
            //var style = document.getElementById('stylePlace').value;
            placeURL += '&amp;location=' + location + '&amp;size=' + size + '&amp;type=' + type + '&amp;zoom=' + zoom + '&amp;imagetype=' + imagetype + '&amp;showicon=' + showicon;

            document.getElementById('placeSampleUrl').innerHTML = placeURL.replace(/</g, '&lt;').replace(/>/g, '&gt;'); ;
        };

        function doPlaceOptions() {
            showPlaceURL();
            var newURL = placeURL.replace('YOUR_KEY_HERE', APP_KEY);
            document.getElementById('imageByPlace').innerHTML = '<img src="' + newURL + '"/>';
        };

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="border: 1px solid black; padding: 5px;">
        <a id="getplacemapsample"></a>
        <h2>
            Static Map by Place Sample</h2>
        <div id="placeSampleUrl" class="code">
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
                        Result
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td>
                        <b>location:</b>
                    </td>
                    <td padding="5px">
                        <input type="text" onchange="showPlaceURL();" value="Lancaster,PA" name="location"
                            id="location" onkeyup="showPointURL();">
                    </td>
                    <td width="100%" id="imageByPlace" rowspan="7">
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>size:</b>
                    </td>
                    <td>
                        <input type="text" onchange="showPlaceURL();" value="400,200" name="size" id="size"
                            onkeyup="showPointURL();">
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>type:</b>
                    </td>
                    <td>
                        <select name="type" id="type" onchange="showPlaceURL();">
                            <option value="map">map</option>
                            <option value="sat">satellite</option>
                            <option value="hyb">hybrid</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>zoom:</b>
                    </td>
                    <td>
                        <select name="zoom" id="zoom" onchange="showPlaceURL();">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option selected="selected" value="13">13</option>
                            <option value="14">14</option>
                            <option value="15">15</option>
                            <option value="16">16</option>
                            <option value="17">17</option>
                            <option value="18">18</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>imagetype:</b>
                    </td>
                    <td>
                        <select name="imagetype" id="imagetype" onchange="showPlaceURL();">
                            <option value="jpeg">jpeg</option>
                            <option value="jpg">jpg</option>
                            <option value="gif">gif</option>
                            <option value="png">png</option>
                        </select>
                    </td>
                </tr>
                <tr>
                    <td>
                        <nobr>
                        <b>showicon:</b>
                    </nobr>
                    </td>
                    <td>
                        <input type="text" onchange="showPlaceURL();" value="red_1-1" name="showicon" id="showicon"
                            onkeyup="showPointURL();"/>
                    </td>
                </tr>
            </tbody>
        </table>
        <p>
            <input type="button" value="Run" onclick="doPlaceOptions();" id="btnExampleThree" />
        </p>
    </div>
    </form>
</body>
</html>
