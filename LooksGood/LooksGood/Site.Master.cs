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

    public partial class Site : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null)
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('ddlPreferences').style.visibility = 'visible';", true);
                MasterPage masterpage = Page.Master;
                // HyperLink hprCartItems = (HyperLink)masterpage.FindControl("hprCartItems");
                //hprCartItems.Visible = true;
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('bsTop').style.visibility = 'visible';", true);
                

                User user = (User)Session["User"];
                Menu menu = (Menu)this.FindControl("Menu1");
                //Button btn = (Button)masterpage.FindControl("btnUser");
                //btn.Text = user.UserName;
                

                
                //RemoveMenuItem("LOGIN");
                //ChangeMenuItem("WELCOME", String.Format("[Welcome {0}]", user.UserName));

            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "document.getElementById('ddlPreferences').style.visibility = 'hidden';", true);
                //RemoveMenuItem("LOGOUT");
                //RemoveMenuItem("WELCOME");

                MasterPage masterpage = Page.Master;
                // HyperLink hprCartItems = (HyperLink)masterpage.FindControl("hprCartItems");
                // hprCartItems.Visible = false;
            }
        }

        //private void RemoveMenuItem(String text)
        //{
        //    Menu mnu = (Menu)this.FindControl("Menu1");
        //    MenuItem itemRemove = new MenuItem();
        //    foreach (MenuItem menuItem in mnu.Items)
        //    {
        //        if (menuItem.Value == text)
        //        {
        //            itemRemove = menuItem;
        //        }
        //    }
        //    mnu.Items.Remove(itemRemove);
        //}

        //private void ChangeMenuItem(String value, String text)
        //{
        //    Menu mnu = (Menu)this.FindControl("Menu1");
        //    foreach (MenuItem menuItem in mnu.Items)
        //    {
        //        if (menuItem.Value == value)
        //        {
        //            menuItem.Text = text;
        //        }
        //    }
        //}
    }



