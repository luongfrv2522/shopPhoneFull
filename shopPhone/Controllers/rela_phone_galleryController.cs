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
    public class rela_phone_galleryController : Controller
    {
        private ShopDienThoaiEntities db = new ShopDienThoaiEntities();

        // GET: rela_phone_gallery
        public ActionResult Index()
        {
            var rela_phone_gallery = db.rela_phone_gallery.Include(r => r.gallery).Include(r => r.phone);
            return View(rela_phone_gallery.ToList());
        }

        // GET: rela_phone_gallery/Details/5
        public ActionResult Details(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            rela_phone_gallery rela_phone_gallery = db.rela_phone_gallery.Find(id);
            if (rela_phone_gallery == null)
            {
                return HttpNotFound();
            }
            return View(rela_phone_gallery);
        }

        // GET: rela_phone_gallery/Create
        public ActionResult Create()
        {
            ViewBag.id_gallery = new SelectList(db.galleries, "id_gallery", "gallery_name");
            ViewBag.id_phone = new SelectList(db.phones, "id_phone", "phone_name");
            return View();
        }

        // POST: rela_phone_gallery/Create
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "id_phone,id_gallery,position")] rela_phone_gallery rela_phone_gallery)
        {
            if (ModelState.IsValid)
            {
                db.rela_phone_gallery.Add(rela_phone_gallery);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.id_gallery = new SelectList(db.galleries, "id_gallery", "gallery_name", rela_phone_gallery.id_gallery);
            ViewBag.id_phone = new SelectList(db.phones, "id_phone", "phone_name", rela_phone_gallery.id_phone);
            return View(rela_phone_gallery);
        }

        // GET: rela_phone_gallery/Edit/5
        public ActionResult Edit(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            rela_phone_gallery rela_phone_gallery = db.rela_phone_gallery.Find(id);
            if (rela_phone_gallery == null)
            {
                return HttpNotFound();
            }
            ViewBag.id_gallery = new SelectList(db.galleries, "id_gallery", "gallery_name", rela_phone_gallery.id_gallery);
            ViewBag.id_phone = new SelectList(db.phones, "id_phone", "phone_name", rela_phone_gallery.id_phone);
            return View(rela_phone_gallery);
        }

        // POST: rela_phone_gallery/Edit/5
        // To protect from overposting attacks, please enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "id_phone,id_gallery,position")] rela_phone_gallery rela_phone_gallery)
        {
            if (ModelState.IsValid)
            {
                db.Entry(rela_phone_gallery).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.id_gallery = new SelectList(db.galleries, "id_gallery", "gallery_name", rela_phone_gallery.id_gallery);
            ViewBag.id_phone = new SelectList(db.phones, "id_phone", "phone_name", rela_phone_gallery.id_phone);
            return View(rela_phone_gallery);
        }

        // GET: rela_phone_gallery/Delete/5
        public ActionResult Delete(int? id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            rela_phone_gallery rela_phone_gallery = db.rela_phone_gallery.Find(id);
            if (rela_phone_gallery == null)
            {
                return HttpNotFound();
            }
            return View(rela_phone_gallery);
        }

        // POST: rela_phone_gallery/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(int id)
        {
            rela_phone_gallery rela_phone_gallery = db.rela_phone_gallery.Find(id);
            db.rela_phone_gallery.Remove(rela_phone_gallery);
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
