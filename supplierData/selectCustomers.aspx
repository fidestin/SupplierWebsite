<%@ Page Title="" Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="selectCustomers.aspx.cs" Inherits="supplierData.selectCustomers" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script>
        var campaignURL;
        $(document).ready(function () {
            //alert('Doc is loaded');
            //load the customers here...
            //get from url
            var qs = Fidestin.Utils.GetQueryStrings()
            console.log(qs);
            campaignURL = qs["ca"];
            console.log('Load page');
           // alert('Page Load');
            loadCustomers(campaignURL);
            $('#<%=TextBox1.ClientID%>').focus();

           //Add default click on 
           // $('#<%=TextBox1.ClientID%>').keyup(function (event) {
           //    if (event.keyCode == 13) {
           //         addUser();
           //     }
           // });
        });


        
        function removeEmail() {
            console.log('removeEmail');
            var emSel = $('#<%=ListBox1.ClientID%> option:selected')[0];
            var em = emSel.outerText;
            if (confirm('Remove this email : ' + em + '?')) {
                emSel.remove();
            };
        }



        function saveEmails() {
            console.log('saveEmail');
            var lstEmails = $('#<%=ListBox1.ClientID%>>option');
            var arrEmails = new Array();
            for (var i = 0; i < lstEmails.length; i++) {
                var custEmail = lstEmails[i].innerText;
                arrEmails[i] = custEmail;
            }
            saveCustomers(campaignURL, arrEmails);
        }


        function addUser() {
            console.log('adduser');
            var email = $('#<%=TextBox1.ClientID%>').val();
            if (email == '') {
                alert('Enter email address for customer');
                $('#<%=TextBox1.ClientID%>').focus();
            }
            else {
                $('#<%=ListBox1.ClientID%>').append('<option value="' + email + '">' + email + '</option>');
                $('#<%=TextBox1.ClientID%>').val('');
                $('#<%=TextBox1.ClientID%>').focus();
            }
        }


        //Saves the customers to the database
        function saveCustomers(campaignID, arrCustomerEmails) {
            try {
                var jcustEMail = JSON.stringify(arrCustomerEmails);
                var params = '{"campaignID": '+ campaignID +',"customerEmails":' + jcustEMail + '}';
                $.ajax({
                    type: "POST",
                    data: params,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url: "http://www.fidestin.com/supplier/supplierfactory.asmx/SaveCampaignEmails",
                    success: function (result) {
                        alert('Emails saved');
                     //   for (var i = 0; i < result.d.length; i++) {
                    //        $('#<%=ListBox1.ClientID%>').append('<option value="' + result.d[i].customerID + '">' + result.d[i].customerEmail + '</option>');
                    //    }
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


        //Loads the customers from the database
        function loadCustomers(campaignID) {
            try{
                var params = '{"campaignID":'+campaignID+'}';
                $.ajax({
                    type: "POST",
                    data: params,
                    dataType: "json",
                    contentType: "application/json; charset=utf-8",
                    url:"http://www.fidestin.com/supplier/supplierfactory.asmx/LoadCampaignCustomers",
                    success: function (result) {
                        for(var i=0;i<result.d.length;i++){
                            $('#<%=ListBox1.ClientID%>').append('<option value="'+result.d[i].customerID+'">'+result.d[i].customerEmail+'</option>');
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
    <div id="someDiv" class="innerBoxCust">
        <div id="selectCust" class="selectCustList">
            <asp:ListBox ID="ListBox1" runat="server" class="custList"></asp:ListBox>
            <br />
            <br />
            <asp:TextBox ID="TextBox1" runat="server" Width="200px" Style="float:right"></asp:TextBox>
            <!-- <asp:Button ID="Button1" runat="server" Text="Add" />-->
            <img src="http://links.glasgowguide.co.uk/images/add-b.gif" title="Add customer email" onclick="addUser();"/>
            <br />
            <img src="images/remove.png" title="Remove Customer" onclick="removeEmail();" />
            <img src="images/save-button.png" title="Save campaign emails" onclick="saveEmails();" />
            <br />
            <!--<asp:Button ID="Button2" runat="server" Text="Send" />-->
            <img src="images/send.jpg" title="Send emails"/>
        </div>
    </div>
</asp:Content>
