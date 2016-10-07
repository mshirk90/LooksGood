using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using DatabaseHelper;
using PhotoHelper;


namespace BusinessObjects
{
    public class Post : HeaderData
    {
        #region Private Members
        private Guid _UserId = Guid.Empty;
        private String _ImagePath = string.Empty;
        private String _Title = String.Empty;
        private String _Description = String.Empty;
        private BrokenRuleList _BrokenRules = new BrokenRuleList();
        private String _FilePath = String.Empty;
        private String _RelativeFileName = String.Empty;
        private String _UserName = string.Empty;
        private String _UpVotes = string.Empty;
        private String _DownVotes = string.Empty;
        private CommentsList _Comments = null;
        #endregion

        #region Public Properties
        public string UserName
        {
            get
            {
                User user = new User();
                user = user.GetById(_UserId);
                _UserName = user.UserName;
                return _UserName;
            }
        }
        public String FilePath
        {
            get { return _FilePath; }
            set { _FilePath = value; }
        }
        public String RelativeFileName
        {
            get { return _RelativeFileName; }
            set { _RelativeFileName = value; }
        }
        public String Title
        {
            get { return _Title; }
            set
            {
                if (_Title != value)
                {
                    _Title = value;
                    base.IsDirty = true;
                    Boolean Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }
        public String Description
        {
            get { return _Description; }
            set
            {
                if (_Description != value)
                {
                    _Description = value;
                    base.IsDirty = true;
                    Boolean Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }

        public String ImagePath
        {
            get { return _ImagePath; }
            set
            {
                if (_ImagePath != value)
                {
                    _ImagePath = value;
                    base.IsDirty = true;
                    Boolean Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }

        public String UpVotes
        {
            get { return _UpVotes; }
            set
            {
                if (_UpVotes != value)
                {
                    _UpVotes = value;
                    base.IsDirty = true;
                    Boolean Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }

        public String DownVotes
        {
            get { return _DownVotes; }
            set
            {
                if (_DownVotes != value)
                {
                    _DownVotes = value;
                    base.IsDirty = true;
                    Boolean Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }

        public Guid UserId
        {
            get { return _UserId; }
            set
            {
                if (_UserId != value)
                {
                    _UserId = value;
                    base.IsDirty = true;
                    Boolean Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
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
                database.Command.CommandText = "tblPostINSERT";
                database.Command.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = _UserId;
                database.Command.Parameters.Add("@Title", SqlDbType.VarChar).Value = _Title;
                database.Command.Parameters.Add("@Description", SqlDbType.VarChar).Value = _Description;
                database.Command.Parameters.Add("@ImagePath", SqlDbType.VarChar).Value = _ImagePath;

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

            //System.IO.File.Delete(_FilePath);
            return result;
        }
        private Boolean Update(Database database)
        {
            Boolean result = true;

            try
            {
                database.Command.Parameters.Clear();
                database.Command.CommandType = CommandType.StoredProcedure;
                database.Command.CommandText = "tblPostUPDATE";
                database.Command.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = _UserId;
                database.Command.Parameters.Add("@Title", SqlDbType.VarChar).Value = _Title;
                database.Command.Parameters.Add("@Description", SqlDbType.VarChar).Value = _Description;
                database.Command.Parameters.Add("@ImagePath", SqlDbType.VarChar).Value = _ImagePath;
                database.Command.Parameters.Add("@UpVotes", SqlDbType.VarChar).Value = _UpVotes;
                database.Command.Parameters.Add("@DownVotes", SqlDbType.VarChar).Value = _DownVotes;


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
                database.Command.CommandText = "tblPostDELETE";

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
            Boolean result = true;

            _BrokenRules.List.Clear();

            if (_UserId == Guid.Empty)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Invalid ID. ID cannot be empty");
                _BrokenRules.List.Add(rule);
            }
            if (_Title == null || _Title.Trim() == String.Empty)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Invalid. Title cannot be empty.");
                _BrokenRules.List.Add(rule);
            }
            if (_Title == null || _Title.Length > 20)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Invalid. Title cannot be greater than 20 characters.");
                _BrokenRules.List.Add(rule);
            }
            if (_Description == null || _Description.Trim() == String.Empty)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Invalid Description. Description cannot be empty.");
                _BrokenRules.List.Add(rule);
            }
            if (_Description == null || _Description.Length > 20)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Invalid Description. Description cannot be grater than 20 characters");
                _BrokenRules.List.Add(rule);
            }
            if (_ImagePath == null)
            {
                result = false;
                BrokenRule rule = new BrokenRule("Invalid. Photo cannot be null.");
                _BrokenRules.List.Add(rule);
            }

            return result;
        }
        #endregion

        #region Public Methods
        public Post GetById(Guid id)
        {
            Database database = new Database("LooksGoodDatabase");
            DataTable dt = new DataTable();
            database.Command.CommandType = System.Data.CommandType.StoredProcedure;
            database.Command.CommandText = "tblPostGetById";
            database.Command.Parameters.Add("@Id", SqlDbType.UniqueIdentifier).Value = id;
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
            _UserId = (Guid)dr["UserId"];

            _Title = dr["Title"].ToString();
            //_UserName = UserName;
            _Description = dr["Description"].ToString();
            _ImagePath = dr["ImagePath"].ToString();
            String filepath = System.IO.Path.Combine(_FilePath, Id.ToString() + ".jpg");
            _RelativeFileName = System.IO.Path.Combine("UploadedImages", Id.ToString() + ".jpg");

        }
        public Boolean IsSavable()
        {
            Boolean result = false;

            if ((base.IsDirty == true) || (IsValid() == true))
            {
                result = true;
            }

            return result;
        }
        public Post Save()
        {
            Boolean result = true;
            Database database = new Database("LooksGoodDatabase");
            if (base.IsNew == true && IsSavable() == true)
            {
                result = Insert(database);
            }
            else if (base.Deleted == true && base.IsDirty)
            {
                result = Delete(database);
            }
            else if (base.IsNew == false && IsSavable() == true)
            {
                result = Update(database);
            }

            if (result == true)
            {
                base.IsDirty = false;
                base.IsNew = false;
            }
            return this;
        }
        #endregion

        #region Public Events

        #endregion

        #region Public Event Handlers

        #endregion

        #region Construction

        #endregion
    }
}
