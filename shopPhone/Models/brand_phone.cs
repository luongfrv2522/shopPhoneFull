using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace shopPhone.Models
{
    public class brand_phone
    {
        public phone aPhone { set; get; }
        public brand mapBrand { set; get; }

        public brand_phone()
        {
        }

        public brand_phone(phone aPhone, brand mapBrand)
        {
            this.aPhone = aPhone;
            this.mapBrand = mapBrand;
        }
    }
}