using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Security.Principal;
using System.IO;
using System.Data;
using System.Data.SqlClient;

namespace SintecromNet.Paginas
{
    public partial class MAN_Monitor_Incidentes : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Accion"] = "";

                Session["Usr"] = Clases.Varias.RemoveSpecialCharacters(Session["Usr"].ToString());
                Session["Usr"] = Session["Usr"].ToString().Replace("DOMINIO", "");
                string usuario = Session["Usr"].ToString().Trim();


                if (usuario == "wcrozza" || usuario == "mgonzalez" || usuario == "jvaldez" || usuario == "jarroyo")
                {
                    Session["Accede"] = "OK";
                }

                else
                {
                    IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                    foreach (IdentityReference i in irc)
                    {
                        string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                        if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_GERENTES")
                        {

                            Session["Accede"] = "OK";


                        }

                    }
                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");

                }
                else
                {
                    this.TraerIncidentes(gwIncidentes, "dbo.SP_Traer_Incidentes_MonitorM");
                    if (gwIncidentes.Rows.Count > 0)
                    {
                        imgEditar.Visible = true;
                    }
                }
            }
            
        }

       
        private void TraerIncidentes(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            

            try
            {  

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));

             
                unGrid.DataSource = unDS;

                unGrid.DataBind();
               



            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

       

        
        private void ManejoCampos()
        {      
            Label1.Visible = true;           
            ddAsignar.Visible = true;           
            btnAceptar.Visible = true;
            btnCancelar.Visible = true;            
           
        }

        private void LimpioCampos()
        {
                       
                   
            Label1.Visible = false;           
            ddAsignar.Visible = false;           
            btnAceptar.Visible = false;
            btnCancelar.Visible = false;            
            imgEditar.Visible = false;            
            //ddAsignar.SelectedValue = "Sistemas";
            this.TraerIncidentes(gwIncidentes, "dbo.SP_Traer_Incidentes_MonitorM");
            if (gwIncidentes.Rows.Count > 0)
            {
                imgEditar.Visible = true;
            }
        }

     

       

        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

      
        protected void imgEditar_Click(object sender, ImageClickEventArgs e)
        {            
            int i = 0;

            foreach (GridViewRow row in this.gwIncidentes.Rows)
            {

                if (((CheckBox)row.FindControl("CheckBox1")).Checked)
                {
                    Session["NumeroIncidente"] = this.gwIncidentes.Rows[row.RowIndex].Cells[1].Text.ToString();                   
                    i++;
                }
            }

            

            if (i != 1)
            {
                this.LabelErr.Text = "Debe Seleccionar un solo Incidente";
                HiddenFieldError_ModalPopupExtender.Show();
                return;
            }
            else
            {
                ManejoCampos();
                CargarAsignados();
            }
           

        }


        protected void btnAceptar_Click(object sender, EventArgs e)
        {
           
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            try
            {
                unAcceso.AbrirConexion();

                unAcceso.EjecutarSentencia_NonQuery("exec dbo.SP_EditarAsignacionM " + Convert.ToInt32(Session["NumeroIncidente"]) +                                                       
                                                                                            ",'" + ddAsignar.SelectedValue +  "'");                                                               
                this.LabelErr.Text = "El Incidente ha sido Asignado exitosamente";
                HiddenFieldError_ModalPopupExtender.Show();
                LimpioCampos();                
            }

            finally
            {
                unAcceso.CerrarConexion();
            }
           
        }

        protected void gwIncidentes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                int fila = (Convert.ToInt32(e.CommandArgument));                           

            }
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpioCampos();
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            this.TraerIncidentes(gwIncidentes, "dbo.SP_Traer_Incidentes_MonitorM");
            if (gwIncidentes.Rows.Count > 0)
            {
                imgEditar.Visible = true;
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

                ddAsignar.DataSource = unDS;
                ddAsignar.DataValueField = "Nombre";
                ddAsignar.DataTextField = "Nombre";
                ddAsignar.DataBind();
                ddAsignar.Items.Insert(0, new ListItem("Todos", "Todos"));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

           protected void SqlDataSource1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
           {

           }
        
    }
     
}