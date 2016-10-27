using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using BusinessObjects;
using System.ComponentModel;
using System.Web.Script.Services;
using Newtonsoft.Json;

namespace LooksGood
{
    /// <summary>
    /// Summary description for LooksGood1
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // To allow this Web Service to be called from script, using ASP.NET AJAX, uncomment the following line. 
     [System.Web.Script.Services.ScriptService]
    public class LooksGoodWS : System.Web.Services.WebService
    {

        [WebMethod]
        public bool DoesEmailExist(string email)
        {
            bool result = true;
            User user = new User();
            user = user.Exists(email);
            if (user == null)
            {
                result = false;
            }
            return result;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public Post ChangeVotesByPostId(string id, int change)
        {
            Post post = new Post();
            post = post.GetById(new Guid(id));

            post.Votes += change;
            post.Save();
            return post;
        }



        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public Post GetVotesByPostId(string id)
        {
            Post post = new Post();
            post = post.GetById(new Guid(id));

            return post;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String GetCommentsByPostId(string postId)
        {
            CommentsList comments = new CommentsList();
            comments = comments.GetByPostId(new Guid(postId));
            string jsoncomments = JsonConvert.SerializeObject(comments.List);

            return jsoncomments;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string SubmitComment(string postid, string commentText, string userid)
        {
            Comments comment = new Comments();
            comment.PostId = new Guid(postid);
            comment.UserId = new Guid(userid);
            comment.Comment = commentText;
            comment.Save();
            return GetCommentsByPostId(postid);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public String GetMostRecentPosts()
        {
            PostList postList = new PostList();
            postList = postList.GetMostRecent();

            string pList = JsonConvert.SerializeObject(postList.List);

            return pList;
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetPostById(string postId)
        {
            Post post = new Post();
            post = post.GetById(new Guid(postId));

            return JsonConvert.SerializeObject(post);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetUserPostById(string userId)
        {
            PostList postList = new PostList();
            postList = postList.GetByUserId(new Guid(userId));

            return JsonConvert.SerializeObject(postList.List);
        }

        [WebMethod]
        [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
        public string GetUserCommentsById(string userId)
        {
            CommentsList commentList = new CommentsList();
            commentList = commentList.GetByUserId(new Guid(userId));

            return JsonConvert.SerializeObject(commentList.List);
        }
    }
}
