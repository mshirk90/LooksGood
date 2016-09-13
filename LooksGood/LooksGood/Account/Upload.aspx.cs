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
    public partial class Upload : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnPost_Click(object sender, EventArgs e)
        {

            User user = (User)Session["User"];            
            Post post = new Post();
           
            if (txtTitle.Text != null && txtDesription.Text != null && this.fuUpload.HasFile)
            {
                string path = Server.MapPath("../UploadedImages");
                path = Path.Combine(path, this.fuUpload.FileName);
                string relativePath = Path.Combine("UploadedImages", this.fuUpload.FileName);
                 this.fuUpload.SaveAs(path);

                    if (Session["User"] != null)
                    {
                        post.ImagePath = relativePath;
                        post.Title = txtTitle.Text.ToString();
                        post.Description = txtDesription.Text.ToString();
                        post.UserId = user.Id;
                        post.Save();
                        Response.Redirect("~/Default.aspx");
                    }
                


                //else
                //{
                //    //Show broken Rules
                //    foreach (BrokenRule br in user.BrokenRules.List)
                //    {
                //        AddCustomError(br.Rule);
                //    }
                //}
            }
        }
    }


}
   