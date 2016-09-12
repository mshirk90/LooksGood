<%@ Page Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="PassWordConfirmation.aspx.cs" Inherits="LooksGood.Account.PassWordConfirmation" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <div style="padding-left:25px">
    <h2><%: Title %>Password Sent Sucessfully</h2>    
        <asp:Label ID="pwConfirm" CssClass="pull-left" runat="server" Text="Check registered e-mail">   
        </asp:Label>
    </div>
</asp:Content>
