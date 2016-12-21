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



    <div class="text-center" style="padding-left: 380px;">
            <div>
                <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" TextMode="Email" Placeholder="Email" Width="70%" Style="color: black" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtEmail"
                    CssClass="text-danger" ErrorMessage="The email field is required." ID="EmailVal" />
            </div>

            <div>
                <asp:TextBox runat="server" ID="txtUserName" CssClass="form-control" PlaceHolder="UserName" Width="70%" Style="color: black" />
                <asp:RequiredFieldValidator runat="server" ControlToValidate="txtUserName"
                    CssClass="text-danger" ErrorMessage="The first name field is required." ID="rvFirstName" ValidationGroup="vgRegister"></asp:RequiredFieldValidator>
            </div>
            <div>
                <asp:Label ID="lblStatus" runat="server" BorderStyle="None" ForeColor="White"></asp:Label>
            </div>
        </div>


    <asp:Button ID="btnRegister" runat="server" Text="Register" OnClick="btnRegister_Click" Style="color: black;" />


    <div>
    <a href="#contact" class="btn btn-circle page-scroll">
        <i class="fa fa-angle-double-down animated"></i>
    </a>
</div>



    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>
    <div class="space">
        <br />
    </div>







    <section id="contact" class="download-section text-center">
        <div class="row">
            <div class="col-lg-8 col-lg-offset-2">
                <a href="#page-top" class="btn btn-circle page-scroll">
                    <i class="fa fa-angle-double-up animated"></i>
                </a>
            </div>
        </div>
        <br />
        <%--</section>--%>
        <div class="text-center">
            <div>
                <div>
                    <h2>Contact Us</h2>
                    <p>
                        <a href="mailto:feedback@startbootstrap.com">feedback@startbootstrap.com</a>
                    </p>
                    <ul class="list-inline banner-social-buttons">
                        <li>
                            <a href="https://twitter.com/SBootstrap" class="btn btn-default btn-lg"><i class="fa fa-twitter fa-fw"></i><span class="network-name">Twitter</span></a>
                        </li>
                        <li>
                            <a href="https://github.com/IronSummitMedia/startbootstrap" class="btn btn-default btn-lg"><i class="fa fa-github fa-fw"></i><span class="network-name">Github</span></a>
                        </li>
                        <li>
                            <a href="https://plus.google.com/+Startbootstrap/posts" class="btn btn-default btn-lg"><i class="fa fa-google-plus fa-fw"></i><span class="network-name">Google+</span></a>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </section>


    <script>
        $(document).ready(function () {
            $('html, body').animate({
                scrollTop: $('.space').offset().top
            }, 'slow');
        });


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
