<%@ Page Title="ExpandedPost" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExpandedPost.aspx.cs" Inherits="LooksGood.ExpandedPost" %>




<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #vote {
            width: 42px;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" style="color: red">
    <div ng-app="MyApp" style="border:solid 5px">
        <div style="padding-left: 25px">
            <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Font-Size="XX-Large">
            </asp:Label>
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
            <input type="hidden" class="form-control" id="vote" postid='<%=Request.QueryString["postId"] %>' userid='<%=Request.QueryString["userId"] %>' />

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
        <div ng-controller="MyController" class="x">
            <div ng-repeat="x in comments">
                <div class="dialogbox" style="text-align: center; padding-left: 10%">
                    <div class="body row" style="text-align: center">
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

            angular.element(document).ready(function () {
                var id = vote.getAttribute("postid");
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
                GetCommentsByPostId(id);
                //GetVotes(id);
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
                alert(response.d);

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



            function GetCommentsByPostId(id) {
                $.ajax({
                    type: 'POST',
                    url: 'LooksGoodWS.asmx/GetCommentsByPostId',
                    dataType: 'json',
                    processData: false,
                    data: "{'id': '" + id + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (response) {
                        alert(response.d);
                        $scope.comments = JSON.parse(response.d);
                        $scope.$apply();
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }

            function GetVotes(id) {
                $.ajax({
                    type: 'POST',
                    url: 'LooksGoodWS.asmx/GetVotesByPostId',
                    dataType: 'json',
                    processData: false,
                    data: "{'id': '" + id + "'}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (response) {
                        var txtVote = document.getElementById('vote');
                        //alert(response.d);
                        txtVote.value = response.d.Votes;
                    },
                    error: function (response) {
                        alert(response.responseText);
                    },

                });
            }

            function ChangeVotes(id, change) {
                $.ajax({
                    type: 'POST',
                    url: 'LooksGoodWS.asmx/ChangeVotesByPostId',
                    dataType: 'json',
                    processData: false,
                    data: "{'id': '" + id + "', 'change': " + change + "}",
                    contentType: 'application/json; charset=utf-8',
                    success: function (response) {
                        var txtVote = document.getElementById('vote');
                        //alert(response.d);
                        txtVote.value = response.d.Votes;
                    },
                    error: function (response) {
                        alert(response.responseText);
                    }
                });
            }

            // Create a click handler for your increment button
            $("#increaseButton").click(function () {
                var postId = $("#vote").attr("postId").toString();
                $("#vote").text(ChangeVotes(postId, 1));
            });
            // .. and your decrement button
            $("#decreaseButton").click(function () {
                var postId = $("#vote").attr("postId").toString();
                $("#vote").text(ChangeVotes(postId, -1));
            });
        });
    </script>
    <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
</asp:Content>




