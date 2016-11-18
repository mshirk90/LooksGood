using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using DatabaseHelper;
using BusinessObjects;

namespace BusinessObjects
{
    public class PostVotes : HeaderData
    {
        #region Private Members
        private Guid _UserId = Guid.Empty;
        private Guid _PostId = Guid.Empty;
        private int _vote = 0;
        private int _totalvotes = 0;
        private decimal _likability = 0;
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

        public int Vote
        {
            get { return _vote; }
            set { _vote = value; }
        }

        public int TotalVotes
        {
            get { return _totalvotes; }
            set { _totalvotes = value; }
        }

        public Decimal Likability
        {
            get { return _likability; }
            set { _likability = value; }
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
                database.Command.CommandText = "tblPostVotesINSERT";
                database.Command.Parameters.Add("@Vote", SqlDbType.Int).Value = _vote;
                database.Command.Parameters.Add("@PostId", SqlDbType.UniqueIdentifier).Value = _PostId;
                database.Command.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = _UserId;




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
                database.Command.CommandText = "tblPostVotesUPDATE";
                database.Command.Parameters.Add("@Vote", SqlDbType.Int).Value = _vote;

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
                database.Command.CommandText = "tblPostVotesDELETE";

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
 
        #endregion

        #region Public Methods
        private PostVotes GetById(Guid id)
        {
            Database database = new Database("LooksGoodDatabase");
            DataTable dt = new DataTable();
            database.Command.CommandType = System.Data.CommandType.StoredProcedure;
            database.Command.CommandText = "tblPostVotesGetById";
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


        public PostVotes GetLikability(Guid postId)
        {
            Database database = new Database("LooksGoodDatabase");
            DataTable dt = new DataTable();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblPostGetLikeAbility";
            database.Command.Parameters.Add("@PostId", SqlDbType.UniqueIdentifier).Value = postId;
            dt = database.ExecuteQuery();
            if (/*dt != null &&*/ dt.Rows.Count == 1 || dt.Rows.Count == 2)
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
            _vote = (int)dr["Vote"];
        }
        public Boolean IsSavable()
        {
            Boolean result = false;

            if ((base.IsDirty == true))
            {
                result = true;
            }

            return result;
        }
        public PostVotes Save()
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