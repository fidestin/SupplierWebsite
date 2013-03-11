<%@ Page Title="" Language="C#" MasterPageFile="~/index.Master" AutoEventWireup="true" CodeBehind="WebForm1.aspx.cs" Inherits="supplierData.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">
     <div id="someDiv" class="innerBoxCust">
        <div id="selectCust" class="selectCustList">
            <asp:ListBox ID="ListBox1" runat="server" class="custList"></asp:ListBox>
            <br />
            <br />
            <asp:TextBox ID="TextBox1" runat="server" Width="200px" Style="float:right"></asp:TextBox>
            <!-- <asp:Button ID="Button1" runat="server" Text="Add" />-->
            <img src="http://links.glasgowguide.co.uk/images/add-b.gif" title="Add customer email" />
            <br />
            <br />
            <!--<asp:Button ID="Button2" runat="server" Text="Send" />-->
            <img src="http://www.okobojirentals.com/images/icons/email-send-icon.jpg" title="Send emails"/>
        </div>
      </div>
</asp:Content>
