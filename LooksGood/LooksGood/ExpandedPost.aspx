<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExpandedPost.aspx.cs" Inherits="LooksGood.ExpandedPost" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
   
    <asp:Image ID="imgPost" runat="server">

    </asp:Image>
    
     <asp:Repeater ID="rptComments" runat="server">
        <HeaderTemplate>
            <table border="1">
        </HeaderTemplate>
        <ItemTemplate>
            <tr>
                <td>
                    <div>
                        <asp:Label ID="lblComments" runat="server" Text='<%# DataBinder.Eval(Container.DataItem, "Comment")  %>'></asp:Label>
                    </div>
                    <div>
                        <asp:Label ID="lblUserName" runat="server" Text='<%# "Commentd by: " + DataBinder.Eval(Container.DataItem, "UserName")  %>'></asp:Label>
                    </div>
                </td>
            </tr>
        </ItemTemplate>
        <FooterTemplate>
            </table>
        </FooterTemplate>
    </asp:Repeater>
</asp:Content>
