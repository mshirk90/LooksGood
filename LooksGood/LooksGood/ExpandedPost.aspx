<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExpandedPost.aspx.cs" Inherits="LooksGood.ExpandedPost" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <asp:Repeater ID="rptComments" runat="server">
        <HeaderTemplate>
            <table border="1">
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <asp:Label ID="lblComments" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Comment")  %>'></asp:Label>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
