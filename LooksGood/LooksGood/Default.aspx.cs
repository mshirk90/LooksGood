using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;

namespace LooksGood
{
    public partial class _Default : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            PostList postList = new PostList();
            postList = postList.GetMostRecent();
            rptImages.DataSource = postList.List;
            rptImages.DataBind();          
        }     

        
    }

}