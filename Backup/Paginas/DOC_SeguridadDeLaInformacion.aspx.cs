using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;
using System.IO;




namespace SintecromNet.Paginas
{
    public partial class DOC_SeguridadDeLaInformacion : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            //Response.Clear();
            //Response.ContentType = "application/pdf";
            ////Response.AddHeader("Content-disposition", "attachment; filename=" & "nombre");

            //Response.WriteFile("../Documentacion/Capacitación ISO 9001.pdf");

            //Response.Flush();

            //Response.Close();

          
          
        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            string filename = ("../Documentacion/Capacitación ISO 9001.pdf");

            if (!String.IsNullOrEmpty(filename))
            {
                String dlDir = @"Descargas/";
                String path = Server.MapPath(filename);

                System.IO.FileInfo toDownload =
                  new System.IO.FileInfo(path);

                //if (toDownload.Exists)
                {
                    Response.Clear();
                    Response.AddHeader("Content-Disposition",
                               "attachment; filename=" + toDownload.Name);
                    Response.AddHeader("Content-Length",
                               toDownload.Length.ToString());
                    Response.ContentType = "application/octet-stream";
                    Response.WriteFile(filename);
                    Response.End();
                }
            } 

        }
        
    }
     
}