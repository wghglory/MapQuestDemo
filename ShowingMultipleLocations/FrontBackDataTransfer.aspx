<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="FrontBackDataTransfer.aspx.cs" Inherits="ShowingMultipleLocations.FrontBackDataTransfer" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <script src="js/jquery-1.11.1.js"></script>
    <script type="text/javascript">
        $(function () {
            var data = [{ "Id": 10004, "PageName": "club" }, { "Id": 10040, "PageName": "qaz" }, { "Id": 10059, "PageName": "jjjjjjj" }
            ];

            $.each(data, function (i, item) {
                alert(data[i].PageName);
            })

            $.each(data, function (i, item) {
                alert(item.PageName);
            })

            //====================pass C# list to Javascript variable=========================
            //====================method 1: pass list to hidden field======================
            var offices = eval($("#hfOffices").val());  //eval: convert each office to object

            //var officesBeforeEval = [{ "Name": "Denver", "Lng": -104.984898, "Lat": 39.740115 }, { "Name": "Boulder", "Lng": -105.269985, "Lat": 40.014981 }, { "Name": "Breckenridge", "Lng": -106.037783, "Lat": 39.481706 }];

            $.each(offices, function (i, item) {
                alert(offices[i].Name);
            })

            //$.each(offices, function (i, item) {
            //    alert(item.Name);
            //})

            //===================method 2: create public/protected fields.=====================
            var a = <%= this.javaSerial.Serialize(this.names) %>;  //Here right!
            for (var i = 0; i < a.length; i++) {
                alert(a[i]);
            }

        });
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div>
            <asp:HiddenField ID="hfOffices" runat="server" />
        </div>
    </form>
</body>
</html>
