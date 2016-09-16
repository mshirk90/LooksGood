<%@ Page Title="ExpandedPost" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExpandedPost.aspx.cs" Inherits="LooksGood.ExpandedPost" %>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="padding-left: 25px">
        <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Font-Size="XX-Large">
        </asp:Label>
    </div>
    <div style="padding-left: 35px">
        <asp:Label ID="lblTitle" runat="server" Font-Italic="true" Font-Size="X-Large">
        </asp:Label>
    </div>
    <div style="padding-left: 25px">
        <asp:Image ID="imgPost" runat="server"></asp:Image>
    </div>
    <asp:Repeater ID="rptComments" runat="server">
        <HeaderTemplate>
        </HeaderTemplate>
        <ItemTemplate>
            <div class="container left" style="border: 0px solid black">
                <div class="dialogbox">
                    <div class="body">
                        <span class="tip tip-up"></span>
                        <div class="message">
                            <span><%# DataBinder.Eval(Container.DataItem, "Comment")  %></span>
                            <hr />
                            <span><%# "Commented by: " + DataBinder.Eval(Container.DataItem, "UserName")  %></span>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate>
        </FooterTemplate>
    </asp:Repeater>
    <div id="comment_form" style="padding-left:25px" class="div-margin">
        <div>
            <asp:TextBox rows="10" name="comment" id="cmtComment" placeholder="Comment" runat="server"></asp:TextBox>
        </div>
        <div>
            <asp:Button type="submit" name="submit" text="Submit Comment" onclick="comSubmit" runat="server" ID="btnSubmit" />
        </div>

    </div>
</asp:Content>
