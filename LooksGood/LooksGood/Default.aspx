<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LooksGood._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <!-- Page Content -->
    <div class="container">

        <!-- Page Header -->
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
            <!-- Indicators -->

            <!-- Wrapper for slides -->
            <div class="carousel-inner" role="listbox">
                <asp:Repeater ID="rptImages" runat="server">
                    <ItemTemplate>
                        <div class="item active"> 
                            <a href='<%# "ExpandedPost.aspx?Id=" + DataBinder.Eval(Container.DataItem, "ID")  %>'>
                                <h3 style="padding-left: 430px"><%# DataBinder.Eval(Container.DataItem, "Title")  %></h3>
                                <asp:Image ID="imgImage" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath")  %>' Width="460" Height="345" />
                                <div>
                                    <div style="padding-left: 240px">
                                    <p><%# DataBinder.Eval(Container.DataItem, "Description")  %></p>
                                    </div>
                                    <div style="padding-left: 655px">                                        
                                        <h6 class="h6">-<%# DataBinder.Eval(Container.DataItem,"UserName")  %></h6>
                                    </div>
                                </div>              
                            </a>
                        </div>                        
                    <div class="customHr"><hr class="customHr" /></div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

            <!-- Left and right controls -->
            <%--            <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
                <span class="sr-only">Previous</span>
            </a>
            <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
                <span class="sr-only">Next</span>
            </a>--%>


            <%--            <script>
jQuery(function(){
    jQuery('#carRight').click();
});
</script>--%>
        </div>
    </div>
</asp:Content>
