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
using Microsoft.Reporting.WebForms;
using System.IO;
using System.Drawing;
using System.Drawing.Imaging;
using System.Net;
using System.Text;
using System.Web.UI.HtmlControls;





namespace SintecromNet.Paginas
{
    public partial class DIR_ControlSaldosProveedores : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_ADMINISTRACION") )
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
                    DateTime fechaDesde = new DateTime(DateTime.Now.Year, DateTime.Now.Month, 1);
                    Label5.Text = fechaDesde.ToString("dd/MM/yyyy");
                    Label6.Text = DateTime.Now.AddDays(-1).ToString("dd/MM/yyyy");
                }
               
            }
        
        }

      

        private void TraerGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;         
            

            try
            {
                unosParametros = new SqlParameter[1];
               
              
                unosParametros[0] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtProveedor.Text;

                

               
                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

                unGrid.DataSource = unDS;

                unGrid.DataBind();
              

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        private void TraerGrilla0(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtProveedor.Text;




                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                unGrid.DataSource = unDS;

                unGrid.DataBind();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerSaldoHistorico(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtProveedor.Text;




                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                decimal dSaldo = Convert.ToDecimal(unDS.Tables[0].Rows[0]["Saldo"]);
                lblTotal1.Text = Math.Round(dSaldo, 2, MidpointRounding.AwayFromZero).ToString("N0");
                                



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerSaldoContable(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];


                unosParametros[0] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtProveedor.Text;




                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                decimal dSaldo = Convert.ToDecimal(unDS.Tables[0].Rows[0]["Saldo"]);
                lblTotal.Text = Math.Round(dSaldo, 2, MidpointRounding.AwayFromZero).ToString("N0");



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      
      

        protected void gwGrilla_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                                
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                //e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwGrilla, "Select$" + e.Row.RowIndex);
                //e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
           
        }

      

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
            Panel1.Visible = true;

            if (String.IsNullOrEmpty(txtProveedor.Text))
            {
                this.TraerSaldoHistorico("dbo.SP_DIR_TraerSaldoHistoricoProveedor");
                this.TraerSaldoContable("dbo.SP_DIR_TraerSaldoContableProveedor");
                Label3.Visible = false;
                Label4.Visible = false;
            }
           
            else
            {
                this.TraerSaldoHistorico("dbo.SP_DIR_TraerSaldoHistoricoProveedor");
                this.TraerSaldoContable("dbo.SP_DIR_TraerSaldoContableProveedor");
                this.TraerGrilla(gwGrilla, "dbo.SP_DIR_TraerDetalleHistoricoProveedor");
                this.TraerGrilla0(gwGrilla0,"dbo.SP_DIR_TraerDetalleContableProveedor");
                Label3.Visible = true;
                Label4.Visible = true;
               
            }

        }

       


       

      
       

       

      
       
       


           

      
      

       
     

    }

       
}
