using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using DatabaseHelper;
using System.Data;

namespace BusinessObjects
{
    public class PostList : Event
    {
        #region Private Members
        private BindingList<Post> _List;
        private String _path = String.Empty;
        #endregion

        #region Public Properties
        public BindingList<Post> List
        {
            get { return _List; }
        }
        public String Path
        {
            get { return _path; }
            set { _path = value; }
        }
        #endregion

        #region Private Methods

        #endregion

        #region Public Methods
        public PostList GetByUserId(Guid userId)
        {
            Database database = new Database("LooksGoodDatabase");
            DataTable dt = new DataTable();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblPostGetByUserId";
            database.Command.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = userId;
            dt = database.ExecuteQuery();
            foreach (DataRow dr in dt.Rows)
            {
                Post post = new Post();
                post.Initialize(dr);
                post.InitializeBusinessData(dr);
                _List.Add(post);
            }
            return this;
        }

        public PostList GetMostRecent()
        {
            Database database = new Database("LooksGoodDatabase");

            database.Command.Parameters.Clear();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblPostGetMostRecent";

            DataTable dt = database.ExecuteQuery();
            foreach (DataRow dr in dt.Rows)
            {
                Post post = new Post();
                post.FilePath = _path;
                post.Initialize(dr);
                post.InitializeBusinessData(dr);
                post.IsNew = false;
                post.IsDirty = false;
                post.Savable += Post_Savable;
                _List.Add(post);
            }

            return this;
        }
        public PostList Save()
        {
            foreach (Post post in _List)
            {
                if (post.IsSavable() == true)
                {
                    post.Save();
                }
            }

            return this;
        }
        public Boolean IsSavable()
        {
            Boolean result = false;

            foreach (Post post in _List)
            {
                if (post.IsSavable() == true)
                {
                    result = true;
                    break;
                }
            }

            return result;
        }
        public PostList GetAll()
        {
            Database database = new Database("LooksGoodDatabase");

            database.Command.Parameters.Clear();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblPostGetAll";

            DataTable dt = database.ExecuteQuery();   

            foreach (DataRow dr in dt.Rows)
            {
                Post post = new Post();
                post.Initialize(dr);
                post.InitializeBusinessData(dr);
                post.IsNew = false;
                post.IsDirty = false;
                post.Savable += Post_Savable;
                _List.Add(post);
            }

            return this;
        }
        #endregion

        #region Public Events
        private void Post_Savable(SavableEventArgs e)
        {
            RaiseEvent(e);
        }
        #endregion

        #region Public Event Handlers
        private void _List_AddingNew(object sender, AddingNewEventArgs e)
        {
            e.NewObject = new Post();
            Post post = (Post)e.NewObject;
            post.Savable += Post_Savable;
        }
        #endregion

        #region Construction
        public PostList()
        {
            _List = new BindingList<Post>();
            _List.AddingNew += _List_AddingNew;
        }
        #endregion
    }
}