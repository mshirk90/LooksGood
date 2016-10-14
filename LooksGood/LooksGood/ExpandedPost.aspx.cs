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
    public partial class ExpandedPost : System.Web.UI.Page
    {
        Post post = new Post();



        protected void Page_Load(object sender, EventArgs e)
        {
            
            if (Session["User"] == null)
            {
                cmtComment.Text = "Please login to comment";
                btnSubmit.Visible = false;
            }
            if (Request.QueryString["postId"] != null)
            {
                Guid postId = new Guid(Request.QueryString["postId"]);
                CommentsList comments = new CommentsList();
                comments = comments.GetByPostId(postId);
                
                Post post = new Post();
                post = post.GetById(postId);
                imgPost.ImageUrl = post.ImagePath;

                lblHeader.Text = string.Format("Posted by: {0}", post.UserName);
                lblTitle.Text = string.Format("Title: {0}", post.Title);
                lblDescription.Text = string.Format("Description: {0}", post.Description);

                MasterPage masterpage = Page.Master;
                HtmlAnchor anchor = (HtmlAnchor)masterpage.FindControl("ancLogin");
                anchor.HRef = "/Account/Login.aspx?returnURL=/ExpandedPost.aspx?postId=" + postId;
            }
        }
       
        public void comSubmit(object sender, EventArgs e)
        {
            Guid postId = new Guid(Request.QueryString["postId"]);
            Comments comment = new Comments();
            User user = (User)Session["User"];
            comment.Comment = cmtComment.Text;
            comment.UserId = user.Id;
            comment.PostId = postId;
            if (comment.IsSavable() == true)
            {
                comment.Save();
                //Server.Transfer("ExpandedPost.aspx");
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "clientscript", "<script>alert('Comment did not save');</script>", true);
            }
        }
    }
}