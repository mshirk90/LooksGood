using System;
using System.Web;
using System.Web.UI;
using Microsoft.AspNet.Identity;
using Microsoft.AspNet.Identity.Owin;
using Owin;
using LooksGood.Models;
using BusinessObjects;

namespace LooksGood.Account
{
    public partial class ForgotPassword : Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] != null)
            {
                lblEmail.Visible = false;
                Email.Visible = false;
                Email.Enabled = false;
                forgotEmail.Enabled = false;
                forgotEmail.Visible = false;               
                forEmail.Text = "Password WILL be revealed here";
                User user = (User)Session["User"];
            }
        }

        protected void Reveal(object sender, EventArgs e)
        {
            User user = (User)Session["User"];
            Email.Text = string.Format("We saved your password: {0}", user.Password);
        }


        protected void Forgot(object sender, EventArgs e)
        {
            //if (IsValid)
            //{
            //    // Validate the user's email address
            //    var manager = Context.GetOwinContext().GetUserManager<ApplicationUserManager>();
            //    ApplicationUser user = manager.FindByName(Email.Text);
            //    if (user == null || !manager.IsEmailConfirmed(user.Id))
            //    {
            //        FailureText.Text = "The user either does not exist or is not confirmed.";
            //        ErrorMessage.Visible = true;
            //        return;
            //    }
            //    // For more information on how to enable account confirmation and password reset please visit http://go.microsoft.com/fwlink/?LinkID=320771
            //    // Send email with the code and the redirect to reset password page
            //    //string code = manager.GeneratePasswordResetToken(user.Id);
            //    //string callbackUrl = IdentityHelper.GetResetPasswordRedirectUrl(code, Request);
            //    //manager.SendEmail(user.Id, "Reset Password", "Please reset your password by clicking <a href=\"" + callbackUrl + "\">here</a>.");
            //    loginForm.Visible = false;
            //    DisplayEmail.Visible = true;
        }
    }
}
