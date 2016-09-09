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
            if (Session["Customer"] != null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('ddlPreferences').style.visibility = 'visible';", true);
                MasterPage masterpage = Page.Master;
                HyperLink hprCartItems = (HyperLink)masterpage.FindControl("hprCartItems");
                hprCartItems.Visible = true;

                User user = (User)Session["User"];
                RemoveMenuItem("LOGIN");
                ChangeMenuItem("WELCOME", String.Format("[Welcome {0}]", user.UserName));
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('ddlPreferences').style.visibility = 'hidden';", true);
                RemoveMenuItem("LOGOUT");
                RemoveMenuItem("WELCOME");

                MasterPage masterpage = Page.Master;
                HyperLink hprCartItems = (HyperLink)masterpage.FindControl("hprCartItems");
                hprCartItems.Visible = false;
            }
        }

        private void RemoveMenuItem(String text)
        {
            Menu mnu = (Menu)this.FindControl("Menu1");
            MenuItem itemRemove = new MenuItem();
            foreach (MenuItem menuItem in mnu.Items)
            {
                if (menuItem.Value == text)
                {
                    itemRemove = menuItem;
                }
            }
            mnu.Items.Remove(itemRemove);
        }

        private void ChangeMenuItem(String value, String text)
        {
            Menu mnu = (Menu)this.FindControl("Menu1");
            foreach (MenuItem menuItem in mnu.Items)
            {
                if (menuItem.Value == value)
                {
                    menuItem.Text = text;
                }
            }
        }
    }
}
