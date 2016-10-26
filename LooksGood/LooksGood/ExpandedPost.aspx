<%@ Page Title="ExpandedPost" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExpandedPost.aspx.cs" Inherits="LooksGood.ExpandedPost" %>




<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #vote {
            width: 42px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" style="color: red">
    <input type="hidden" class="form-control" id="vote" postid='<%=Request.QueryString["postId"] %>' userid='<%=Request.QueryString["userId"] %>' />
    <div class="contain" ng-app="MyApp">
        <div ng-controller="MyController">
            <div>
                <div class="item" ng-model="post" id="{{x.Index}}">
                    <a>
                        <h3 class="textfix"><span>{{post.Title}} </span></h3>
                    </a>
                    <div>
                        <img ng-src="{{post.ImagePath}}" width="85%" height="75%" class="imagefix" />
                    </div>
                    <a>
                        <h4 class="textfix"><span>Description: {{post.Description}}</span></h4>
                    </a>
                    <a>
                        <div>Posted By: {{post.UserName}}</div>
                    </a>
                </div>
            </div>
        </div>        
        <div id="comment_form" style="padding-left: 25px" class="div-margin">
            <div>
                <textarea class="textarea" style="color: #00b7fc" cols="50" rows="3" name="comment" id="cmtComment" placeholder="Comment"></textarea>
            </div>
            <br />
            <div>
                <input type="submit" name="submit" value="Submit Comment" id="btnSubmit" style="background-color: #a8a9a9; color: #00b7fc" />
            </div>
        </div>
        <br />
        <br />

        <div ng-controller="commentController" class="row">
            <div ng-repeat="x in comments">
                <div class="clearfix" ng-if="$index % 3 == 0"></div>
                <div class="col-sm-4" style="padding-left:8%">
                    <div class="dialogbox">
                        <div class="body">
                            <span style="color: #00b7fc">{{x.UserName}} Says</span>
                            <div class="message">
                                <a class="a2" href="/Account/Profile.aspx?userId={{x.UserId}}">
                                    <span style="color: #00b7fc">{{x.Comment}}</span>
                                    <div>
                                    <span style="color: #00b7fc">at: {{x.LastUpdated | date : "short"}}</span>
                                        </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <%-- class="separated" style="text-align: center; padding-left: 30%; column-count: 2; display: inline-block">--%>               
                <%--<div class="dialogbox">
                    <div class="body ; row" style="text-align: center">
                        <span style="color: #00b7fc">{{x.Comment}}</span>
                        <div class="message">
                            <a class="a2" href="/Account/Profile.aspx?userId={{x.UserId}}">
                                <span>Commented by: {{x.UserName}}</span>
                                <span>at: {{x.LastUpdated | date : "short"}}</span>
                            </a>
                        </div>
                    </div>
                </div>--%>
            </div>
        </div>
    </div>

    <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
    <script>
        var app = angular.module("MyApp", []);
        app.controller("MyController", function ($scope) {
            $scope.post = {}

            angular.element(document).ready(function () {
                var postId = vote.getAttribute("postid");
                var userid = vote.getAttribute("userId");
                if (userid === "") {
                    $("#cmtComment").val('Please Login to comment');
                    $("#btnSubmit").val('Please login to comment');
                    $("#cmtComment").prop("disabled", true);
                    $("#btnSubmit").prop("disabled", true);
                } else {
                    $("#cmtComment").prop("disabled", false);
                    $("#btnSumbit").prop("disabled", false);
                    $("#cmtComment").val('');
                }
                WebServiceRequest("GetPostById", "{'postId': '" + postId + "'}", postLoadSuccess, postLoadFailure)
            });

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

            function postLoadSuccess(response) {
                $scope.post = JSON.parse(response.d);
                $scope.$apply;
                //alert(response.d);
            }
            function postLoadFailure(response) {
                alert(response.d.responseText);
            }           
        });

        app.controller("commentController", function ($scope) {
            $scope.comments = [];

            angular.element(document).ready(function () {
                var postId = vote.getAttribute("postid");
                var userid = vote.getAttribute("userId");

                WebServiceRequest("GetCommentsByPostId", "{'postId': '" + postId + "'}", commentSuccess, commentFailure)
            });

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

            function commentSuccess(response) {
                $scope.comments = JSON.parse(response.d);
                $scope.$apply();
                //alert(response.d);

            }
            function commentFailure(response) {
                alert(response.d.responseText);
            }

            $("#btnSubmit").click(function () {
                var postid = $("#vote").attr("postId").toString();
                var commentText = $("#cmtComment").val();
                var userid = $("#vote").attr("userid").toString();
                WebServiceRequest("SubmitComment", "{'postid': '" + postid + "', 'commentText': '" + commentText + "', 'userid': '" + userid + "'}", commentSuccess, commentFailure)
            });

        });
    </script>
    <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
</asp:Content>




