using System;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using LooksGood.Models;
using BusinessObjects;
using ConfigurationHelper;
using System.Data.SqlClient;
using System.Data;
using DatabaseHelper;


namespace LooksGood.Account
{
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null)
            {
                EmailVal.Enabled = false;
                lblEmail.Visible = false;
                Email.Enabled = false;
                Email.Visible = false;
                forgotEmail.Enabled = false;
                forgotEmail.Visible = false;
                User user = (User)Session["User"];
            }
            else
            {
                rvEmail.Enabled = false;
                rvEmail.Visible = false;
                revealEmail.Enabled = false;
                revealEmail.Visible = false;                             
            }
        }

        protected void Reveal(object sender, EventArgs e)
        {
            User user = (User)Session["User"];
            rvEmail.Text = string.Format("We saved your password: {0}", user.Password);
        }


        protected void Forgot(object sender, EventArgs e)
        {
            if (IsValid)
            {                                        
                // Validate the user's email address
                var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
                ApplicationUser user = manager.FindByName(Email.Text);
                if (user == null || !manager.IsEmailConfirmed(user.Id))
                {
                    FailureText.Text = "The user either does not exist or is not confirmed.";
                    ErrorMessage.Visible = true;
                    return;
                }
                // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
                // Send email with the code and the redirect to reset password page
                //string code = manager.GeneratePasswordResetToken(user.Id);
                //string callbackUrl = IdentityHelper.GetResetPasswordRedirectUrl(code, Request);
                //manager.SendEmail(user.Id, "Reset Password", "Please reset your password by clicking <a href=\"" + callbackUrl + "\">here</a>.");
                loginForm.Visible = false;
                DisplayEmail.Visible = true;
            }
        }
        public void EmailCheck(object sender, EventArgs e)
        {
            string conString = Configuration.GetConnectionString("LooksGoodDatabase");
            SqlConnection con = new SqlConnection(conString);
            SqlCommand cmd = new SqlCommand("Select * from pmartone.tblUser where Email=@Email",con);
            cmd.Parameters.AddWithValue("@Email", this.Email.Text);
            con.Open();
            SqlDataReader dr = cmd.ExecuteReader();
            if (dr.HasRows == true)
            {
                
            }
        }
    }
}
