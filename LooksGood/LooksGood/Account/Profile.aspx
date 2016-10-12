<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="LooksGood.Account.Profile" Async="true" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">
        <asp:Label ID="lblUserName" runat="server" Font-Italic="true" Font-Size="X-Large">
        </asp:Label>

        <div class="padding-left: 25px">
            <asp:Image ID="imgProfile" runat="server" BorderStyle="Solid" BorderColor="Red" BorderWidth="3px"></asp:Image>
            <asp:FileUpload ID="fuChangeProfileImage" runat="server" />
            <asp:Button ID="btnChangePicture" runat="server" OnClick="btnChangePicture_Click" Text="Change Profile Picture" />
            <br />
        </div>
        <div>
            <label>User Posts</label>
        </div>
        <hr style="display: inline-block; width: 90%" />
        <asp:Repeater ID="rptPost" runat="server">
            <ItemTemplate>
                <a href='<%# "../ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID")  %>'>
                    <div class="container left" style="border: 0px solid black; display: inline">
                        <div class="dialogbox">
                            <div class="body">
                                <span class="tip tip-up"></span>
                                <div class="message">
                                    <a class="a2"><span><%# DataBinder.Eval(Container.DataItem, "Title")  %></span></a>
                                    <hr />
                                    <a class="a2"><span><%# "Post Description: " + DataBinder.Eval(Container.DataItem, "Description")  %></span></a>
                                </div>
                            </div>
                        </div>
                    </div>
                </a>
            </ItemTemplate>
        </asp:Repeater>
        <hr style="display: inline-block; width: 90%" />
        <div>
            <label>User Comments</label>
            <div>
            </div>
            <div>
                <asp:Repeater ID="rptComments" runat="server">
                    <ItemTemplate>
                        <div class="container left" style="border: 0px solid black">
                            <div class="dialogbox">
                                <div class="body">
                                    <span class="tip tip-up"></span>
                                    <div class="message">
                                        <a runat="server" itemid="imgProfile"></a>
                                        <span style="color:black"><%# DataBinder.Eval(Container.DataItem, "Comment")  %></span>
                                        <hr />
                                        <a class="a2" href='<%# "../ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "PostId")  %>'>
                                       <span><%# "Commented by: " + DataBinder.Eval(Container.DataItem, "UserName")  %></span></a>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
                <hr style="display: inline-block; width: 90%" />
            </div>
        </div>
    </div>
</asp:Content>