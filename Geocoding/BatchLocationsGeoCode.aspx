<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="BatchLocationsGeoCode.aspx.cs"
    Inherits="Geocoding.BatchLocationsGeoCode" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="css/base.css" rel="stylesheet" />
    <script type="text/javascript" src="js/batch.js"></script>
    <script type="text/javascript">
  
    </script>
</head>
<body>
    <form id="form1" runat="server">
    <div style="border: 1px solid black; padding: 5px;">
        <a id="batchsample"></a>
        <h2>
            Batch Geocode Sample</h2>
        <div id="batchSampleUrl" class="code">
        </div>
        <br>
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
                        <b>Location 1:</b>
                    </td>
                    <td colspan="2">
                        <input type="text" value="Pottsville,PA" name="location1" id="location1" onchange="showBatchURL();"
                            size="80" style="width: 100%">
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Location 2:</b>
                    </td>
                    <td colspan="2">
                        <input type="text" value="Red Lion" name="location2" id="location2" onchange="showBatchURL();"
                            size="80" style="width: 100%">
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Location 3:</b>
                    </td>
                    <td colspan="2">
                        <input type="text" value="19036" name="location3" id="location3" onchange="showBatchURL();"
                            size="80" style="width: 100%">
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Location 4:</b>
                    </td>
                    <td colspan="2">
                        <input type="text" value="1090 N Charlotte St, Lancaster, PA" name="location4" id="location4"
                            onchange="showBatchURL();" size="80" style="width: 100%">
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>boundingBox:</b>
                    </td>
                    <td>
                        <select name="batchBoundingBox" id="batchBoundingBox" onchange="showBatchURL();">
                            <option value="">None</option>
                            <option value="">Ambiguous with boundingBox</option>
                        </select>
                        <p>
                        </p>
                        <div>
                            If the "Ambiguous with boundingBox" option is selected, the boundingBox used will
                            be: UL: 39.715056, -75.811158, LR: 39.5098, -75.491781, an area which includes Red
                            Lion, DE.
                        </div>
                        <p>
                        </p>
                    </td>
                    <td>
                        Having the boundingBox will change the order of the locations so locations within
                        the bounding box region are pushed to the top of the list
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>thumbMaps:</b>
                    </td>
                    <td>
                        <select name="batchThumbMaps" id="batchThumbMaps" onchange="showBatchURL();">
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
                        <input type="text" name="batchMaxResults" id="batchMaxResults" onchange="showBatchURL();"
                            size="10">
                    </td>
                    <td>
                        This option will only have an effect on the second location because it is ambiguous
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>Input Format:</b>
                    </td>
                    <td>
                        <select name="batchInFormat" id="batchInFormat" onchange="showBatchURL();">
                            <option value="kvp">Key/Value pairs</option>
                            <option value="json">JSON</option>
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
                        <select name="batchOutFormat" id="batchOutFormat" onchange="showBatchURL();">
                            <option value="json">JSON</option>
                            <option value="geojson">GeoJSON</option>
                            <option value="xml">XML</option>
                            <option value="csv">CSV</option>
                        </select>
                    </td>
                    <td>
                        Default is JSON (Currently only JSON works in this sample)
                    </td>
                </tr>
                <tr>
                    <td>
                        <nobr>
                        <b>Delimiter:</b>
                    </nobr>
                    </td>
                    <td>
                        <select name="batchDelimiter" id="batchDelimiter" onchange="showBatchURL('');">
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
            <button onclick="doBatch();" id="btnBatch">
                Run
            </button>
            (Output will be displayed below)
        </p>
        <div id="batchNarrative">
        </div>
    </form>
</body>
</html>
