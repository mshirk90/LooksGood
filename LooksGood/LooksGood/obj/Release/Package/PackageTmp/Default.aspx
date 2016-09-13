<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LooksGood._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

   <!-- Page Content -->
    <div class="container">

        <!-- Page Header -->
        <div class="row">
            <div class="col-lg-12">
                <h1 class="page-header">Page Heading
                    <small>Secondary Text</small>
                </h1>
            </div>
        </div>
        <!-- /.row -->

        <asp:DataList ID="dlPost" runat="server" RepeatColumns="2" RepeatDirection="Horizontal" >
            <ItemTemplate>
                <!-- Projects Row -->
                <div class="row">
                    <div class="col-md-6 portfolio-item">
                        <a href="#">
                            <img class="img-responsive" src="http://placehold.it/700x400" alt="">
                        </a>
                        <h3>
                            <a href="#">Project One</a>
                        </h3>
                        <p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam viverra euismod odio, gravida pellentesque urna varius vitae.</p>
                    </div>
                </div>
            </ItemTemplate>
            <FooterTemplate>
                <!-- Pagination -->
                <div class="row text-center">
                    <div class="col-lg-12">
                        <ul class="pagination">
                            <li>
                                <a href="#">&laquo;</a>
                            </li>
                            <li class="active">
                                <a href="Default.aspx">1</a>
                            </li>
                            <li>
                                <a href="Default.aspx">2</a>
                            </li>
                            <li>
                                <a href="Default.aspx">3</a>
                            </li>
                            <li>
                                <a href="Default.aspx">4</a>
                            </li>
                            <li>
                                <a href="Default.aspx">5</a>
                            </li>
                            <li>
                                <a href="#">&raquo;</a>
                            </li>
                        </ul>
                    </div>
                </div>
            </FooterTemplate>
        </asp:DataList>

        <!-- /.row -->


        <!-- /.row -->

        <hr>

</asp:Content>
