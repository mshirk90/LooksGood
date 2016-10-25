using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;
using DatabaseHelper;
using System.Web.UI.HtmlControls;

namespace LooksGood
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            MasterPage masterpage = Page.Master;
            HtmlAnchor anchor = (HtmlAnchor)masterpage.FindControl("ancLogin");

            if (Session["User"] == null)
            {
                PostList postList = new PostList();
                postList = postList.GetMostRecent();
                //rptImages.DataSource = postList.List;
                //rptImages.DataBind();
                //anchor.HRef = "Default.aspx?returnURL=Default.aspx";
            }
            if (Request.QueryString["userId"] != null)
            {
                Guid userId = new Guid(Request.QueryString["userId"]);             
                anchor.HRef = "Default.aspx?returnURL=Default.aspx?userId=" + userId;
            }
        }
    }

}