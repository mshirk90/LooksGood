<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LooksGood._Default" %>





<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div>
        <asp:Repeater ID="rptImages" runat="server">
            <ItemTemplate>
                <div>
                    <a href='<%# "ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID")  %>'>
                        <h3 class="titlecenter"><%# DataBinder.Eval(Container.DataItem, "Title")  %></h3>
                        <div>
                            <asp:Image ID="imgImage" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath")  %>' Width="90%" Height="80%" />
                        </div>
                                        <p class="intro-text">
                            <%--text--%>
                            <br>
                            Get Started Now!
                        </p>
                        <a href="#about" class="btn btn-circle page-scroll">
                            <i class="fa fa-angle-double-down animated"></i>
                        </a>
                        <div>
                            <div class="triangle-isosceles" >
                                <p>Description: <%# DataBinder.Eval(Container.DataItem, "Description")  %></p>
                                <h6>-<%# DataBinder.Eval(Container.DataItem,"UserName")  %></h6>
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
<%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
    <%--<script>
        var app = angular.module("MyApp", []);
        app.controller("MyController", function ($scope) {
            $scope.post = [];

            angular.element(document).ready(function () {
                WebServiceRequest("GetMostRecentPosts", "", OnSuccessRecentPosts, OnErrorRecentPosts);
            });    
           
            function OnSuccessRecentPosts(response){
                // do stuff
                alert(response.d);
                $scope.post = JSON.parse(response.d);
                $scope.$apply();
            }
            function OnErrorRecentPosts(response){
                // do stuff again
                alert(response.responseText);
            }

            function WebServiceRequest(strMethod, jsonData, cbSuccess, cbError) {
                $.ajax({
                    type: 'POST',
                    url: 'LooksGoodWS.asmx/' + strMethod,
                    data: jsonData,
                    contentType: 'application/json; charset=utf-8',
                    dataType: 'json',
                    success: cbSuccess,
                    error: cbError
                });
            }
        })
    </script>--%>
</asp:Content>
