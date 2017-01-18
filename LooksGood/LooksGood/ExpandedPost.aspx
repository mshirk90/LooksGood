<%@ Page Title="ExpandedPost" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExpandedPost.aspx.cs" Inherits="LooksGood.ExpandedPost" %>




<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #vote {
            width: 42px;
        }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server" style="color: red">
    <input type="hidden" class="form-control" id="vote" postid='<%=Request.QueryString["postId"] %>' />
    <div class="contain" ng-app="expandedPostModule">
        <div>
        </div>
    </div>
    <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
    <script>
        $(document).ready(function () {
            $('html, body').animate({
                scrollTop: $('.space').offset().top
            }, 'slow');
        });
        $("#cmtComment").val('Please Login to comment');
        $("#btnSubmit").val('Please login to comment');
        $("#cmtComment").prop("disabled", true);
        $("#btnSubmit").prop("disabled", true);
        $("#btnUpVote").prop("disabled", true);
        $("#btnDownVote").prop("disabled", true);
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
        function UserSignedIn() {
            $("#cmtComment").val('');
            $("#btnSubmit").val('Submit Comment');
            $("#cmtComment").prop("disabled", false);
            $("#btnSubmit").prop("disabled", false);
            $("#btnUpVote").prop("disabled", false);
            $("#btnDownVote").prop("disabled", false);
        }
        var expandedPost = angular.module("expandedPostModule", []);
        expandedPost.controller("postController", function ($scope) {
            $scope.post = {}
            angular.element(document).ready(function () {
                var postId = vote.getAttribute("postid");
                WebServiceRequest("GetPostById", "{'postId': '" + postId + "'}", postLoadSuccess, postLoadFailure)
                WebServiceRequest("GetVotesByPostId", "{'postId': '" + postId + "'}", VoteSuccess, VoteFailure)
            });
            function VoteSuccess(response) {
                $scope.post = JSON.parse(response.d);
                $scope.$apply();
                // alert(response.d);
            }
            function VoteFailure(response) {
                alert(response.d.responseText);
            }
            function postLoadSuccess(response) {
                $scope.post = JSON.parse(response.d);
                $scope.$apply;
                //alert(response.d);

            }
            function postLoadFailure(response) {
                alert(response.d.responseText);
            }
            $("#btnUpVote").click(function (event) {
                event.preventDefault();
                var postid = vote.getAttribute("postid");
                var votes = $("#btnUpVote").val();
                var userid = '<%=getUserId()%>';
                WebServiceRequest("SubmitVote", "{'postid': '" + postid + "', 'vote': '" + votes + "', 'userid': '" + userid + "'}", VoteSuccess, VoteFailure)
            });
            $("#btnDownVote").click(function (event) {
                event.preventDefault();
                var postid = vote.getAttribute("postid");
                var votes = $("#btnDownVote").val();
                var userid = '<%=getUserId()%>';
                WebServiceRequest("SubmitVote", "{'postid': '" + postid + "', 'vote': '" + votes + "', 'userid': '" + userid + "'}", VoteSuccess, VoteFailure)
            });
        });
        expandedPost.controller("commentController", function ($scope) {
            $scope.comments = [];

            angular.element(document).ready(function () {
                //var parentId = $("#IdforParentId").val();
                var postId = vote.getAttribute("postid");
                WebServiceRequest("GetCommentsByPostId", "{'postId': '" + postId + "'}", commentSuccess, commentFailure)
            });
            function commentSuccess(response) {
                $scope.comments = JSON.parse(response.d);
                $scope.$apply();
                var parentId = $("#IdforParentId").val();
                //alert(response.d);
                //WebServiceRequest("GetRepliesByParentId", "{'parentId': '" + parentId + "'}", repliesSuccess, repliesFailure)
                $("#cmtComment").val('');
            }
            function commentFailure(response) {
                alert(response.d.responseText);
            }

            $("#btnSubmit").click(function (event) {
                event.preventDefault();
                var postid = vote.getAttribute("postid");
                var commentText = $("#cmtComment").val();
                var userid = '<%=getUserId()%>';
                WebServiceRequest("SubmitComment", "{'postid': '" + postid + "', 'commentText': '" + commentText + "', 'userid': '" + userid + "'}", commentSuccess, commentFailure)
            });
        });
        app.controller("replyController", function ($scope) {
            $scope.textModel = "Reply Text Here"
            $scope.reply = [];
            $scope.replyFunction = function () {
                event.preventDefault();
                var postid = vote.getAttribute("postid");
                var commentText = $scope.textModel; //$("replyTextBox").val();
                var parentId = $("#getParentId").val();
                var userid = '<%=getUserId()%>';
                WebServiceRequest("SubmitReply", "{'parentId': '" + parentId + "', 'postid': '" + postid + "', 'commentText': '" + commentText + "', 'userid': '" + userid + "'}", replySuccess, replyFailure)
            }

            function replySuccess(response) {
                $scope.reply = JSON.parse(response.d);
                $scope.$apply();
                //alert(response.d);
            }
            function replyFailure(response) {
                alert(response.d.responseText);
            }
        });

    </script>
    <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
    <style>
        .detailBox {
            width: 60%;
            border: 1px solid #bbb;
            margin: auto;
            margin-top: 20px;
        }

        .titleBox {
            background-color: #000;
            padding: 10px;
            font-size: 32px;
        }

            .titleBox label {
                color: #42DCA3;
                margin: 0;
                display: inline-block;
            }

        /*.commentBox {
            padding: 10px;
            border-top: 3px dotted #bbb;             
        }

        .commentBox .form-group:first-child, .actionBox .form-group:first-child {
                width: 80%;
                
            }

            .commentBox .form-group:nth-child(2), .actionBox .form-group:nth-child(2) {
                width: 18%;
            }*/

        .actionBox .form-group * {
            width: 100%;
        }

        .taskDescription {
            margin-top: 10px 0;
        }

        .commentList {
            padding: 0;
            list-style: none;
            overflow: auto;
        }

            .commentList li {
                margin: 0;
                margin-top: 10px;
            }

                .commentList li > div {
                    /*display: table-cell;*/
                }

        .scrollbarsupreme {
            max-height: 300px;
            padding-right: 5px;
            list-style: none;
            overflow: auto;
        }

        .commenterImage {
            width: 100%;
            padding-right: 80%;
            height: 10px;
        }

            .commenterImage p {
                width: 100%;
                /*border-radius: 50%;*/
            }

        .commentText p {
            bottom: 0;
            position: relative;
            margin: 0;
            color: #42DCA3;
        }

        .sub-text {
            color: #FFF;
            font-family: verdana;
            font-size: 11px;
            float: right;
        }

        .actionBox {
            /*border-top: 1px dotted #bbb;*/
            padding: 10px;
        }
    </style>
</asp:Content>




