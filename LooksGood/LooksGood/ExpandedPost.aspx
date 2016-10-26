﻿<%@ Page Title="ExpandedPost" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExpandedPost.aspx.cs" Inherits="LooksGood.ExpandedPost" %>




<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #vote {
            width: 42px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" style="color: red">
    <input type="hidden" class="form-control" id="vote" postid='<%=Request.QueryString["postId"] %>' userid='<%=Request.QueryString["userId"] %>' />
    <div ng-app="MyApp" style="border: solid 5px" ng-controller="MyController">
        <div ng-repeat="x in post" style="padding-left: 25px">
            <Label ID="lblHeader" Font-Bold="true" Font-Size="XX-Large" >{{x.UserName}}</Label>
            <div>
                <asp:Label ID="lblTitle" runat="server" Font-Italic="false" Font-Size="X-Large">
                </asp:Label>
                <div>
                    <asp:Label ID="lblDescription" runat="server" Font-Size="Larger"></asp:Label>
                    <%--<hr style="display: inline-block; width: 90%" />--%>
                </div>
            </div>
        </div>
        <div style="padding-left: 25px">
            <asp:Image ID="imgPost" runat="server" Width="760px" Height="600px"></asp:Image>
            <br />
            <br />
            <%--<div class="well">
            <div class="row">
                <div class="col-sm-3 col-md-3 col-lg-3">
                    <div class="input-group">
                        <button type="button" id="decreaseButton" class="btn btn-danger" style="background-color: #FF0000; width: 24px; font-weight: bold;">-</button>&nbsp;--%>


            <%--<button type="button" id="increaseButton" class="btn btn-success" style="background-color: #00CC00; font-weight: bold;">+</button>--%>
            <%--</div>
                </div>
            </div>
        </div>
       <hr class="customHr" />
    </div>--%>
        </div>
        <div>
            <div></div>
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
        <div>
            <div ng-repeat="x in comments" class="separated" style="text-align: center; padding-left: 30%; column-count: 2; display: inline-block">
                <div class="dialogbox">
                    <div class="body ; row" style="text-align: center">
                        <span style="color: #00b7fc">{{x.Comment}}</span>
                        <div class="message">
                            <a class="a2" href="/Account/Profile.aspx?userId={{x.UserId}}">
                                <span>Commented by: {{x.UserName}}</span>
                                <span>at: {{x.LastUpdated | date : "short"}}</span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
    <script>
        var app = angular.module("MyApp", []);
        app.controller("MyController", function ($scope) {
            $scope.comments = [];
            $scope.post;

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
                WebServiceRequest("GetCommentsByPostId", "{'postId': '" + postId + "'}", commentSuccess, commentFailure)
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

            function postLoadSuccess(response)
            {
                $scope.post = JSON.parse(response.d);
                $scope.$apply;
                alert(response.d);
            }
            function postLoadFailure(response) {
                alert(response.d.responseText);
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




