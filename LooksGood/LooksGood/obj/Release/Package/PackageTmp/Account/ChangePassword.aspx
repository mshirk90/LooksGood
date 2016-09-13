<%@ Page Title="" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="ChangePassword.aspx.cs" Inherits="LooksGood.Account.ChangePassword" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="form-group">
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtOldPassword" TextMode="Password" CssClass="form-control" PlaceHolder="Old Password" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtOldPassword" CssClass="text-danger" ErrorMessage="The password field is required." ValidationGroup="vgChangePassword">*</asp:RequiredFieldValidator>
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtNewPassword" TextMode="Password" CssClass="form-control" PlaceHolder="New Password" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtNewPassword" CssClass="text-danger" ErrorMessage="The password field is required." ValidationGroup="vgChangePassword">*</asp:RequiredFieldValidator>
        </div>

    </div>
    <div class="form-group">
        <div class="col-md-10">
            <asp:TextBox runat="server" ID="txtConfirmPassword" TextMode="Password" CssClass="form-control" PlaceHolder="Confirm Password" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtConfirmPassword" CssClass="text-danger" ErrorMessage="The password field is required." ValidationGroup="vgChangePassword">*</asp:RequiredFieldValidator>
        </div>
    </div>

    <div class="form-group">
        <div class="col-md-10">
            <asp:Label ID="lblStatus" runat="server"></asp:Label>
            <asp:ValidationSummary ID="vsChangePassword" runat="server" ValidationGroup="vgChangePassword" />
            <asp:Button runat="server" ID="btnChangePassword" Text="Change Password" CssClass="btn btn-default" OnClick="btnChangePassword_Click" />
            <asp:Label ID="pwRequirements" runat="server" Text="Password must contain at least on uppercaser, special, and numerical character."></asp:Label>
        </div>
    </div>
</asp:Content>
