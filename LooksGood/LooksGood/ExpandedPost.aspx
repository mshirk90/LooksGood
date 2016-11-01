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
    <div class="contain" ng-app="MyApp">
        <div ng-controller="MyController">
            <div class="contain">
                <div>
                    <div class="item" ng-model="post">
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
                     <a href="#contact" class="btn btn-circle page-scroll">
                <i class="fa fa-angle-double-down animated"></i>
            </a>
                </div>
            </div>
        </div>
        <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>

        <div class="space">
            <br />
        </div>
        <div class="space">
            <br />
        </div>
        <%--<div class="space">
            <br />
        </div>--%>
        <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>


        <section id="contact" class="">
        <div id="comment_form" class="contain">
            <div>
                <textarea class="textarea" style="color: #00b7fc" cols="50" rows="3" name="comment" id="cmtComment" placeholder="Comment"></textarea>
            </div>
            <div>
                <input type="submit" name="submit" value="" id="btnSubmit" style="background-color: #000; color: #00b7fc; border: 1px solid #00b7fc" />
            </div>
        </div>

        <div class="detailBox">
            <div class="titleBox">
                <label>Comments</label>
                <hr />
            </div>
            <div ng-app="MyApp" ng-controller="commentController">
                <div class="actionBox">
                    <div class="scrollbarsupreme">
                        <ul ng-repeat="x in comments">
                            <li>
                                <div>
                                    <div class="commenterImage">
                                        <a href="/Account/Profile.aspx?userId={{x.UserId}}">
                                            <p style="color: white">{{x.UserName}} Says</p>
                                        </a>
                                    </div>
                                    <br />
                                    <div class="commentText">
                                        <p class="commentText">{{x.Comment}}</p>
                                        <span class="date sub-text">on {{x.LastUpdated | date : "short"}}</span>
                                    </div>
                                    <hr style="width: 95%" />
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
</section>
    </div>


    <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
    <script>
        $("#cmtComment").val('Please Login to comment');
        $("#btnSubmit").val('Please login to comment');
        $("#cmtComment").prop("disabled", true);
        $("#btnSubmit").prop("disabled", true);
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
        }

        var app = angular.module("MyApp", []);
        app.controller("MyController", function ($scope) {
            $scope.post = {}

            angular.element(document).ready(function () {
                var postId = vote.getAttribute("postid");
                //var userid = '<%=getUserId()%>';                          
                
                WebServiceRequest("GetPostById", "{'postId': '" + postId + "'}", postLoadSuccess, postLoadFailure)
            });

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
                //var userid = '<%=getUserId()%>';

                WebServiceRequest("GetCommentsByPostId", "{'postId': '" + postId + "'}", commentSuccess, commentFailure)
            });

            function commentSuccess(response) {
                $scope.comments = JSON.parse(response.d);
                $scope.$apply();
                //alert(response.d);

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
    </script>
    <%-- ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- --%>
    <style>
        .detailBox {
            width: 60%;
            border: 1px solid #bbb;
            margin: auto;
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




