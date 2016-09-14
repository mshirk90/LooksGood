using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;

namespace LooksGood
{
    public partial class ExpandedPost : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Request.QueryString["Id"] != null)
            {
                Guid id = new Guid(Request.QueryString["Id"]);
                CommentsList comments = new CommentsList();
            }
        }
    }
}