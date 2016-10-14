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
        public String GetCommentsByPostId(string id)
        {
            CommentsList comments = new CommentsList();
            comments = comments.GetByPostId(new Guid(id));
            string jsoncomments = JsonConvert.SerializeObject(comments.List);

            return jsoncomments;
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
    }
}
