<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LooksGood._Default" %>





<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">

    <div ng-app="MyApp" ng-controller="MyController" ID="rptImages" >
        <section ng-repeat="x in post" id="{{}}">            
                <div>
                    <%--<a href='<%#--%> 
                        
                        <h3 class="titlecenter"></h3>
                        <div>
                            <img ID="imgImage" src="{{x.ImagePath}}" height="100%" width="80%"/>
                        </div>                                                                   
                            <p>{{x.Title}}</p>                       
                        <a href="#about" class="btn btn-circle page-scroll">
                            <i class="fa fa-angle-double-down animated"></i>
                        </a>
                        <div>
                            <div class="triangle-isosceles" >
                                <p>Description: {{x.Description}}</p>
                                <h6>-Posted By: {{x.UserName}}</h6>
                            </div>
                        </div>
                    </a>
                </div>
                <div class="customHr">
                    <hr class="customHr" />
                </div>
        </section>
    </div>   
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
