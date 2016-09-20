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
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('ddlPreferences').style.visibility = 'visible';", true);
                MasterPage masterpage = Page.Master;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('nav').style.visibility = 'visible';", true);


                User user = (User)Session["User"];
                Menu menu = (Menu)this.FindControl("Menu1");
                Label label = (Label)masterpage.FindControl("idUser");
                label.Text = user.UserName;


                lblLogin.Visible = false;
                lblRegister.Visible = false;
                lblForgotPassword.Visible = false;
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('ddlPreferences').style.visibility = 'hidden';", true);
                MasterPage masterpage = Page.Master;
            }
        }
    }
}



