using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
using System.Configuration;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;
using System.Web.SessionState;


namespace SintecromNet.Paginas
{
    public partial class Pendientes_Por_Cliente : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";
            


            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                //string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                //if (group == "DOMINIOW_SISTEMAS")
                //{

                //    Session["Accede"] = "OK";


                //}

            }
            //if (Session["Accede"].ToString() == "NO")
            //{
            //    Response.Redirect("Restringida.aspx");

            //}
           lblTexto.Visible = false;
           lblTelefono.Visible = false;
           lblTextoSaldo.Visible = false;
           lblAcumulado.Visible = false;
           btnExcel.Visible = false;
           lblEmail.Visible = false;
           labelEmail.Visible = false;
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerTelefono("dbo.SP_I_TraerTelefono");
            this.TraerPendientes(this.gwPendientes, "dbo.SP_I_TraerPendientesClientes");
        }

        private void TraerTelefono(string nombreSP)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string sCliente = "";

            try
            {

                sCliente = this.txtCliente.Text;

                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@cliente", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sCliente;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreSP), unosParametros);
                if (unDS.Tables[0].Rows.Count > 0)
                {
                    lblTexto.Visible = true;
                    lblTelefono.Visible = true;
                    lblTelefono.Text = unDS.Tables[0].Rows[0]["Numero"].ToString();
                    lblEmail.Text = unDS.Tables[0].Rows[0]["Email"].ToString();

                    
                }

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
           


        }
        private void TraerPendientes(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            decimal acumulado = 0;            

            string sCliente = "";
            Session["Tabla"] = null;

            try
            {
               
                sCliente = this.txtCliente.Text;
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@cliente", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sCliente;            


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                for (int i = 0; i < unDS.Tables[0].Rows.Count; i++)
                {

                    acumulado = acumulado + Convert.ToDecimal(unDS.Tables[0].Rows[i]["Saldo"].ToString());

                }
                lblTextoSaldo.Visible = true;
                lblAcumulado.Visible = true;
                btnExcel.Visible = true;
                lblEmail.Visible = true;
                labelEmail.Visible = true;
                lblAcumulado.Text = String.Format("{0:c}", acumulado); 
                unGrid.DataSource = unDS;

                unGrid.DataBind();
                DataTable dt = unDS.Tables[0].Copy();
                
                
                Session["Tabla"] = dt;
                //gwPendientes.Columns[0].ItemStyle.Width = 300;
                


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            string nombre = txtCliente.Text;
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }
    }
}