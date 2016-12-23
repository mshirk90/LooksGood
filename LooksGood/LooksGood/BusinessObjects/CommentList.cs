using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using DatabaseHelper;
using System.Data;

namespace BusinessObjects
{
    public class CommentsList : Event
    {
        #region Private Members
        private BindingList<Comments> _List;
        private String _path = String.Empty;
        #endregion

        #region Public Properties
        public BindingList<Comments> List
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
        public CommentsList GetByUserId(Guid userId)
        {

            Database database = new Database("LooksGoodDatabase");
            DataTable dt = new DataTable();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblCommentsGetByUserId";
            database.Command.Parameters.Add("@UserId", SqlDbType.UniqueIdentifier).Value = userId;
            dt = database.ExecuteQuery();
            foreach (DataRow dr in dt.Rows)
            {
                Comments comments = new Comments();
                comments.Initialize(dr);
                comments.InitializeBusinessData(dr);
                _List.Add(comments);
            }
            return this;
        }

        public CommentsList GetByPostId(Guid postId)
        {
            Database database = new Database("LooksGoodDatabase");

            database.Command.Parameters.Clear();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblCommentsGetByPostId";
            database.Command.Parameters.Add("@PostId", SqlDbType.UniqueIdentifier).Value = postId; 

            DataTable dt = database.ExecuteQuery();
            foreach (DataRow dr in dt.Rows)
            {
                Comments comments = new Comments();
                comments.Initialize(dr);
                comments.InitializeBusinessData(dr);
                comments.IsNew = false;
                comments.IsDirty = false;
                comments.Savable += Comments_Savable;
                _List.Add(comments);
            }

            return this;
        }

        public CommentsList GetByParentId(Guid parentId)
        {
            Database database = new Database("LooksGoodDatabase");

            database.Command.Parameters.Clear();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblCommentsGetByParentId";
            database.Command.Parameters.Add("@ParentId", SqlDbType.UniqueIdentifier).Value = parentId;

            DataTable dt = database.ExecuteQuery();
            foreach (DataRow dr in dt.Rows)
            {
                Comments comments = new Comments();
                comments.Initialize(dr);
                comments.InitializeBusinessData(dr);
                comments.IsNew = false;
                comments.IsDirty = false;
                comments.Savable += Comments_Savable;
                _List.Add(comments);
            }

            return this;
        }

        public bool Save()
        {
            bool result = false;
            foreach (Comments comment in _List)
            {
                if (comment.IsSavable() == true)
                {
                    comment.Save();
                    if (comment.IsNew == false)
                    {
                        result = true;
                    }
                }
            }

            return result;
        }
        public Boolean IsSavable()
        {
            Boolean result = false;

            foreach (Comments Comments in _List)
            {
                if (Comments.IsSavable() == true)
                {
                    result = true;
                    break;
                }
            }

            return result;
        }
        public CommentsList GetAll()
        {
            Database database = new Database("LooksGoodDatabase");

            database.Command.Parameters.Clear();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblCommentsGetAll";

            DataTable dt = database.ExecuteQuery();

            foreach (DataRow dr in dt.Rows)
            {
                Comments comments = new Comments();
                comments.Initialize(dr);
                comments.InitializeBusinessData(dr);
                comments.IsNew = false;
                comments.IsDirty = false;
                comments.Savable += Comments_Savable;
                _List.Add(comments);
            }

            return this;
        }
        #endregion

        #region Public Events
        private void Comments_Savable(SavableEventArgs e)
        {
            RaiseEvent(e);
        }
        #endregion

        #region Public Event Handlers
        private void _List_AddingNew(object sender, AddingNewEventArgs e)
        {
            e.NewObject = new Comments();
            Comments comments = (Comments)e.NewObject;
            comments.Savable += Comments_Savable;
        }
        #endregion

        #region Construction
        public CommentsList()
        {
            _List = new BindingList<Comments>();
            _List.AddingNew += _List_AddingNew;
        }
        #endregion
    }
}