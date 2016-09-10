﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;
using System.Web.UI.HtmlControls;

namespace LooksGood.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            // READ THE COOKIE
            if (Request.Cookies["LooksGoodCookies"] != null && Convert.ToBoolean(Request.Cookies["LooksGoodCookies"]["RememberMe"]) == true)
            {
                txtEmail.Text = Request.Cookies["LooksGoodCookies"]["UserName"];
                txtPassword.Text = Request.Cookies["LooksGoodCookies"]["Password"];
                UserLogin();
            }
        }

        private void UserLogin()
        {
            User user = new User();
            user = user.Login(txtEmail.Text, txtPassword.Text);

            if (user == null)
            {
                lblStatus.Text = "Invalid Username or Password";
            }
            else if (user.Version == 0 && user.IsPasswordPending == true)
            {
                Session.Add("User", user);
                Response.Redirect("ChangePassword.aspx");
            }
            else
            {
                if (this.RememberMe.Checked == true)
                {
                    Response.Cookies["LooksGoodCookies"]["UserName"] = txtEmail.Text;
                    Response.Cookies["LooksGoodCookies"]["Password"] = txtPassword.Text;
                    Response.Cookies["LooksGoodCookies"]["RememberMe"] = "true";

                    Response.Cookies["LooksGoodCookies"]["LastVisited"] = DateTime.Now.ToLongDateString();
                    Response.Cookies["LooksGoodCookies"].Expires = DateTime.MaxValue;
                }
                ((HtmlGenericControl)this.Master.FindControl("ddlPreferences")).Visible = false;
                Session.Add("User", user);
                Response.Redirect("~/Default.aspx");
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            UserLogin();
        }
    }
}