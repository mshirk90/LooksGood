<%@ Page Title="Home Page" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Default.aspx.cs" Inherits="LooksGood._Default" %>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">



    <div class="container">

                <asp:Repeater ID="rptImages" runat="server">
                    <ItemTemplate>
                        <div class="titlecenter">
                            <a href='<%# "ExpandedPost.aspx?postId=" + DataBinder.Eval(Container.DataItem, "ID")  %>'>
                                <h3 class="titlecenter"><%# DataBinder.Eval(Container.DataItem, "Title")  %></h3>
                                      <div id="image" class="image">
                                        <asp:Image ID="imgImage" runat="server" ImageUrl='<%# DataBinder.Eval(Container.DataItem, "ImagePath")  %>' Width="560" Height="445" />
                                   </div>
                                <div>
                                    <div class="descript">
                                        <p><%# DataBinder.Eval(Container.DataItem, "Description")  %></p>
                                    </div>
                                    <div style="padding-left: 60%">
                                        <h6 class="uName">-<%# DataBinder.Eval(Container.DataItem,"UserName")  %></h6>
                                    </div>
                                </div>
                            </a>
                        </div>
                        <div class="customHr">
                            <hr class="customHr" />
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>

</asp:Content>
