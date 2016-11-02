<%@ Page Title="Profile" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Profile.aspx.cs" Inherits="LooksGood.Account.Profile" Async="true" %>


<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <input type="hidden" class="form-control" id="vote" postid='<%=Request.QueryString["postId"] %>' userid='<%=Request.QueryString["userId"] %>' />
    <div ng-app="profileApp">
        <asp:Label ID="lblUserName" runat="server" Font-Italic="true" Font-Size="X-Large" class="paddingleft">
        </asp:Label>

        <div class="paddingleft">
            <asp:Image ID="imgProfile" runat="server" BorderStyle="Solid" BorderColor="Red" BorderWidth="3px"></asp:Image>
            <asp:FileUpload ID="fuChangeProfileImage" runat="server" />
            <asp:Button ID="btnChangePicture" runat="server" OnClick="btnChangePicture_Click" Text="Change Profile Picture" />
        </div>

        <div>
            <hr class="customHr" />
        </div>

        <div>
            <label class="paddingleft">User Posts</label>
            <hr class="customHr" />
        </div>

        <div ng-controller="UserPost">
            <div ng-repeat="x in userPost">
                <div class="clearfix" ng-if="$index % 3 == 0"></div>
                <div class="col-sm-4" style="padding-left: 8%">
                    <div class="dialogbox">
                        <div class="body">
                            <a href="../ExpandedPost.aspx?postId={{x.Id}}">
                                <span style="color: #00b7fc">Post Title: {{x.Title}}</span>
                                <div class="message">
                                    <span style="color: #00b7fc">{{x.Description}}</span>
                                    <div>
                                        <span style="color: #00b7fc">Uploaded on: {{x.LastUpdated | date : "short"}}</span>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="clearfix">
            <div class="row">
                <hr class="customHr" />
            </div>
            <div>
                <label class="paddingleft">User Comments</label>
                <hr class="customHr" />
            </div>
        </div>

        <div ng-controller="UserComments">
            <div ng-repeat="x in userComments">
                <div class="clearfix" ng-if="$index % 3 == 0"></div>
                <div class="col-sm-4" style="padding-left: 8%">
                    <div class="dialogbox">
                        <div class="body">
                            <a class="a2" href="/ExpandedPost?postId={{x.PostId}}">
                                <span style="color: #00b7fc">Comment: {{x.Comment}}</span>
                                <div class="message">
                                    <span style="color: #00b7fc">Commented on Post: {{x.PostTitle}}</span>
                                </div>
                            </a>
                            <span style="color: #00b7fc">Uploaded on: {{x.LastUpdated | date : "short"}}</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        function WebServiceRequest(strMethod, jsonData, cbSuccess, cbError) {
            $.ajax({
                type: 'POST',
                url: '/LooksGoodWS.asmx/' + strMethod,
                data: jsonData,
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: cbSuccess,
                error: cbError
            });
        }

        var app = angular.module("profileApp", []);
        app.controller("UserPost", function ($scope) {
            $scope.userPost = [];
            angular.element(document).ready(function () {
                var postId = vote.getAttribute("postid");
                var userId = vote.getAttribute("userId");
                WebServiceRequest("GetUserPostById", "{'userId': '" + userId + "'}", userPostSuccess, userPostFailure);
            });

            function userPostSuccess(response) {
                $scope.userPost = JSON.parse(response.d);
                $scope.$apply();
                //alert(response.d)
            }
            function userPostFailure(response) {
                alert(response.responseText);
            }

        });

        app.controller("UserComments", function ($scope) {
            $scope.userComments = [];
            $scope.commentPost = {};
            angular.element(document).ready(function () {
                var postId = vote.getAttribute("postid");
                var userId = vote.getAttribute("userId");
                var commentId = $('cmtId').val();
                WebServiceRequest("GetUserCommentsById", "{'userId': '" + userId + "'}", userCommentSuccess, userCommentFailure);
            });

            function userPostSuccess1(response) {
                $scope.commentPost = JSON.parse(response.d);
                $scope.$apply();
                alert(response.d)
            }
            function userPostFailure1(response) {
                alert(response.responseText);
            }

            function userCommentSuccess(response) {
                $scope.userComments = JSON.parse(response.d);
                $scope.$apply();
                //alert(response.d)
            }
            function userCommentFailure(response) {
                alert(response.responseText);
            }

        });
    </script>
</asp:Content>

