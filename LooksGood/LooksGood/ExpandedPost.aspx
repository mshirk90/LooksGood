<%@ Page Title="ExpandedPost" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExpandedPost.aspx.cs" Inherits="LooksGood.ExpandedPost" %>




<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #vote {
            width: 42px;
        }
    </style>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">


    <div style="padding-left: 25px">
        <asp:Label ID="lblHeader" runat="server" Font-Bold="true" Font-Size="XX-Large">
        </asp:Label>
        <div>

            <asp:Label ID="lblTitle" runat="server" Font-Italic="false" Font-Size="X-Large">
            </asp:Label>
            <div>

                <asp:Label ID="lblDescription" runat="server" Font-Size="Larger"></asp:Label>
                <hr style="display: inline-block; width: 90%" />
            </div>
        </div>
    </div>
    <div style="padding-left: 25px">
        <asp:Image ID="imgPost" runat="server" Width="760px" Height="600px"></asp:Image>
       
    <%--    ************************************************************************************************************************************************************************--%>







        <div class="well">
            <div class="row">
                <div class="col-sm-3 col-md-3 col-lg-3">
                    <div class="input-group">
                        <button type="button" id="decreaseButton" class="btn btn-danger" style="background-color: #FF0000; width: 24px; font-weight: bold;">-</button>&nbsp;<input type="text" readonly="true" class="form-control" id="vote" placeholder="Vote" postid='<%=Request.QueryString["postId"] %>' />

                        <button type="button" id="increaseButton" class="btn btn-success" style="background-color: #00CC00; font-weight: bold;">+</button>

                    </div>
                </div>
            </div>
        </div>




        <script>
            //$scope.posts = [];

            $(document).ready(function () {
                var id = vote.getAttribute("postid");
                GetVotes(id);
            });

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
        </script>

        <%--    ************************************************************************************************************************************************************************--%>

        <hr style="display: inline-block; width: 90%" />
    </div>
    <div>
        <div></div>
    </div>
    <div id="comment_form" style="padding-left: 25px" class="div-margin">
        <div>
            <asp:TextBox Rows="10" name="comment" ID="cmtComment" placeholder="Comment" runat="server"></asp:TextBox>
        </div>
        <div>
            <asp:Button type="submit" name="submit" Text="Submit Comment" OnClick="comSubmit" runat="server" ID="btnSubmit" />
        </div>
    </div>

    <asp:Repeater ID="rptComments" runat="server">
        <HeaderTemplate>
        </HeaderTemplate>
        <ItemTemplate>
            <div class="container left" style="border: 0px solid black">
                <div class="dialogbox">
                    <div class="body">
                        <span class="tip tip-up"></span>
                        <div class="message">
                            <span><%# DataBinder.Eval(Container.DataItem, "Comment")  %></span>
                            <hr />
                            <a href='<%# "/Account/Profile.aspx?userId=" + DataBinder.Eval(Container.DataItem, "userId")  %>'>
                                <span><%# "Commented by: " + DataBinder.Eval(Container.DataItem, "UserName")  %></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </ItemTemplate>
        <FooterTemplate>
        </FooterTemplate>
    </asp:Repeater>

</asp:Content>

