<%@ Page Title="Forgot password" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Forgot.aspx.cs" Inherits="LooksGood.Account.ForgotPassword" Async="true" %>

<asp:Content runat="server" ID="BodyContent" ContentPlaceHolderID="MainContent">
    <h2><%: Title %>.</h2>

    <div class="row">
        <div class="col-md-8">
            <asp:PlaceHolder id="loginForm" runat="server">
                <div class="form-horizontal">
                    <h4>Forgot your password?</h4>
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger" style="padding-left:25px">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>  
                    <asp:TextBox runat="server" ID="rvEmail" CssClass="form-control" Width="700px" Text="Password Revealed HERE"/>                  
                    <div class="form-group pull-left" style="padding-left:25px">
                        <asp:Label runat="server" AssociatedControlID="txtEmail" CssClass="col-md-2 control-label" ID="lblEmail">Email</asp:Label>
                        <div class="col-md-10" style="padding-left:10px">                          
                            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="Email" Width="700px"/>                         
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                                CssClass="text-danger" ErrorMessage="The email field is required." ID="EmailVal"/>                            
                        </div>
                    </div>
                    <div class="form-group pull-left">
                        <div class="col-md-10 pull-left">                           
                            <asp:Button runat="server" OnClick="Reveal" Text="Reveal Password" CssClass="btn btn-default pull-left div-margin" ID="revealEmail"/>
                            <asp:Button runat="server" OnClick="Forgot" Text="Reset Password" CssClass="btn btn-default" ID="forgotEmail" />
                        </div>
                    </div>
                </div>
            </asp:PlaceHolder>
            <asp:PlaceHolder runat="server" ID="DisplayEmail" Visible="false">
                <p class="text-info">
                    Please check your email to reset your password.
                </p>
            </asp:PlaceHolder>
        </div>
    </div>
</asp:Content>
