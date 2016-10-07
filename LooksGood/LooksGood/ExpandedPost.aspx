<%@ Page Title="ExpandedPost" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExpandedPost.aspx.cs" Inherits="LooksGood.ExpandedPost" %>




<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #vote {
            width: 50px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    

    <div style="padding-left: 25px">
        <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Font-Size="XX-Large">
        </asp:Label>
    <div>
    
        <asp:Label ID="lblTitle" runat="server" Font-Italic="false" Font-Size="X-Large">
        </asp:Label>
   <div>

        <asp:Label ID="lblDescription" runat="server" Font-Size="Larger"></asp:Label>
                <hr style="display: inline-block; width: 90%" />
</div>
</div>
    </div>
    <div style="padding-left: 25px">
        <asp:Image ID="imgPost" runat="server" ></asp:Image>
        <hr style="display:inline-block; width:90%"/>
    </div>

    <div id="comment_form" style="padding-left: 25px" class="div-margin">
        <div>
            <asp:TextBox Rows="10" name="comment" ID="cmtComment" placeholder="Comment" runat="server"></asp:TextBox>
        </div>
        <div>
            <asp:Button type="submit" name="submit" Text="Submit Comment" OnClick="comSubmit" runat="server" ID="btnSubmit" />
        </div>
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
                            <a href='<%# "/Account/Profile.aspx?userId=" + DataBinder.Eval(Container.DataItem, "userId")  %>'>
                            <span><%# "Commented by: " + DataBinder.Eval(Container.DataItem, "UserName")  %></span>
                                  </a>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate>
        </FooterTemplate>
    </asp:Repeater>

</asp:Content>

