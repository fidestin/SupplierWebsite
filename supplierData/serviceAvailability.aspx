<%@ Page Title="" Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="serviceAvailability.aspx.cs" Inherits="supplierData.serviceAvailability" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>

        $(document).ready(function () {
            console.log('Page Loaded');
            //Load current Week for supplierID
            var store = 60;     //get this from the URL?
            loadMySuppliers(store);

            //add OnChange event to dropdownlist...

        });


        //saves data back
        function saveServAvail() {
            try {
                var servID = $('#<%=servID.ClientID%>').val();
                var mon = $('#<%=currMon.ClientID%>').val();
                var tue = $('#<%=currTue.ClientID%>').val();
                var wed = $('#<%=currWed.ClientID%>').val();
                var thurs = $('#<%=currThu.ClientID%>').val();
                var fri = $('#<%=currFri.ClientID%>').val();
                var sat = $('#<%=currSat.ClientID%>').val();
                var sun = $('#<%=currSun.ClientID%>').val();
                var storeSupplierID = $('#<%=relationshipID.ClientID%>').val();
                var weekID = weekNumber;
                var params = '{"servID": ' + servID + ',"mon": ' + mon + ',"tue": ' + tue + ',"wed": ' + wed + ',"thurs": ' + thurs + ',"fri": ' + fri + ',"sat": ' + sat + ',"sun": ' + sun + ',"storeSupplierID": ' + storeSupplierID + ',"weekID": ' + weekID + '}';

                $.ajax({
                    type: "POST",
                    data: params,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "http://www.fidestin.com/supplier/supplierfactory.asmx/UpdateOrInsertAvailability",
                    success: function (result) {
                        alert('Availability saved');
                    },
                    error: function () {
                        $(document).ajaxError(function (e, xhr, settings, exception) {
                            debugalert('error in: ' + settings.url + ' \n' + 'error:\n' + xhr.responseText + "\n" + exception.message);
                        });
                        return -99;
                    }
                })
            }
            catch (b) { alert('Error ' + b); }

        }
        //fired when the service is changed
        function reloadService() {
            //for now just reload the same service
            try {
                var weekID = weekNumber;
                var relationshipID = $('#<%=DropDownList1.ClientID%> option:selected')[0];
                //relationshipID==storeSupplierID
                var params = '{"relationshipID": ' + relationshipID.value + ',"weekID":' + weekID + '}';
                $.ajax({
                    type: "POST",
                    data: params,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "http://www.fidestin.com/supplier/supplierfactory.asmx/LoadServiceAvailabilityForWeek",
                    success: function (result) {
                        //  alert('Emails saved');
                        if (result.d!=undefined) {
                            $('#<%=currMon.ClientID%>').val(result.d.mon);
                            $('#<%=currTue.ClientID%>').val(result.d.tue);
                            $('#<%=currWed.ClientID%>').val(result.d.wed);
                            $('#<%=currThu.ClientID%>').val(result.d.thurs);
                            $('#<%=currFri.ClientID%>').val(result.d.fri);
                            $('#<%=currSat.ClientID%>').val(result.d.sat);
                            $('#<%=currSun.ClientID%>').val(result.d.sun);
                            $('#<%=relationshipID.ClientID%>').val(relationshipID.value);
                            $('#<%=servID.ClientID%>').val(result.d.id);
                            console.log('Service Data loaded');
                        }
                    },
                    error: function () {
                        $(document).ajaxError(function (e, xhr, settings, exception) {
                            debugalert('error in: ' + settings.url + ' \n' + 'error:\n' + xhr.responseText + "\n" + exception.message);
                        });
                        return -99;
                    }
                })

            }
            catch (b) { alert('Error ' + b); }
        }

        function loadMySuppliers(storeID) {
            try {
                var params = '{"storeID": ' + storeID + '}';
                $.ajax({
                    type: "POST",
                    data: params,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "http://www.fidestin.com/supplier/supplierfactory.asmx/LoadMySupplierServices",
                    success: function (result) {
                      //  alert('Emails saved');
                        for (var i = 0; i < result.d.length; i++) {
                            $('#<%=DropDownList1.ClientID%>').append('<option value="' + result.d[i].Key + '">' + result.d[i].Value + '</option>');
                         }
                    },
                    error: function () {
                        $(document).ajaxError(function (e, xhr, settings, exception) {
                            debugalert('error in: ' + settings.url + ' \n' + 'error:\n' + xhr.responseText + "\n" + exception.message);
                        });
                        return -99;
                    }
                })

            }
            catch (b) { alert('Error ' + b); }
        }


        function loadAvailability() {

        }

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <br />
    <div id="selectService">
        <asp:DropDownList ID="DropDownList1" runat="server" onchange="javascript:reloadService();">
          
        </asp:DropDownList>
   
     </div>
   
     <br />
       
    <div>
        <asp:Table ID="Table1" runat="server" Class="serviceTable">
            <asp:TableHeaderRow>
                <asp:TableHeaderCell>servAvailID</asp:TableHeaderCell>
                <asp:TableHeaderCell></asp:TableHeaderCell>
                <asp:TableHeaderCell>Mon</asp:TableHeaderCell>
                <asp:TableHeaderCell>Tue</asp:TableHeaderCell>
                <asp:TableHeaderCell>Wed</asp:TableHeaderCell>
                <asp:TableHeaderCell>Thurs</asp:TableHeaderCell>
                <asp:TableHeaderCell>Fri</asp:TableHeaderCell>
                <asp:TableHeaderCell>Sat</asp:TableHeaderCell>
                <asp:TableHeaderCell>Sun</asp:TableHeaderCell>
                <asp:TableHeaderCell>relationshipID</asp:TableHeaderCell>
            </asp:TableHeaderRow>
            <asp:TableRow>
                <asp:TableCell>Availability</asp:TableCell>
                <asp:TableCell><asp:TextBox id="servID" runat="server" Class="serviceAvail"></asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox id="currMon" runat="server" Class="serviceAvail">4</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="currTue" runat="server" Class="serviceAvail">5</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="currWed" runat="server" Class="serviceAvail">3</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="currThu" runat="server" Class="serviceAvail">2</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="currFri" runat="server" Class="serviceAvail">1</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="currSat" runat="server" Class="serviceAvail">0</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox id="currSun" runat="server" Class="serviceAvail">8</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox id="relationshipID" runat="server" Class="serviceAvail"></asp:TextBox></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
    <div style="padding:10px;">

        
        <asp:TextBox ID="TextBox1" class="txtBox" runat="server" TextMode="MultiLine" Text="Rattle up just €25 (a €60 value) and help shed the sleepy scales of winter with an hour-long Chinese massage. Or for €29 (a €70 value), wrap up a Chinese acupuncture treatment. Chinese massage uses manipulation to stimulate pressure points and help improve the flow of Qi through the body.">

        </asp:TextBox>
    </div>
    <div style="float:left;padding:10px">
        <!--<asp:Button ID="Button1" runat="server" Text="Prev Week" />-->
            <img src="http://cruisersolutions.com/includes/templates/template_cs/buttons/english/button_prev.gif" title="Previous Week"/>
    </div>
    <div style="float:right;padding:10px">
       <!-- <asp:Button ID="Button2" runat="server" Text="Next Week" />-->
        <img src="http://cruisersolutions.com/includes/templates/template_cs/buttons/english/button_next.gif" title="Next Week"/>
    </div>
    <br />
    <div>
          <asp:Table ID="Table2" runat="server" Class="serviceTable">
            <asp:TableHeaderRow>
                <asp:TableHeaderCell></asp:TableHeaderCell>
                <asp:TableHeaderCell>Mon</asp:TableHeaderCell>
                <asp:TableHeaderCell>Tue</asp:TableHeaderCell>
                <asp:TableHeaderCell>Wed</asp:TableHeaderCell>
                <asp:TableHeaderCell>Thurs</asp:TableHeaderCell>
                <asp:TableHeaderCell>Fri</asp:TableHeaderCell>
                <asp:TableHeaderCell>Sat</asp:TableHeaderCell>
                <asp:TableHeaderCell>Sun</asp:TableHeaderCell>
            </asp:TableHeaderRow>
            <asp:TableRow>
                <asp:TableCell>Availability</asp:TableCell>
                <asp:TableCell><asp:TextBox id="TextBox9" runat="server" Class="serviceAvail">4</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox10" runat="server" Class="serviceAvail">5</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox11" runat="server" Class="serviceAvail">3</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox12" runat="server" Class="serviceAvail">2</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox13" runat="server" Class="serviceAvail">1</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox14" runat="server" Class="serviceAvail">0</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox id="TextBox15" runat="server" Class="serviceAvail">8</asp:TextBox></asp:TableCell>
            </asp:TableRow>
            <asp:TableRow>
                 <asp:TableCell>Places Bought</asp:TableCell>
                <asp:TableCell><asp:TextBox id="TextBox16" runat="server" Class="serviceAvail">4</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox17" runat="server" Class="serviceAvail">5</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox18" runat="server" Class="serviceAvail">3</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox19" runat="server" Class="serviceAvail">2</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox20" runat="server" Class="serviceAvail">1</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox21" runat="server" Class="serviceAvail">0</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox id="TextBox22" runat="server" Class="serviceAvail">8</asp:TextBox></asp:TableCell>
            </asp:TableRow>
               <asp:TableRow>
                 <asp:TableCell>Revenue</asp:TableCell>
                <asp:TableCell><asp:TextBox id="TextBox23" runat="server" Class="serviceAvail">4</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox24" runat="server" Class="serviceAvail">5</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox25" runat="server" Class="serviceAvail">3</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox26" runat="server" Class="serviceAvail">2</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox27" runat="server" Class="serviceAvail">1</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox ID="TextBox28" runat="server" Class="serviceAvail">0</asp:TextBox></asp:TableCell>
                <asp:TableCell><asp:TextBox id="TextBox29" runat="server" Class="serviceAvail">8</asp:TextBox></asp:TableCell>
            </asp:TableRow>
        </asp:Table>
    </div>
      <asp:GridView ID="GridView2" runat="server" AutoGenerateColumns="false" Height="67px" Width="646px">
            <Columns>
                 <asp:BoundField HeaderText="Legend" DataField="legend"/>
                <asp:BoundField HeaderText="Mon" DataField="mondayAv"/>
                <asp:BoundField HeaderText="Tues" DataField="tuesdayAv" />
                <asp:BoundField HeaderText="Wed" DataField="wednesdayAv" />
                <asp:BoundField HeaderText="Thu" DataField="thursdayAv" />
                <asp:BoundField HeaderText="Fri"  DataField="fridaAv"/>
                <asp:BoundField HeaderText="Sat"  DataField="satAv"/>
                <asp:BoundField HeaderText="Sun"  DataField="sunAv"/>
            </Columns>
        </asp:GridView>
    <div style="padding:10px;float:right">
        <img src="http://www.maximumsoft.com/screens/tour/isw_iphone/tour_save_button.png" title="Save Details" onclick="saveServAvail();"/>
    </div>
    </asp:Content>
