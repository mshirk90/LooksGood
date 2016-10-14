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
    <%--<div ng-app="MyApp" ng-controller="MyController">
        <div ng-repeat="x in post">
        <a href="ExpandedPost.aspx?postId={{x.Id}}">
            <h3 class="titlecenter">{{x.Title}}</h3>
            <div id="image" class="image">
                <img src="{{x.ImagePath}}" />
            </div>
            <div>
                <div class="descript">
                    <p>Description: {{x.Description}}</p>
                    <h6 class="uName">-{{x.UserName}}</h6>
                </div>
            </div>
        </a>
    </div>
    <div class="customHr">
        <hr class="customHr" />
        </div>
    </div>--%>
<%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
    <script>
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
    </script>
</asp:Content>
