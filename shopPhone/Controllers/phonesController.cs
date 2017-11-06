using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using shopPhone;

namespace shopPhone.Controllers
{
    public class phonesController : Controller
    {
        private ShopDienThoaiEntities db = new ShopDienThoaiEntities();

        // GET: phones
        public ActionResult Index()
        {
            
            var phones = db.phones.Include(p => p.rela_brand_phone);
            return View(phones.ToList());
        }

        // GET: phones/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            phone phone = db.phones.Find(id);
            if (phone == null)
            {
                return HttpNotFound();
            }
            return View(phone);
        }

        // GET: phones/Create
        public ActionResult Create()
        {
            ViewBag.id_phone = new SelectList(db.rela_brand_phone, "id_phone", "id_phone");
            return View();
        }

        // POST: phones/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_phone,phone_name,description,image_feature,price,status,position,id_brand,created_at,updated_at")] phone phone)
        {
            if (ModelState.IsValid)
            {
                db.phones.Add(phone);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_phone = new SelectList(db.rela_brand_phone, "id_phone", "id_phone", phone.id_phone);
            return View(phone);
        }

        // GET: phones/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            phone phone = db.phones.Find(id);
            if (phone == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_phone = new SelectList(db.rela_brand_phone, "id_phone", "id_phone", phone.id_phone);
            return View(phone);
        }

        // POST: phones/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_phone,phone_name,description,image_feature,price,status,position,id_brand,created_at,updated_at")] phone phone)
        {
            if (ModelState.IsValid)
            {
                db.Entry(phone).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_phone = new SelectList(db.rela_brand_phone, "id_phone", "id_phone", phone.id_phone);
            return View(phone);
        }

        // GET: phones/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            phone phone = db.phones.Find(id);
            if (phone == null)
            {
                return HttpNotFound();
            }
            return View(phone);
        }

        // POST: phones/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            phone phone = db.phones.Find(id);
            db.phones.Remove(phone);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
