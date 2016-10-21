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



namespace LooksGood
{
    public partial class LooksGood : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null)
            {
                MasterPage masterpage = Page.Master;

                User user = (User)Session["User"];
                Menu menu = (Menu)this.FindControl("Menu1");
                Label label = (Label)masterpage.FindControl("idUser");

                hrefProfile.HRef = "/Account/Profile.aspx?userId=" + user.Id;

                lblUpload.Visible = true;
                lblProfile.Visible = true;
                lblChangePassword.Visible = true;
                lblLogout.Visible = true;
                lblLogin.Visible = false;
                lblRegister.Visible = false;
                lblForgotPassword.Visible = false;                
            }
            else
            {
                MasterPage masterpage = Page.Master;
            }
        }

       
    }
}



