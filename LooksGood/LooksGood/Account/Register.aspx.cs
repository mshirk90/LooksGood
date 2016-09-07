using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;
using EmailHelper;

namespace LooksGood.Account
{
    public partial class Register : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {

        }

        protected void btnRegister_Click(object sender, EventArgs e)
        {
            User user = null;
            if (Session["User"] == null)
            {
                user = new User();
            }
            else
            {
                user = (User)Session["User"];
            }

            try
            {
                if (user.EmailSent == false)
                {
                    user.Register(txtUserName.Text, txtEmail.Text);
                    Session.Add("User", user);
                }
            }
            catch (Exception ex)
            {
                // show the broken rules
                for (Int32 i = 0; i < user.BrokenRules.Count; i++)
                {
                    CustomValidator cvRules = new CustomValidator();
                    cvRules.ErrorMessage = user.BrokenRules.List[i].Rule;
                    cvRules.Enabled = true;
                    cvRules.IsValid = false;
                    cvRules.ValidationGroup = "vgRegister";
                    Page.Validators.Add(cvRules);
                    // customer.BrokenRules.List
                }
            }
            try
            {
                if (Page.IsValid == true)
                {
                    if (user.EmailSent == false)
                    {
                       
                        EmailHelper.Email.SendEmail(user.Email, "Registration Password", "Your password is: " + user.Password);
                        lblStatus.Text = "Please check your email for creditials.";
                        user.EmailSent = true;
                        user.Save();
                    }
                    else
                    {
                        lblStatus.Text = "Email already sent.";
                    }
                }
            }
            catch (Exception exEmail)
            {
                lblStatus.Text = exEmail.Message;
            }
        }
    }
}