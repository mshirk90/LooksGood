﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using DatabaseHelper;
using System.Data;

namespace BusinessObjects
{
    public class Comments : HeaderData
    {
        #region Private Members
        private Guid _UserId = Guid.Empty;
        private Guid _PostId = Guid.Empty;
        private string _Comment = string.Empty;
        private string _UserName = string.Empty;

        #endregion

        #region Public Properties
        public Guid UserId
        {
            get
            {
                return _UserId;
            }
            set
            {
                if (_UserId != value)
                {
                    _UserId = value;
                    base.IsDirty = true;
                    bool Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }

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

        public Guid PostId
        {
            get
            {
                return _PostId;
            }
            set
            {
                if (_PostId != value)
                {
                    _PostId = value;
                    base.IsDirty = true;
                    bool Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }

        public String Comment
        {
            get
            {
                return _Comment;
            }
            set
            {
                if (_Comment != value)
                {
                    _Comment = value;
                    base.IsDirty = true;
                    bool Savable = IsSavable();
                    SavableEventArgs e = new SavableEventArgs(Savable);
                    RaiseEvent(e);
                }
            }
        }
        #endregion

        #region  Private Methods 
        private bool Insert(Database database)
        {
            bool result = true;
            try
            {
                database.Command.Parameters.Clear();
                database.Command.CommandType = System.Data.CommandType.StoredProcedure;
                database.Command.CommandText = "tblCommentsINSERT";
                database.Command.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = _UserId;
                database.Command.Parameters.Add("@PostId", SqlDbType.UniqueIdentifier).Value = _PostId;
                database.Command.Parameters.Add("@Comment", SqlDbType.VarChar).Value = _Comment;
                //PROVIDES THE EMPTY BUCKETS
                base.Initialize(database, Guid.Empty);
                database.ExecuteNonQuery();
                //UNLOADS THE FULL BUCKETS INTO THE OBJECT
                base.Initialize(database.Command);
            }
            catch (Exception e)
            {
                result = false;
                throw;
            }
            return result;

        }
        private bool Update(Database database)
        {
            bool result = true;
            try
            {
                database.Command.Parameters.Clear();
                database.Command.CommandType = System.Data.CommandType.StoredProcedure;
                database.Command.CommandText = "tblCommentsUPDATE";
                database.Command.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = _UserId;
                database.Command.Parameters.Add("@PostId", SqlDbType.UniqueIdentifier).Value = _PostId;
                //PROVIDES THE EMPTY BUCKETS
                base.Initialize(database, base.Id);
                database.ExecuteNonQuery();
                //UNLOADS THE FULL BUCKETS INTO THE OBJECT
                base.Initialize(database.Command);
            }
            catch (Exception e)
            {
                result = false;
                throw;
            }
            return result;


        }
        private bool Delete(Database database)
        {
            bool result = true;
            try
            {
                database.Command.Parameters.Clear();
                database.Command.CommandType = System.Data.CommandType.StoredProcedure;
                database.Command.CommandText = "tblCommentsDELETE";
                //PROVIDES THE EMPTY BUCKETS
                base.Initialize(database, base.Id);
                database.ExecuteNonQuery();
                //UNLOADS THE FULL BUCKETS INTO THE OBJECT
                base.Initialize(database.Command);
            }
            catch (Exception e)
            {
                result = false;
                throw;
            }
            return result;

        }

        private bool IsValid()
        {
            bool result = true;

            //INTENTIONALLY LEAVING OUT EMPLOYEEID

            if (_PostId == null || _PostId == Guid.Empty)
            {
                result = false;
            }
            return result;
        }

        #endregion

        #region  Public Methods
        public Comments GetByUserId(Guid id)
        {

            Database database = new Database("LooksGoodDatabase");
            DataTable dt = new DataTable();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblCommentsGetById";
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

        public Comments GetById(Guid id)
        {

            Database database = new Database("LooksGoodDatabase");
            DataTable dt = new DataTable();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblCommentsGetById";
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
            _UserId = (Guid)dr["UserId"];
            _PostId = (Guid)dr["PostId"];
            _Comment = dr["Comment"].ToString();
        }

        public bool IsSavable()
        {
            bool result = false;
            if (base.IsDirty == true && IsValid() == true)
            {
                result = true;
            }
            return result;
        }

        public Comments Save()
        {
            Database database = new Database("LooksGoodDatabase");
            bool result = true;

            if (base.IsNew == true && IsSavable() == true)
            {
                result = Insert(database);
            }
            else if (base.Deleted == true && base.IsDirty == true)
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

        #region  Public Events 

        #endregion

        #region  Public Event Handlers 

        #endregion

        #region Construction 
        public Comments()
        {

        }


        #endregion
    }
}