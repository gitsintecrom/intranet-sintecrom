using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;
using System.Web.SessionState;
using System.Web.Security;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml;
using System.Net;
using System.IO;
using System.Data.SqlClient;
using System.Collections;
using System.Data;




namespace SintecromNet  
{
    public partial class _Default : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {

            WindowsIdentity user = WindowsIdentity.GetCurrent();


            Session["Usr"] = user.Name;

            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = i.Translate(typeof(NTAccount)).ToString();
            }
            this.TraerOC_Servicios("dbo.SP_I_TraerOrdenesDeComprasServiciosUS");

        }

        private void TraerOC_Servicios(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string usuario = Clases.Varias.RemoveSpecialCharacters(Session["usr"].ToString());
            usuario = usuario.Replace("DOMINIO", "");


            try
            {


                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = usuario;




                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                
                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)
                {
                    imgAdvertencia.Visible = true;
                    lblMensaje.Visible = true;
                }
                else
                {
                    imgAdvertencia.Visible = false;
                    lblMensaje.Visible = false;
                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
    }


}
