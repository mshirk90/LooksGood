using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using BusinessObjects;

namespace LooksGood.Account
{
    public partial class ChangePassword : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (Session["User"] == null)
            {
                Response.Redirect("Login.aspx");
            }
        }

        protected void btnChangePassword_Click(object sender, EventArgs e)
        {
            User user = (User)Session["User"];
            if (txtOldPassword.Text == user.Password)
            {
                if (txtNewPassword.Text == txtConfirmPassword.Text)
                {
                    user.Password = txtNewPassword.Text;
                    if (user.IsSavable() == true)
                    {
                        user.Save();
                        user.IsPasswordPending = false;
                        Response.Redirect("Default.aspx");
                        System.Windows.Forms.MessageBox.Show("Login Success");
                    }
                    
                    else
                    {
                        //Show broken Rules
                        foreach (BrokenRule br in user.BrokenRules.List)
                        {
                            AddCustomError(br.Rule);
                        }
                    }
                }
            }
        }
        private void AddCustomError(string message)
        {
            CustomValidator cv = new CustomValidator();
            cv.ErrorMessage = message;
            cv.Enabled = true;
            cv.ValidationGroup = "vgChangePassword";
            cv.IsValid = false;
            Page.Validators.Add(cv);
        }
    }
}