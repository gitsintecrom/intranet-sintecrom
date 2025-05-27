using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;
using System.Web.SessionState;



namespace SintecromNet.Paginas
{
    public partial class DOC_TrackingDePedido : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                
                Session["Accede"] = "NO";
               
                
                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());
                   
                    if (group == "DOMINIOW_SISTEMAS")
                    {
                        
                        Session["Accede"] = "OK";
                        
                        
                    }

                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");                    

                }
               


            }
        }

        protected void btnDescarga0_Click(object sender, EventArgs e)
        {
             string filename = ("../Documentacion/Tracking.pdf");

            Session["Accede"] = "";

            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                Session["Grupo"] = group;

                if (group == "DOMINIOW_SISTEMAS")
                {
                    Session["Accede"] = "OK";
                }

            }

            if (!String.IsNullOrEmpty(filename))
            {
                String dlDir = @"Descargas/";
                String path = Server.MapPath(filename);

                System.IO.FileInfo toDownload =
                  new System.IO.FileInfo(path);


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
