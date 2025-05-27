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
    public partial class MAN_Informes_Incidentes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
             
                Session["Accede"] = "NO";
                Session["Usr"] = Session["Usr"].ToString().Replace("DOMINIO", "");
                string usuario = Session["Usr"].ToString().Trim();

                if (usuario == "wcrozza" || usuario == "mgonzalez" || usuario == "jarroyo"|| usuario == "lchavez")
                {
                    Session["Accede"] = "OK";
                }

                else
                {


                    IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                    foreach (IdentityReference i in irc)
                    {
                        string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                        if (group == "DOMINIOW_SISTEMAS")
                        {

                            Session["Accede"] = "OK";


                        }

                    }
                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");
                }
              
                this.CargarAsignados();
                this.CargarddUsuarios();
                this.CargarddSector();
            }

        
        }

        private void TraerIncidentes(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
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
                unosParametros = new SqlParameter[7];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;

                unosParametros[2] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = DropDownList3.SelectedValue;

                unosParametros[3] = new SqlParameter("@Tipo", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = DropDownList4.SelectedValue;

                unosParametros[4] = new SqlParameter("@Asignado", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = ddAsignarB.SelectedItem.ToString();

                unosParametros[5] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[5].Value = ddSolicitante.SelectedValue.ToString();

                unosParametros[6] = new SqlParameter("@Sector", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = ddSector.SelectedItem.ToString();

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                unGrid.DataSource = unDS;

                unGrid.DataBind();
                DataTable dt = unDS.Tables[0].Copy();


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

        #region Lleno_Combos
        public void CargarddUsuarios()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_Usuarios"));

                ddSolicitante.DataSource = unDS;
                ddSolicitante.DataValueField = "Usuario";
                ddSolicitante.DataTextField = "Nombre";
                ddSolicitante.DataBind();
                ddSolicitante.Items.Insert(0, new ListItem("Seleccione...", "0"));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        public void CargarddSector()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_Sectores"));

                ddSector.DataSource = unDS;
                ddSector.DataValueField = "id";
                ddSector.DataTextField = "Nombre";
                ddSector.DataBind();
                ddSector.Items.Insert(0, new ListItem("Todos", "0"));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        public void CargarAsignados()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ResponsablesM"));

                ddAsignarB.DataSource = unDS;
                ddAsignarB.DataValueField = "id";
                ddAsignarB.DataTextField = "Nombre";
                ddAsignarB.DataBind();
                ddAsignarB.Items.Insert(0, new ListItem("Todos", "0"));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
        #endregion                    


        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            string nombre = "Incidentes" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerIncidentes(gwIncidentes, "dbo.SP_Traer_Incidentes_InformeM");
            
            if (gwIncidentes.Rows.Count > 0)
            {
                btnExcel.Visible = true;

            }
            else
            {
                
                btnExcel.Visible = false;

            }
        }

        }

       
    }
