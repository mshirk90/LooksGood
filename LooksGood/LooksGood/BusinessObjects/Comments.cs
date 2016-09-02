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
                database.Command.CommandText = "tblEmployeeHobbyINSERT";
                database.Command.Parameters.Add("@EmployeeId", SqlDbType.UniqueIdentifier).Value = _UserId;
                database.Command.Parameters.Add("@HobbyId", SqlDbType.UniqueIdentifier).Value = _PostId;
                //PROVIDES THE EMPTY BUCKETS
                base.Initialize(database, Guid.Empty);
                database.ExecuteNonQueryWithTransaction();
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
                database.Command.CommandText = "tblEmployeeHobbyUPDATE";
                database.Command.Parameters.Add("@EmployeeId", SqlDbType.UniqueIdentifier).Value = _UserId;
                database.Command.Parameters.Add("@EmployeeId", SqlDbType.UniqueIdentifier).Value = _UserId;
                database.Command.Parameters.Add("@HobbyId", SqlDbType.UniqueIdentifier).Value = _PostId;
                //PROVIDES THE EMPTY BUCKETS
                base.Initialize(database, base.Id);
                database.ExecuteNonQueryWithTransaction();
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
                database.Command.CommandText = "tblEmployeeHobbyDELETE";
                //PROVIDES THE EMPTY BUCKETS
                base.Initialize(database, base.Id);
                database.ExecuteNonQueryWithTransaction();
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
        public Comments GetById(Guid id)
        {

            Database database = new Database("LooksGood");
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
            _UserId = (Guid)dr["EmployeeId"];
            _PostId = (Guid)dr["HobbyId"];
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

        public Comments Save(Database database, Guid parentId)
        {
            _UserId = parentId;

            bool result = true;
            //Database database = new Database("Employer");
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