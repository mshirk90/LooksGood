<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LooksGood._Default" %>


<asp:Content ID="header2" ContentPlaceHolderID="header2" runat="server">
    <div id="body">
        <h2><em>Welcome</em> <em>to Looks Good</em></h2>
        <p>This is a template designed by <a href="http://www.freewebsitetemplates.com">free website templates</a> for you for free you can replace all the text by your own text.</p>
        <p>This is just a place holder so you can see how the site would look like.</p>
        <p>You can remove any link to our websites from this template you're free to use the template without linking back to us.</p>
        <img src="images/pic_1.jpg" /><img src="images/pic_2.jpg" /><img src="images/pic_3.jpg" /><img src="images/pic_4.jpg" /><img src="images/pic_5.jpg" />
        <p class="more"><a href="#">more</a></p>
    </div>
</asp:Content>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="container">
        <asp:Repeater ID="rptImages" runat="server">
            <ItemTemplate>
                <div class="titlecenter">
                    <a href='<%# "ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID")  %>'>
                        <%--<h3 class="titlecenter"><%# DataBinder.Eval(Container.DataItem, "Title")  %></h3>--%>
                        <div id="image" class="image">
                            <asp:Image ID="imgImage" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath")  %>' Width="560" Height="445" />
                        </div>
                        <div>
                            <div class="descript">
                                <%--<p><%# DataBinder.Eval(Container.DataItem, "Description")  %></p>--%>
                            </div>
                            <div style="padding-left: 60%">
                               <%-- <h6 class="uName">-<%# DataBinder.Eval(Container.DataItem,"UserName")  %></h6>--%>
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
