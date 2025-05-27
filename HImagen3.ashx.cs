using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.SessionState;


namespace SintecromNet
{

    public class HImagen3 : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            
            if ((context.Session["Chota3"].ToString() != "Sin3"))
            {
                byte[] imgch = (byte[])context.Session["Chota3"];
                context.Response.ContentType = "image/jpeg";

                context.Response.BinaryWrite(imgch);
            }

           
               
        }
        


        public bool IsReusable
        {
            get
            {
                return false;
            }
        }
    }
}