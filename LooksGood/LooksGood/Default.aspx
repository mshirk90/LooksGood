<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LooksGood._Default" %>





<asp:Content ID="MainContent" ContentPlaceHolderID="MainContent" runat="server">

    <div id="myCarousel" class="carousel slide" data-ride="carousel">
        <div class="carousel-inner" role="listbox">
            <asp:Repeater ID="rptImages" runat="server">
                <ItemTemplate>
                    <div class="item <%# (Container.ItemIndex == 0 ? "active" : "") %>">

  <a><h3><%# DataBinder.Eval(Container.DataItem, "Title")  %></h3></a>
                        <a  href='<%# 
                        Session["User"] != null ? "ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID") + "&userId=" + ((BusinessObjects.User)Session["User"]).Id : "ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID") %>'>
                            <asp:Image ID="imgImage" CssClass="center-block" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath")  %>' Width="75%" Height="70%" />
                        </a>
                      <a><pstyle="padding-top:-12px; padding-bottom:-12px">Description: <%# DataBinder.Eval(Container.DataItem, "Description")  %></pstyle="padding-top:-12px;>
                          <h6>-<%# DataBinder.Eval(Container.DataItem,"UserName")  %></h6></a>
                    </div>
                </ItemTemplate>

                <AlternatingItemTemplate>
                    <div class="item">
                         <a><h3><%# DataBinder.Eval(Container.DataItem, "Title")  %></h3></a>
                        <a href='<%# 
                        Session["User"] != null ? "ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID") + "&userId=" + ((BusinessObjects.User)Session["User"]).Id : "ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID") %>'>
                            <asp:Image ID="imgImage" CssClass="center-block" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath")  %>' Width="75%" Height="70%" />
                        </a>
                      <a><pstyle="padding-top:-12px; padding-bottom:-12px">Description: <%# DataBinder.Eval(Container.DataItem, "Description")  %></pstyle="padding-top:-12px;>
                          <h6>-<%# DataBinder.Eval(Container.DataItem,"UserName")  %></h6></a>
                    </div>
                </AlternatingItemTemplate>


            </asp:Repeater>

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




    <style>
        .h6 {
            margin-bottom: -20px;
            padding-bottom: -20px;
        }
        .textfix{
            padding-top:-12px; 
            padding-bottom:-12px
        }
    </style>
</asp:Content>






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

