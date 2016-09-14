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
            if (Request.QueryString["postId"] != null)
            {
                Guid postId = new Guid(Request.QueryString["postId"]);
                CommentsList comments = new CommentsList();
                comments = comments.GetByPostId(postId);
                rptComments.DataSource = comments.List;
                rptComments.DataBind();

                Post post = new Post();
                post = post.GetById(postId);
                imgPost.ImageUrl = post.ImagePath;
            }
        }
    }
}