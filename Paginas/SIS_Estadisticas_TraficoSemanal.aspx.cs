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
    public partial class SIS_Estadisticas_TraficoSemanal : System.Web.UI.Page
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

                        if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_DIRECCION")
                        {

                            Session["Accede"] = "OK";


                        }

                    }
                
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");

                }
                else
                {
                    string str;
                    str = "window.open('http://192.168.10.254/graphs/iface/ether6-Fibercorp','Titulo','width=500,height=500,sc rollbars=no,resizable=no')";
                    Response.Write("<script languaje=javascript>" + str + "</script>");
                }


            }
        }

        protected void ImageButton1_Click(object sender, ImageClickEventArgs e)
        {
            string str;
            str = "window.open('http://192.168.10.254/graphs/iface/ether6-Fibercorp','Titulo','width=500,height=500,sc rollbars=no,resizable=no')";
            Response.Write("<script languaje=javascript>" + str + "</script>");
        }
    }
}