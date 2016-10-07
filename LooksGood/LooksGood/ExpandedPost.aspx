<%@ Page Title="ExpandedPost" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ExpandedPost.aspx.cs" Inherits="LooksGood.ExpandedPost" %>




<asp:Content ID="header" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        #vote {
            width: 50px;
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

                		<div class="well">    
    <div class="row">
        <div class="col-sm-3 col-md-3 col-lg-3">
            <div class="input-group"> 
                <button type="button" id="decreaseButton" class="btn btn-danger" style="background-color: #FF0000; width: 32px; font-weight: bold;">-</button>&nbsp;
                <input type="text" class="form-control" id="vote" placeholder="Vote" /> 
               <button type="button" id="increaseButton" class="btn btn-success" onclick="btnincreaseButton_onClick" style="background-color: #00CC00; font-weight: bold;">+</button>
               
            </div>
        </div>
    </div>
</div>

        <script>
            $("#vote").val('0');
            // Create a click handler for your increment button
            $("#increaseButton").click(function () {
                var newValue = 1 + parseInt($("#vote").val());
                $("#vote").val(newValue);
            });
            // .. and your decrement button
            $("#decreaseButton").click(function () {
                var newValue = parseInt($("#vote").val()) - 1;
                $("#vote").val(newValue);
            });
        </script>



        <hr style="display: inline-block; width: 90%" />
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
                            <a class="a2" href='<%# "../Profile.aspx?userId=" + DataBinder.Eval(Container.DataItem, "UserId")  %>'>
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

