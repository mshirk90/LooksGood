<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LooksGood._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">


    <div class="container">
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Looks Good
                    <small>in progress...</small>
                </h1>
            </div>
        </div>
    </div>
    <div class="container">
        <br>
        <div id="myCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner" role="listbox">
                <asp:Repeater ID="rptImages" runat="server">
                    <ItemTemplate>
                        <div class="item active"> 
                            <a href='<%# "ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID")  %>'>
                                <h3 class="titlecenter"><%# DataBinder.Eval(Container.DataItem, "Title")  %></h3>
                                <asp:Image ID="imgImage" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath")  %>' Width="460" Height="345" CssClass="margincenter" />
                                <div>
                                    <div class="descript">
                                    <p><%# DataBinder.Eval(Container.DataItem, "Description")  %></p>
                                    </div>
                                    <div style="padding-left: 655px">                                        
                                        <h6 class="uName">-<%# DataBinder.Eval(Container.DataItem,"UserName")  %></h6>
                                    </div>
                                </div>              
                            </a>
                        </div>                        
                    <div class="customHr"><hr class="customHr" /></div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>
