using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Threading.Tasks;
using System.Data;
using DatabaseHelper;
using System.Web.Security;

namespace BusinessObjects
{
    public class User : HeaderData
    {
        #region Private Members
        private String _UserName = String.Empty;
        private String _Email = String.Empty;
        private String _Password = String.Empty;
        private Boolean _EmailSent = false;
        private bool _IsPasswordPending = false;
        private BrokenRuleList _BrokenRules = new BrokenRuleList();
        #endregion

        #region Public Properties
        public String UserName
        {
            get { return _UserName; }
            set
            {
                if (_UserName != value)
                {
                    _UserName = value;
                    base.IsDirty = true;
                    Boolean Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }
        
        public String Email
        {
            get { return _Email; }
            set
            {
                if (_Email != value)
                {
                    _Email = value;
                    base.IsDirty = true;
                    Boolean Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }
        public String Password
        {
            get { return _Password; }
            set
            {
                if (_Password != value)
                {
                    _Password = value;
                    base.IsDirty = true;
                    Boolean Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }
        public Boolean EmailSent
        {
            get { return _EmailSent; }
            set { _EmailSent = value; }
        }
        public bool IsPasswordPending
        {
            get
            {
                return _IsPasswordPending;
            }
            set
            {
                if (_IsPasswordPending != value)
                {
                    _IsPasswordPending = value;
                    base.IsDirty = true;
                    Boolean Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }
        public BrokenRuleList BrokenRules
        {
            get { return _BrokenRules; }
        }
        #endregion

        #region Private Methods
        private Boolean Insert(Database database)
        {
            Boolean result = true;

            try
            {
                database.Command.Parameters.Clear();
                database.Command.CommandType = CommandType.StoredProcedure;
                database.Command.CommandText = "tblUserINSERT";
                database.Command.Parameters.Add("@UserName", SqlDbType.VarChar).Value = _UserName;
                database.Command.Parameters.Add("@Email", SqlDbType.VarChar).Value = _Email;
                database.Command.Parameters.Add("@Password", SqlDbType.VarChar).Value = _Password;

                // Provides the empty buckets
                base.Initialize(database, Guid.Empty);
                database.ExecuteNonQuery();

                // Unloads the full buckets into the object
                base.Initialize(database.Command);
            }
            catch (Exception e)
            {
                result = false;
                throw;
            }

            return result;
        }
        private Boolean Update(Database database)
        {
            Boolean result = true;

            try
            {
                database.Command.Parameters.Clear();
                database.Command.CommandType = CommandType.StoredProcedure;
                database.Command.CommandText = "tblUserUPDATE";
                database.Command.Parameters.Add("@UserName", SqlDbType.VarChar).Value = _UserName;
                database.Command.Parameters.Add("@Email", SqlDbType.VarChar).Value = _Email;
                database.Command.Parameters.Add("@Password", SqlDbType.VarChar).Value = _Password;
                database.Command.Parameters.Add("@IsPasswordPending", SqlDbType.Bit).Value = _IsPasswordPending;


                // Provides the empty buckets
                base.Initialize(database, base.Id);
                database.ExecuteNonQuery();

                // Unloads the full buckets into the object
                base.Initialize(database.Command);
            }
            catch (Exception e)
            {
                result = false;
                throw;
            }

            return result;
        }
        private Boolean Delete(Database database)
        {
            Boolean result = true;

            try
            {
                database.Command.Parameters.Clear();
                database.Command.CommandType = CommandType.StoredProcedure;
                database.Command.CommandText = "tblUserDELETE";

                // Provides the empty buckets
                base.Initialize(database, base.Id);
                database.ExecuteNonQuery();

                // Unloads the full buckets into the object
                base.Initialize(database.Command);
            }
            catch (Exception e)
            {
                result = false;
                throw;
            }

            return result;
        }
        private Boolean IsValid()
        {

            _BrokenRules.List.Clear();
            Boolean result = true;

            if (_UserName == null || _UserName.Trim() == String.Empty)
            {
                result = false;
                BrokenRule rule = new BrokenRule("User Name cannot be empty.");
                _BrokenRules.List.Add(rule);
            }
            if (_Email == null || _Email.Trim() == String.Empty)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Email cannot be empty");
                _BrokenRules.List.Add(rule);
            }
            if (_Password == null || _Password.Trim() == String.Empty)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Password cannot be empty.");
                _BrokenRules.List.Add(rule);
            }
            if (IsStrongPw(_Password) == false)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Password is not strong enough");
                _BrokenRules.List.Add(rule);
            }
            if (_UserName == null || _UserName.Length > 20)
            {
                result = false;
                BrokenRule rule = new BrokenRule("User Name must be less than 20 characters.");
                _BrokenRules.List.Add(rule);
            }
            if (_Password == null || _Password.Length > 20)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Password must be less than 20 characters.");
                _BrokenRules.List.Add(rule);
            }

            String pattern = @"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?";
            Regex expression = new Regex(pattern);
            if (expression.IsMatch(_Email) == false)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Invalid email format.");
                _BrokenRules.List.Add(rule);
            }

            return result;
        }

        public bool IsStrongPw(string password)
        {
            HashSet<char> specialCharacters = new HashSet<char> { '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '_', '+', '-', '=' };

            bool result = false;
            int conditionsCount = 0;
            if (password.Any(char.IsLower))
                conditionsCount++;
            if (password.Any(char.IsUpper))
                conditionsCount++;
            if (password.Any(char.IsDigit))
                conditionsCount++;
            if (password.Any(specialCharacters.Contains))
                conditionsCount++;

            if (conditionsCount >= 3)
            {
                result = true;
            }
            return result;
        }
        #endregion

        #region Public Methods
        public User GetById(Guid id)
        {
            Database database = new Database("User");
            DataTable dt = new DataTable();
            database.Command.CommandType = System.Data.CommandType.StoredProcedure;
            database.Command.CommandText = "tblCustomerGetById";
            base.Initialize(database, base.Id);
            dt = database.ExecuteQuery();
            if (dt != null && dt.Rows.Count == 1)
            {
                DataRow dr = dt.Rows[0];
                base.Initialize(dr);
                InitializeBusinessData(dr);
                base.IsNew = false;
                base.IsDirty = false;
            }

            return this;
        }
        public void InitializeBusinessData(DataRow dr)
        {
            _UserName = dr["FirstName"].ToString();
            _Email = dr["Email"].ToString();
            _Password = dr["Password"].ToString();
        }
        public Boolean IsSavable()
        {
            Boolean result = false;

            if ((base.IsDirty == true) && (IsValid() == true))
            {
                result = true;
            }

            return result;
        }
        public User Save()
        {
            Boolean result = true;
            Database database = new Database("Customer");

            // begin transaction

            if (base.IsNew == true && IsSavable() == true)
            {
                result = Insert(database);
            }
            else if (base.Deleted == true && base.IsDirty)
            {
                result = Delete(database);
            }
            else if ((base.IsNew == false) && (IsValid() == true) && (IsDirty == true))
            {
                result = Update(database);
            }

            if (result == true)
            {
                base.IsDirty = false;
                base.IsNew = false;
            }

            // save the children
            // save the child

            // save the child
            // save the child
            // save the child

            // end transaction
            // commit
            // rollback



            return this;
        }
        public User Login(String email, String password)
        {
            Database database = new Database("Customer");
            DataTable dt = new DataTable();
            database.Command.CommandType = System.Data.CommandType.StoredProcedure;
            database.Command.CommandText = "tblCustomerLogin";
            database.Command.Parameters.Add("@Email", SqlDbType.VarChar).Value = email;
            database.Command.Parameters.Add("@Password", SqlDbType.VarChar).Value = password;

            dt = database.ExecuteQuery();
            if (dt != null && dt.Rows.Count == 1)
            {
                DataRow dr = dt.Rows[0];
                base.Initialize(dr);
                InitializeBusinessData(dr);
                base.IsNew = false;
                base.IsDirty = false;
                return this;
            }
            else
            {
                return null; // typically a good idea to have only one entry and one exit per method
            }
        }
        public User Register(String firstName, String lastName, String email)
        {
            // Generate a new 12-character password with 1 non-alphanumeric character
            String password = Membership.GeneratePassword(12, 1);
            try
            {
                Database database = new Database("Customer");
                database.Command.Parameters.Clear();
                database.Command.CommandType = CommandType.StoredProcedure;
                database.Command.CommandText = "tblUserINSERT";
                database.Command.Parameters.Add("@UserName", SqlDbType.VarChar).Value = firstName;
                database.Command.Parameters.Add("@Email", SqlDbType.VarChar).Value = email;
                database.Command.Parameters.Add("@Password", SqlDbType.VarChar).Value = password;

                _UserName = UserName;
                _Email = email;
                _Password = password;

                base.IsDirty = true;

                if (this.IsSavable() == true)
                {
                    // Provides the empty buckets
                    base.Initialize(database, Guid.Empty);
                    database.ExecuteNonQuery();

                    // Unloads the full buckets into the object
                    base.Initialize(database.Command);
                    base.IsNew = false;
                }
                else
                {
                    throw new Exception("Invalid Register Data.");
                }
            }
            catch (Exception e)
            {
                throw;
            }

            return this;
        }
        public User Exists(string email)
        {
            bool result = false;
            Database database = new Database("Customer");
            DataTable dt = new DataTable();
            database.Command.CommandType = System.Data.CommandType.StoredProcedure;
            database.Command.CommandText = "tblUserExists";
            database.Command.Parameters.Add("@Email", SqlDbType.VarChar).Value = email;

            dt = database.ExecuteQuery();
            if (dt != null && dt.Rows.Count == 1)
            {
                DataRow dr = dt.Rows[0];
                base.Initialize(dr);
                InitializeBusinessData(dr);
                base.IsNew = false;
                base.IsDirty = false;
                return this;
            }
            else
            {
                return null; // typically a good idea to have only one entry and one exit per method
            }
        }
        #endregion

        #region Public Events

        #endregion

        #region Public Event Handlers

        #endregion

        #region Construction

        #endregion

        //blah blah blah
        //test 1
        // test2
        //chase test
        // dumsmsms
        // laptop test
        // desktop test
    }
}