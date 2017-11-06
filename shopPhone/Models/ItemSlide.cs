using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace shopPhone.Models
{
    public class ItemSlide
    {
        public String nameCatlg { set; get; }
        public int idCatlg { set; get; }
        public List<brand_phone> listItemS { set; get; }
        
    }
}