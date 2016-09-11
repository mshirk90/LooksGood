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
using EmailHelper;



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
                //^^ Validate the user's email address
                DataTable dt = new DataTable();
                string conString = Configuration.GetConnectionString("LooksGoodDatabase");
                SqlConnection con = new SqlConnection(conString);
                SqlCommand cmd = new SqlCommand("Select * from pmartone.tblUser where Email=@Email", con);
                cmd.Parameters.AddWithValue("@Email", this.Email.Text);
                con.Open();
                SqlDataReader dr = cmd.ExecuteReader();
                //^^ builds database stuff needed to retrieve the information and builds the query 
                if (dr.HasRows == false)
                {
                    FailureText.Text = "The email either does not exist or is not confirmed.";
                    ErrorMessage.Visible = true;
                    Email.Text = "Password not found";
                    //^^ if e-mail is not found error message handling
                }
                if (dr.HasRows == true)
                {
                    while (dr.Read())
                    {
                        string eMail = dr[5].ToString();
                        string pWord = dr[6].ToString();
                        EmailHelper.Email.SendEmail(eMail, "New Password", "Your password = " + pWord);
                        FailureText.Text = "Email found sending password to registered e-mail";
                        //^^ reads the data base rows equivalent to user e-mail and password from the user table and e-mails to the e-mail
                    }
                }               
                con.Close();
            }
        }
    }
}


