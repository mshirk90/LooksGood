<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LooksGood.Account.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-group">
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="SingleLine" PlaceHolder="Email"/>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail" CssClass="text-danger"
                ErrorMessage="The first name field is required." ID="rvEmail" ValidationGroup="vgRegister" >*</asp:RequiredFieldValidator>
            </div>
    </div>
    <div class="form-group">
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control" PlaceHolder="UserName" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUserName" CssClass="text-danger"
                ErrorMessage="The first name field is required." ID="rvFirstName" ValidationGroup="vgRegister" >*</asp:RequiredFieldValidator>
            <asp:Label ID="lblStatus" runat="server"></asp:Label>
            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" CssClass=" div-margin"/>
        </div>
    </div>    
        
    </asp:Content>