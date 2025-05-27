using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Web.SessionState;


namespace SintecromNet
{

    public class HImagen4 : IHttpHandler, System.Web.SessionState.IRequiresSessionState
    {

        public void ProcessRequest(HttpContext context)
        {
            
            if ((context.Session["Chota4"].ToString() != "Sin4"))
            {
                byte[] imgch = (byte[])context.Session["Chota4"];
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