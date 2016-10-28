<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="Upload.aspx.cs" Inherits="LooksGood.Account.Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
        .auto-style1 {
            width: 10px;
        }
    </style>

    <div>
    </div>
    <table style="width: 605px">
        <tr>
            <td class="auto-style1">
                <asp:Label ID="lblTitle" runat="server" Font-Names="Cooper Std Black" Text="Title:  "></asp:Label>
            </td>
            <td>
                <asp:TextBox ID="txtTitle" style="color:black" runat="server" Width="219px"></asp:TextBox>
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                <asp:Label ID="lblUpload" runat="server" Text="Upload:  " Font-Names="Cooper Std Black"></asp:Label>
            </td>
            <td>
                <asp:FileUpload runat="server" ID="fuUpload" />
            </td>
        </tr>
        <tr>
            <td class="auto-style1">
                <asp:Label ID="lblDescription" runat="server" Text="Description:  " Font-Names="Cooper Std Black"></asp:Label>
            </td>
            <td>&nbsp;<asp:TextBox style="color:black" ID="txtDesription" runat="server" Rows="3" TextMode="MultiLine" Width="390px"></asp:TextBox>
                <asp:Button ID="btnPost" runat="server" Font-Names="Cooper Std Black" OnClick="btnPost_Click" Text="Post" />
            </td>
        </tr>
    </table>


</asp:Content>

