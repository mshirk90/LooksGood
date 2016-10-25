using System;
using System.Data;
using System.Configuration;
using System.Collections;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;
using BusinessObjects;

namespace LooksGood.Account
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            MasterPage masterpage = Page.Master;
            Label label = (Label)masterpage.FindControl("lblForgotPassword");
            label.Visible = true;


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
                Session.Add("User", user);
                if (Request.QueryString["returnURL"] != null && Request.QueryString["returnURL"].Contains("ExpandedPost"))
                {
                    string URL = Request.QueryString["returnURL"] + "&userId=" + user.Id;
                    Response.Redirect(URL);
                }
                if (Request.QueryString["returnURL"] != null && Request.QueryString["returnURL"].Contains("Profile"))
                {
                    string URL = Request.QueryString["returnURL"];
                    Response.Redirect(URL);
                }
                if (Request.QueryString["returnURL"] != null && Request.QueryString["returnURL"].Contains("Default"))
                {
                    string URL = Request.QueryString["returnURL"];
                    Response.Redirect(URL);
                }
                else
                {
                    Response.Redirect("../Default.aspx?userId=" + user.Id);
                }
            }
        }
        protected void btnLogin_Click(object sender, EventArgs e)
        {
            UserLogin();
        }
    }
}