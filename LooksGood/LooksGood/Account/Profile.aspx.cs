using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;
using DatabaseHelper;
using System.IO;
using System.Web.UI.HtmlControls;


namespace LooksGood.Account
{
    public partial class Profile : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            fuChangeProfileImage.Enabled = false;
            btnChangePicture.Enabled = false;
            fuChangeProfileImage.Visible = false;
            btnChangePicture.Visible = false;

            if (Request.QueryString["userId"] != null)
            {
                MasterPage masterpage = Page.Master;
                HtmlAnchor anchor = (HtmlAnchor)masterpage.FindControl("ancLogin");               
                
                Guid userId = new Guid(Request.QueryString["userId"]);
                User user = new User();
                user = user.GetById(userId);
                lblUserName.Text = user.UserName;
                imgProfile.ImageUrl = "~/" + user.ProfilePic;

                PostList posts = new PostList();
                posts = posts.GetByUserId(userId);
                CommentsList comments = new CommentsList();
                comments = comments.GetByUserId(userId);
                anchor.HRef = "/Account/Login.aspx?returnURL=/Account/Profile.aspx?userId=" + userId;


                if (Session["User"] != null)
                {
                    if (((User)Session["User"]).Id == userId)
                    {

                        btnChangePicture.Enabled = true;
                        fuChangeProfileImage.Enabled = true;
                        fuChangeProfileImage.Visible = true;
                        btnChangePicture.Visible = true;
                    }

                }
            }

            else
            {
                Response.Redirect("/Default.aspx");
            }

        }

        protected void btnChangePicture_Click(object sender, EventArgs e)
        {
            User user = (User)Session["User"];

            if (this.fuChangeProfileImage.HasFile)
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

