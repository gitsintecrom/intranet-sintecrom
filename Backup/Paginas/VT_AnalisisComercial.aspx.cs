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
    public partial class VT_AnalisisComercial : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {

                Session["Accede"] = "NO";
                string usuario = Clases.Varias.RemoveSpecialCharacters(Session["usr"].ToString());

               
                    IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                    foreach (IdentityReference i in irc)
                    {
                        string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                        if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_DIRECCION" || group == "DOMINIOW_VENTAS")
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
    }
}