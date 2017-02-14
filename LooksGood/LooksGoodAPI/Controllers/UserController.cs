using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using BusinessObjects;
using DatabaseHelper;

namespace LooksGoodAPI.Controllers
{
    public class UserController : ApiController
    {
        BusinessObjects.User user = new BusinessObjects.User
        {            
            //new Product { Id = 2, Name = "Yo-yo", Category = "Toys", Price = 3.75M },
            //new Product { Id = 3, Name = "Hammer", Category = "Hardware", Price = 16.99M }
        };

        //public IEnumerable<User> GetAllProducts()
        //{
        //    BusinessObjects.User user = new BusinessObjects.User();
        //    return ;
        //}

        public IHttpActionResult GetUserById(Guid id)
        {
            User user = new BusinessObjects.User();
            user = user.GetById(id);
            if (user == null)
            {
                return NotFound();
            }
            return Ok(user);
        }
    }
}

