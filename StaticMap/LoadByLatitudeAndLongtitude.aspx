<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="LoadByLatitudeAndLongtitude.aspx.cs" Inherits="StaticMap.LoadByLatitudeAndLongtitude" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title></title>
    <link href="css/base.css" rel="stylesheet" type="text/css" />
    <script type="text/javascript">
        var HOST_URL = "http://open.mapquestapi.com";
        var APP_KEY = 'Fmjtd|luubn9082h%2C8g%3Do5-902wu6';
        var SAMPLE_POST_POINT = HOST_URL + '/staticmap/v4/getmap?key=Fmjtd|luubn9082h%2C8g%3Do5-902wu6';    //YOUR_KEY_HERE';
        var pointURL = '';

        function showPointURL() {
            pointURL = SAMPLE_POST_POINT;
            var locationPoint = '';
            var center = document.getElementById('centerPoint').value;
            var bestfit = document.getElementById('bestfitPoint').value;
            var size = document.getElementById('sizePoint').value;
            var type = document.getElementById('typePoint').value;
            var zoom = document.getElementById('zoomPoint').value;
            var imagetype = document.getElementById('imagetypePoint').value;

            if (document.getElementById('useCenter').checked) {
                locationPoint = '&amp;center=' + center + '&amp;zoom=' + zoom;
            }
            else {
                locationPoint = '&amp;bestfit=' + bestfit;
            }

            pointURL += locationPoint + '&amp;size=' + size + '&amp;type=' + type + '&amp;imagetype=' + imagetype; //  + '&amp;pois=' + pois;
            document.getElementById('pointSampleUrl').innerHTML = pointURL.replace(/</g, '&lt;').replace(/>/g, '&gt;'); ;
        }

        function doPointOptions() {
            showPointURL();
            var newURL = pointURL.replace('YOUR_KEY_HERE', APP_KEY);
            //img src = http://open.mapquestapi.com/....to load image
            document.getElementById('imageByPoint').innerHTML = '<img src="' + newURL + '"/>';
        }

        function switchTypeOfPoint() {
            if (document.getElementById('useCenter').checked) {
                document.getElementById('bestfitPoint').disabled = true;
                document.getElementById('centerPoint').disabled = false;
                document.getElementById('zoomPoint').disabled = false;
            }
            else {
                document.getElementById('bestfitPoint').disabled = false;
                document.getElementById('centerPoint').disabled = true;
                document.getElementById('zoomPoint').disabled = true;
            }
        }

    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="border: 1px solid black; padding: 5px;">
        <a id="getmapsample"></a>
        <h2>
            Static Map by Latitude/Longitude Sample</h2>
        <div id="pointSampleUrl" class="code">
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
                        <b>center:</b>
                    </td>
                    <td padding="5px">
                        <nobr><input type="radio" checked="true" onchange="switchTypeOfPoint();" value="center" name="typeOfPoint" id="useCenter"><input type="text" onchange="showPointURL();" value="40.0447,-76.4132" name="centerPoint" id="centerPoint" onkeyup="showPointURL();"></nobr>
                    </td>
                    <td width="100%" id="imageByPoint" rowspan="8">
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>bestfit:</b>
                    </td>
                    <td padding="5px">
                        <nobr><input type="radio" onchange="switchTypeOfPoint();" value="bestfit" name="typeOfPoint" id="useBestfit"><input type="text" onchange="showPointURL();" value="40.0733,-76.667,39.9009,-76.31698" name="bestfitPoint" id="bestfitPoint" size="40" onkeyup="showPointURL();" disabled=""></nobr>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>size:</b>
                    </td>
                    <td>
                        <input type="text" onchange="showPointURL();" value="400,200" name="sizePoint" id="sizePoint"
                            onkeyup="showPointURL();">
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>type:</b>
                    </td>
                    <td>
                        <select name="typePoint" id="typePoint" onchange="showPointURL();">
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
                        <select name="zoomPoint" id="zoomPoint" onchange="showPointURL();">
                            <option value="1">1</option>
                            <option value="2">2</option>
                            <option value="3">3</option>
                            <option value="4">4</option>
                            <option value="5">5</option>
                            <option value="6">6</option>
                            <option value="7">7</option>
                            <option value="8">8</option>
                            <option value="9">9</option>
                            <option selected="selected" value="10">10</option>
                            <option value="11">11</option>
                            <option value="12">12</option>
                            <option value="13">13</option>
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
                        <select name="imagetypePoint" id="imagetypePoint" onchange="showPointURL();">
                            <option value="jpeg">jpeg</option>
                            <option value="jpg">jpg</option>
                            <option value="gif">gif</option>
                            <option value="png">png</option>
                        </select>
                    </td>
                </tr>
                <%--<tr>
                    <td>
                        <b>pois:</b>
                    </td>
                    <td padding="5px">
                        <input type="text" onchange="showAdvancedURL();" size="60" value="1,40.0986,-76.3988,-20,-20|orange-100,40.0692,-76.4012|green,40.0981,-76.3461|yellow-s,40.0697,-76.352"
                            name="poisAdvanced" id="poisAdvanced" onkeyup="showPointURL();">
                    </td>
                </tr>--%>
            </tbody>
        </table>
        <p>
            <input type="button" value="Run" onclick="doPointOptions();" id="btnExampleOne" />
        </p>
    </div>
    </form>
</body>
</html>
