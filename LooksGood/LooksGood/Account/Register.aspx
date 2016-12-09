<%@ Page Title="Register" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true" CodeBehind="Register.aspx.cs" Inherits="LooksGood.Account.Register" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>

   
        <%--        <asp:PlaceHolder ID="registerForm" runat="server">
            <div>
                <h2>Register new account</h2>
                <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                    <p class="text-danger">
                        <asp:Literal runat="server" ID="FailureText" />
                    </p>
                </asp:PlaceHolder>
            </div>--%>

 <div class="contain">
        <div>
            <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="Email" Placeholder="Email" Width="70%" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                CssClass="text-danger" ErrorMessage="The email field is required." ID="EmailVal" />
        </div>

        <div>
            <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control-static input-lg" PlaceHolder="UserName" Width="70%" />
            <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUserName" CssClass="text-danger"
                ErrorMessage="The first name field is required." ID="rvFirstName" ValidationGroup="vgRegister">*</asp:RequiredFieldValidator>
        </div>
        <div>
            <asp:Label ID="lblStatus" runat="server" BorderStyle="None" ForeColor="White"></asp:Label>
        </div>
        <div>
            <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" Style="color: black;" />
        </div>
    </div>


    <script>
        $('#<%=txtEmail.ClientID %>').keyup(function () {
            var value = $('#<%=txtEmail.ClientID %>').val();
            EmailChecker(value);
        });
        $('#<%=txtEmail.ClientID %>').change(function () {
            var value = $('#<%=txtEmail.ClientID %>').val();
            EmailChecker(value);
        });

        function EmailChecker(value) {
            $.ajax({
                type: 'POST',
                url: '../LooksGoodWS.asmx/DoesEmailExist',
                data: "{'email': '" + value + "'}",
                contentType: 'application/json; charset=utf-8',
                dataType: 'json',
                success: OnSuccess,
                error: function (response) {
                    alert(response.responseText);
                }
            });
        }
        function OnSuccess(response) {
            var txtEmail = document.getElementById('<%=txtEmail.ClientID %>');
            var lblStatus = document.getElementById('<%=lblStatus.ClientID %>');
            var btnRegister = document.getElementById('<%=btnRegister.ClientID%>');
            switch (response.d) {
                case false:
                    txtEmail.style.color = "green";
                    lblStatus.innerText = "Email Availible";
                    btnRegister.disabled = false;
                    break;

                case true:
                    txtEmail.style.color = "red";
                    lblStatus.innerText = "Email already in use";
                    btnRegister.disabled = true;
                    break;

            }
        }

</script>

</asp:Content>
