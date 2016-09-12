<%@ Page Language="C#" AutoEventWireup="true" MasterPageFile="~/Site.master" CodeBehind="Upload.aspx.cs" Inherits="LooksGood.Account.Upload" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <style type="text/css">
        .auto-style1 {
            width: 10px;
        }
    </style>

    <div>
         </div>
        <table style="width: 605px">
            <tr>
                <td class="auto-style1">
                    <asp:Label ID="lblTitle" runat="server" Font-Names="Cooper Std Black" Text="Title:  "></asp:Label>
                </td>
                <td>
                    <asp:TextBox ID="TextBox1" runat="server" Width="219px"></asp:TextBox>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:Label ID="lblUpload" runat="server" Text="Upload:  " Font-Names="Cooper Std Black"></asp:Label>
                </td>
                <td>
                    <%--<asp:FileUpload runat="server" ? />--%>
                    <td>
                        <script>
                            function ShowImage(filepath) {
                                var reader = new FileReader(); // File API object
                                reader.onload = function (event) {
                                    document.getElementById('myimage').src = event.target.result;
                                }
                                reader.readAsDataURL(filepath);

                            }
                            </script>
                </td>
            </tr>
            <tr>
                <td class="auto-style1">
                    <asp:Label ID="lblComments" runat="server" Text="Comments:  " Font-Names="Cooper Std Black"></asp:Label>
                </td>
                <td>
                    <textarea id="txtComments" cols="35" name="S1" rows="5"></textarea>
                </td>
            </tr>
        </table>
   

</asp:Content>

