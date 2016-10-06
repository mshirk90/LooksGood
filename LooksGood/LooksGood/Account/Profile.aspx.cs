using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;
using DatabaseHelper;
using System.IO;


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






            //if (Request.QueryString["userId"] != null)
            //{
            //    User user = new User["userId"];
            //    user = user.GetById(user.Id);
            //    imgProfile.ImageUrl = ("~/") + user.ProfilePic;
            //    lblUserName.Text = string.Format(user.UserName);

            //    PostList post = new PostList();
            //    post = post.GetByUserId(user.Id);
            //    CommentsList comments = new CommentsList();
            //    comments = comments.GetByUserId(user.Id);
            //    rptPost.DataSource = post.List;
            //    rptPost.DataBind();
            //    rptComments.DataSource = comments.List;
            //    rptComments.DataBind();
            //}
            else
            {
                User user = (User)Session["User"];
                user = user.GetById(user.Id);
                imgProfile.ImageUrl = ("~/") + user.ProfilePic;
                lblUserName.Text = string.Format(user.UserName);

                PostList post = new PostList();
                post = post.GetByUserId(user.Id);
                CommentsList comments = new CommentsList();
                comments = comments.GetByUserId(user.Id);
                rptPost.DataSource = post.List;
                rptPost.DataBind();
                rptComments.DataSource = comments.List;
                rptComments.DataBind();

            }


            //*******************************************************************************************************************88

        }




        protected void btnChangePicture_Click(object sender, EventArgs e)
        {
            User user = (User)Session["User"];

            if ( this.fuChangeProfileImage.HasFile)
            {
                string path = Server.MapPath("../ProfilePics");
                path = Path.Combine(path, this.fuChangeProfileImage.FileName);
                string relativePath = Path.Combine("ProfilePics", this.fuChangeProfileImage.FileName);
                this.fuChangeProfileImage.SaveAs(path);

                if (Session["User"] != null)
                {
                    user.ProfilePic = relativePath;
                    user.Id = user.Id;
                    user.Save();
                    Response.Redirect("~/Account/Profile.aspx");
                }

            }
        }
    }
}

