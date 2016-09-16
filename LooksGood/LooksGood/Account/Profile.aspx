﻿<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="LooksGood.Account.Profile" Async="true" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">
        <asp:Label ID="lblUserName" runat="server" Font-Italic="true" Font-Size="X-Large">
        </asp:Label>

        <div class="padding-left: 25px">
            <asp:Image ID="imgProfile" runat="server"></asp:Image>
        </div>
    </div>
</asp:Content>

