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
using System.Data.SqlClient;
using System.Collections;
using System.Data;


namespace SintecromNet.Paginas
{
    public partial class DIR_Cheques : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_DIRECCION" || group == "DOMINIOW_ADMINISTRACION")
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
                    this.TraerCheques("dbo.SP_I_TraerValores");
                }


            }




        }
        private void TraerCheques(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");


            try
            {

                unAcceso.AbrirConexion();
                unAcceso.EjecutarSentencia_NonQuery(nombreStored);


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
    }
}