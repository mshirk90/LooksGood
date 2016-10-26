<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LooksGood._Default" %>

<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div class="contain">
        <div ng-app="MyApp" ng-controller="MyController" id="myCarousel" class="carousel slide" data-ride="carousel">
            <div class="carousel-inner" role="listbox">

                <div id="{{x.Index}}" class="item" ng-class="{active:!$index}" ng-repeat="x in post">

                    <a><h3 class="textfix"><span>{{x.Title}} </span></h3></a>
                    <a id="EPhref" href="ExpandedPost.aspx?postId={{x.Id}}">
                        <div>
                            <img src="{{x.ImagePath}}" width="85%" height="75%" class="imagefix" />
                        </div>
                    </a>
                   <a><h4 class="textfix"><span>Description: {{x.Description}}</span></h4></a> 
                   <a><div>Posted By: {{x.UserName}}</div></a> 
                </div>
                <!-- Left and right controls -->
                <a class="left carousel-control" href="#myCarousel" role="button" data-slide="prev">
                    <span class="glyphicon glyphicon-chevron-left"></span>
                    <span class="sr-only">Previous</span>
                </a>
                <a class="right carousel-control" href="#myCarousel" role="button" data-slide="next">
                    <span class="glyphicon glyphicon-chevron-right"></span>
                    <span class="sr-only">Next</span>
                </a>

            </div>
        </div>
    </div>
    

    <style>
        .h6 {
            margin-bottom: -20px;
            padding-bottom: -20px;
        }

        .imagefix {
            text-align: center;
            margin:auto;
        }
        .textfix{
            margin-bottom: 5px;
            margin-top: 7px;
        }
    </style>

    <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
    <script>
        var app = angular.module("MyApp", []);
        app.controller("MyController", function ($scope) {
            $scope.post = [];

            angular.element(document).ready(function () {
                WebServiceRequest("GetMostRecentPosts", "", OnSuccessRecentPosts, OnErrorRecentPosts);
            });

            function OnSuccessRecentPosts(response) {
                //alert(response.d);
                $scope.post = JSON.parse(response.d);
                $scope.$apply();
            }

            function OnErrorRecentPosts(response) {
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

        });
    </script>
</asp:Content>








