<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="LooksGood.Account.Profile" Async="true" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div>
        <asp:Label ID="lblUserName" runat="server" Font-Italic="true" Font-Size="X-Large" class="paddingleft">
        </asp:Label>

        <div class="paddingleft">
            <asp:Image ID="imgProfile" runat="server" BorderStyle="Solid" BorderColor="Red" BorderWidth="3px"></asp:Image>
            <asp:FileUpload ID="fuChangeProfileImage" runat="server" />
            <asp:Button ID="btnChangePicture" runat="server" OnClick="btnChangePicture_Click" Text="Change Profile Picture" />

        </div>
        <div>
            <hr class="customHr" />
        </div>

        <div>
            <label class="paddingleft">User Posts</label>
            <hr class="customHr" />
        </div>
        <asp:Repeater ID="rptPost" runat="server">
            <ItemTemplate>
                <a href='<%# "../ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID")  %>'>
                    <div class="container left" style="border: 0px solid black; display: inline">
                        <div class="dialogbox">
                            <div class="body">
                                <span class="tip tip-up"></span>
                                <div class="message">
                                    <span style="color: black"><%# DataBinder.Eval(Container.DataItem, "Title")  %></span>
                                    <hr class="customHr" />
                                    <a class="a2" href='<%# "../ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "Id")  %>'>
                                        <span style="color: black"><%# "Post Description: " + DataBinder.Eval(Container.DataItem, "Description")  %></span>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </ItemTemplate>
        </asp:Repeater>


        <hr class="customHr" />


        <div>
            <label class="paddingleft">User Comments</label>
            <hr class="customHr" />
        </div>
        <asp:Repeater ID="rptComments" runat="server">
            <ItemTemplate>
                <div class="container left" style="border: 0px solid black">
                    <div class="dialogbox">
                        <div class="body">
                            <span class="tip tip-up"></span>
                            <div class="message">
                                <a runat="server" itemid="imgProfile"></a>
                                <span style="color: black"><%# DataBinder.Eval(Container.DataItem, "Comment")  %></span>
                                <hr class="customHr" />
                                <a class="a2" href='<%# "../ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "PostId")  %>'>
                                    <span><%# "Commented by: " + DataBinder.Eval(Container.DataItem, "UserName")  %></span></a>
                            </div>
                        </div>
                    </div>
                </div>
            </ItemTemplate>
        </asp:Repeater>
        <hr class="ghostHr" />
    </div>
</asp:Content>

