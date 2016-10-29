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
    public partial class ExpandedPost : Page
    {
        Post post = new Post();
        
        protected void Page_Load(object sender, EventArgs e)
        {
            getUserId();
            if (Session["User"] != null)
            {
                //cmtComment.Text = "Please login to comment";
                //btnSubmit.Visible = false;

                User user = (User)Session["User"];
                ClientScript.RegisterStartupScript(GetType(), "Javascript", "javascript:UserSignedIn(); ", true);                
            }
            if (Request.QueryString["postId"] != null)
            {
                Guid postId = new Guid(Request.QueryString["postId"]);
                CommentsList comments = new CommentsList();
                comments = comments.GetByPostId(postId);

                Post post = new Post();
                post = post.GetById(postId);
                //imgPost.ImageUrl = post.ImagePath;

                //lblHeader.Text = string.Format("Posted by: {0}", post.UserName);
                //lblTitle.Text = string.Format("Title: {0}", post.Title);
                //lblDescription.Text = string.Format("Description: {0}", post.Description);

                MasterPage masterpage = Page.Master;
                HtmlAnchor anchor = (HtmlAnchor)masterpage.FindControl("ancLogin");
                anchor.HRef = "/Account/Login.aspx?returnURL=/ExpandedPost.aspx?postId=" + postId;
       
            }
        }
        public string getUserId()
        {
            if (HttpContext.Current != null && HttpContext.Current.Session != null && HttpContext.Current.Session["User"] != null)
            {
                User user = (User)HttpContext.Current.Session["User"];
                return user.Id.ToString();
            }
            else
            {
                return string.Empty;
            }
        }
    }   
}