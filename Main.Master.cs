using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;
using System.Web.SessionState;
using System.Web.Security;
using System.Web.UI.WebControls.WebParts;
using System.Xml;
using System.Net;
using System.IO;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
using System.Management;

namespace SintecromNet
{
    public partial class Main : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            string version = System.Reflection.Assembly.GetExecutingAssembly().GetName().Version.ToString();
            Label3.Text = version;
            WindowsIdentity user = WindowsIdentity.GetCurrent();
             string usuario = user.Name;
            usuario = Clases.Varias.RemoveSpecialCharacters(usuario.ToString());
            usuario = usuario.Replace("DOMINIO", "");
            Session["Usr"] = usuario;
            int Hora = DateTime.Now.Hour;
            if (Hora >= 13 && Hora < 20)
            {
                Label1.Text = "Buenas Tardes ";
            }
            else
            {
                if (Hora >= 20)
                {
                    Label1.Text = "Buenas Noches ";

                }
                if (Hora >= 4 && Hora < 13)
                {
                    Label1.Text = "Buenos Dias ";

                }

            }
            this.Traer_Empleado("dbo.SP_TraerNombreDesdeUsuarios");

        }
        private void Traer_Empleado(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            DataSet unDS = null;
            string sEmpleado = "";



            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Usr"].ToString().Trim();
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                sEmpleado = unDS.Tables[0].Rows[0]["Nombre"].ToString();

                DataTable dt = unDS.Tables[0].Copy();

                if (dt.Rows.Count > 0)  
                {
                    Label2.Text = sEmpleado;
                }
                else
                {
                    Label2.Text = "";
                }


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

    }
}