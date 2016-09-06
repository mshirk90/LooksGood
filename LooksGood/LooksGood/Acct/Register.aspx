<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LooksGood.Acct.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div class="form-group">
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="SingleLine" PlaceHolder="Email"/>
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger"
                ErrorMessage="The first name field is required." ID="rvEmail" ValidationGroup="vgRegister" >*</asp:RequiredFieldValidator>
            </div>
    </div>
    <div class="form-group">
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtFirstName" CssClass="form-control" PlaceHolder="First Name" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtFirstName" CssClass="text-danger"
                ErrorMessage="The first name field is required." ID="rvFirstName" ValidationGroup="vgRegister" >*</asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtLastName" CssClass="form-control" PlaceHolder="Last Name" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtLastName" CssClass="text-danger"
                ErrorMessage="The last name field is required." ID="rvLastName" ValidationGroup="vgRegister" >*</asp:RequiredFieldValidator>
        </div>
    </div>
    <div class="form-group">
        <div class="col-md-offset-2 col-md-10">
            <asp:Button runat="server" ID="btnRegister" Text="Register" CssClass="btn btn-default" OnClick="btnRegister_Click"/>
            <br />
            <br />
            <asp:Label ID="lblStatus" runat="server"></asp:Label>
            <asp:ValidationSummary ID="ValidationSummary1" runat="server" ValidationGroup="vgRegister" />
        </div>
    </div>
</asp:Content>