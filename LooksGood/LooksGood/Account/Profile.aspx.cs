using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;


namespace LooksGood.Account
{
    public partial class Profile : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("Login.aspx");
            }


            User user = (User)Session["User"];
            user = user.GetById(user.Id);
            imgProfile.ImageUrl = ("~/") + user.ProfilePic;

            lblUserName.Text = string.Format(user.UserName);

        }
    }
}
