<%@ Page Title="Logout" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Logout.aspx.cs" Inherits="LooksGood.Acct.Logout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>
    <div>
        <h1>You have successfully logged out.</h1>

        <a href="#contact" class="btn btn-circle page-scroll">
            <i class="fa fa-angle-double-down animated"></i>
        </a>
        <div class="space">
            <br />
        </div>
        <div class="space">
            <br />
        </div>
        <div class="space">
            <br />
        </div>
        <div class="space">
            <br />
        </div>
        <div class="space">
            <br />
        </div>
        <div class="space">
            <br />
        </div>
        <div class="space">
            <br />
        </div>
        <div class="space">
            <br />
        </div>
    </div>





    <section id="contact" class="download-section text-center">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <a href="#page-top" class="btn btn-circle page-scroll">
                    <i class="fa fa-angle-double-up animated"></i>
                </a>
            </div>
        </div>
        <br />
        <%--</section>--%>
        <div class="text-center">
            <div>
                <div>
                    <h2>Contact Us</h2>
                    <p>
                        <a href="mailto:feedback@startbootstrap.com">feedback@startbootstrap.com</a>
                    </p>
                    <ul class="list-inline banner-social-buttons">
                        <li>
                            <a href="https://twitter.com/SBootstrap" class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i><span class="network-name">Twitter</span></a>
                        </li>
                        <li>
                            <a href="https://github.com/IronSummitMedia/startbootstrap" class="btn btn-default btn-lg"><i class="fa fa-github fa-fw"></i><span class="network-name">Github</span></a>
                        </li>
                        <li>
                            <a href="https://plus.google.com/+Startbootstrap/posts" class="btn btn-default btn-lg"><i class="fa fa-google-plus fa-fw"></i><span class="network-name">Google+</span></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>
    <script>
        $(document).ready(function () {
            $('html, body').animate({
                scrollTop: $('.space').offset().top
            }, 'slow');
        });
    </script>
</asp:Content>
