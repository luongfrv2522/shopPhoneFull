﻿using shopPhone.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;

namespace shopPhone.Controllers
{
    

    public class UserController : Controller
    {
        private List<phone> listO = new List<phone>();
        private ShopDienThoaiEntities db = new ShopDienThoaiEntities();
        // GET: User
        public ActionResult Index()
        {

            var data = db.rela_phone_gallery.Include(r => r.gallery).Include(r => r.phone)
                            .Select(g => new { g.id_gallery,g.gallery.gallery_name, g.phone,g.phone.id_brand})
                            .Join(db.brands,b=>b.id_brand,brand=>brand.id_brand,(b,brand)=>new { b, brand })
                            .Where(bg=>bg.b.id_brand== bg.brand.id_brand)
                            .Select(bg=>new { bg.b.id_gallery,bg.b.gallery_name,bg.b.phone,bg.brand})
                            .GroupBy(g => new { g.id_gallery, g.gallery_name}).ToList()
                            .Select(a => new { id = a.Key, listItemS = a.Select(bp => new brand_phone(bp.phone, bp.brand))});

            List<ItemSlide> list = new List<ItemSlide>();

            foreach (var x in data.ToList())
            {
                //ViewBag.list = x.listItemS.ToList();
                //List<phone> a = x.listItemS.ToList<phone>();
                ItemSlide item = new ItemSlide();
                item.nameCatlg = x.id.gallery_name;
                item.idCatlg = x.id.id_gallery;
                
                item.listItemS = x.listItemS.ToList();
                list.Add(item);
            }
            return View(list);
        }

        public ActionResult Detail(int ID)
        {
            phone aPhone = db.phones.Find(ID);
            return View(aPhone);
        }
        public ActionResult ListPhones(string SortParam, int? Brand, int? Page=1)
        {
            var total = new ObjectParameter("total", typeof(int));
            //List<phone> listO = new List<phone>();
            switch (SortParam)
            {
                case "sort_price_down":
                    {
                        ViewBag.SortParam = "Giá cao đến thấp";
                        listO = db.SP_phone_price_PL(Page, 15, true, total).ToList();
                        break;
                    }
                case "sort_price_up":
                    {
                        ViewBag.SortParam = "Giá thấp đến cao";
                        //var list1 = db.sp_PageList_all(Page, 15, "phone", "price", total).ToList();
                        listO = db.SP_phone_price_PL(Page, 15, false, total).ToList();
                        break;
                    }
                default:
                    {
                        ViewBag.SortParam = "Yêu thích";
                        if (Page != null && Page > 0)
                        {
                            
                            listO = db.SP_PageList(Page, 15, total).ToList();
                        }
                        break;
                    }
            }
           
            //
            //list = db.phones.OrderByDescending(p => p.price).ToList<phone>();

            /*Lọc theo hãng*/
            if (Brand != null && Brand != 0)
            {
                listO = db.SP_phone_brand_PL(Page,15,Brand,total).ToList();
            }
            ViewBag.TotalPage = (int)total.Value;
            ViewBag.Brand = Brand;
            ViewBag.Page = Page;
            return View(listO);

        }
    }
}