<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LooksGood._Default" %>


<asp:Content ID="header2" ContentPlaceHolderID="header2" runat="server">
</asp:Content>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <asp:Repeater ID="rptImages" runat="server">
            <ItemTemplate>
                <div>
                    <a href='<%# "ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID")  %>'>
                        <h3 class="titlecenter"><%# DataBinder.Eval(Container.DataItem, "Title")  %></h3>
                        <div id="image" class="image">
                            <asp:Image ID="imgImage" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath")  %>' Width="560" Height="445" />
                        </div>
                        <div>
                            <div class="descript">
                                <p>Description: <%# DataBinder.Eval(Container.DataItem, "Description")  %></p>
                                <h6 class="uName">-<%# DataBinder.Eval(Container.DataItem,"UserName")  %></h6>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="customHr">
                    <hr class="customHr" />
                </div>
            </ItemTemplate>
        </asp:Repeater>
    </div>
</asp:Content>
