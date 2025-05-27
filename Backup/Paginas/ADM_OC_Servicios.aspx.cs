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


namespace SintecromNet.Paginas
{
    public partial class ADM_OC_Servicios : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_ADMINISTRACION")
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

        private void TraerOC_Servicios(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
            string FechaInicial = "";
            string FechaFinal = "";

            try
            {

                FechaInicial = this.TextBoxIni.Text;
                FechaFinal = this.TextBoxFin.Text;

                try
                {
                    if (FechaInicial.Trim() != "")
                    {
                        Convert.ToDateTime(FechaInicial);
                        FechaInicial = FechaInicial.Substring(6, 4) + FechaInicial.Substring(3, 2) + FechaInicial.Substring(0, 2);
                    }
                }
                catch (Exception)
                {
                    this.LabelErr.Text = "La Fecha Inicial no es válida";
                    HiddenFieldError_ModalPopupExtender.Show();
                    return;
                }

                try
                {
                    if (FechaFinal.Trim() != "")
                    {
                        Convert.ToDateTime(FechaFinal);
                        FechaFinal = FechaFinal.Substring(6, 4) + FechaFinal.Substring(3, 2) + FechaFinal.Substring(0, 2);
                    }
                }
                catch (Exception)
                {
                    this.LabelErr.Text = "La Fecha Final no es válida";
                    HiddenFieldError_ModalPopupExtender.Show();
                    return;
                }
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;

                unosParametros[2] = new SqlParameter("@Estado", System.Data.SqlDbType.Char);
                unosParametros[2].Value = DropDownList1.SelectedValue;

                unosParametros[3] = new SqlParameter("@Proveedor", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtProveedor.Text;



                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                unGrid.DataSource = unDS;

                unGrid.DataBind();
                DataTable dt = unDS.Tables[0].Copy();
                if (dt.Rows.Count > 0) btnExcel.Visible = true;



                Session["Tabla"] = dt;

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }    
       



        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerOC_Servicios(gwOCServicios, "dbo.SP_I_TraerOrdenesDeComprasServiciosADM");

        }

        protected void btnExcel_Click1(object sender, ImageClickEventArgs e)
        {
            string nombre = "OCServiciosPendientes" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }

      

     

       
        


     
       

        }
    

    }

       

