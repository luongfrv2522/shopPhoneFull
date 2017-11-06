using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace shopPhone.Controllers
{
    [Serializable]
    static class Account
    {
        public static String USERNAME_SESSION = "USERNAME_SESSION";
        public static String PASSWORD_SESSION = "PASSWORD_SESSION";
    }
    public class AdminController : Controller
    {
        ShopDienThoaiEntities db = new ShopDienThoaiEntities();
        // GET: Admin
        public ActionResult Index(String user_name, String password)
        {
            ViewBag.Error = 0;
            bool ur=false;
            if (user_name != null && password != null)
            {
                ur = db.users.Any(u => u.username.Equals(user_name) && u.password.Equals(password));
                if (ur)
                    return RedirectToAction("Index", "User");
                else
                    ViewBag.Error = 1;
            }
            return View();
        }
    }
}