using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.ComponentModel;
using DatabaseHelper;
using System.Data;
using BusinessObjects;

namespace BusinessObjects
{
    public class PostVotesList : Event
    {
        #region Private Members
        private BindingList<PostVotes> _List;
        #endregion

        #region Public Properties
        public BindingList<PostVotes> List
        {
            get { return _List; }
        }
        #endregion

        #region Private Methods

        #endregion

        #region Public Methods
        public PostVotesList GetAll()
        {
            Database database = new Database("LooksGoodDatabase");

            database.Command.Parameters.Clear();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblPostVotesGetAll";
            DataTable dt = database.ExecuteQuery();

            foreach (DataRow dr in dt.Rows)
            {
                PostVotes pv = new PostVotes();
                pv.Initialize(dr);
                pv.InitializeBusinessData(dr);
                pv.IsNew = false;
                pv.IsDirty = false;
                pv.Savable += PostVotes_Savable;
                _List.Add(pv);
            }

            return this;
        }


        public PostVotesList GetPostVotesByPostId(Guid postId)
        {
            Database database = new Database("LooksGoodDatabase");

            database.Command.Parameters.Clear();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblPostVotesGetByPostId";
            database.Command.Parameters.Add("@PostId", SqlDbType.UniqueIdentifier).Value = postId;

            DataTable dt = database.ExecuteQuery();
            foreach (DataRow dr in dt.Rows)
            {
                PostVotes postvotes = new PostVotes();
                Post post = new Post();
                
                postvotes.Initialize(dr);
                postvotes.InitializeBusinessData(dr);
                postvotes.IsNew = false;
                postvotes.IsDirty = false;
                postvotes.Savable += PostVotes_Savable;
                _List.Add(postvotes);
            }

            return this;
        }

        public PostVotesList LikeAbilityMath(Guid postId)
        {
            Database database = new Database("LooksGoodDatabase");

            database.Command.Parameters.Clear();
            database.Command.CommandType = CommandType.StoredProcedure;
            database.Command.CommandText = "tblPostGetLikeAbility";
            database.Command.Parameters.Add("@PostId", SqlDbType.UniqueIdentifier).Value = postId;

            DataTable dt = database.ExecuteQuery();
            foreach (DataRow dr in dt.Rows)
            {
                PostVotes postvotes = new PostVotes();
                postvotes.Initialize(dr);
                postvotes.InitializeBusinessData(dr);
                postvotes.IsNew = false;
                postvotes.IsDirty = false;
                postvotes.Savable += PostVotes_Savable;
                _List.Add(postvotes);
            }

            return this;
        }



        public PostVotesList Save()
        {
            foreach (PostVotes pv in _List)
            {
                if (pv.IsSavable() == true)
                {
                    pv.Save();
                }
            }

            return this;
        }
        #endregion

        #region Public Events
        private void PostVotes_Savable(SavableEventArgs e)
        {
            RaiseEvent(e);
        }
        #endregion

        #region Public Event Handlers
        private void _List_AddingNew(object sender, AddingNewEventArgs e)
        {
            e.NewObject = new Post();
            Post postvote = (Post)e.NewObject;
            postvote.Savable += PostVotes_Savable;
        }
        #endregion

        #region Construction
        public PostVotesList()
        {
            _List = new BindingList<PostVotes>();
            _List.AddingNew += _List_AddingNew;
        }

        #endregion
    }
}