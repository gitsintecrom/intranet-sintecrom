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
    public partial class SIS_Administracion_Incidentes : System.Web.UI.Page
    {

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Accion"] = "";

                Session["Usr"] = Clases.Varias.RemoveSpecialCharacters(Session["Usr"].ToString());
                Session["Usr"] = Session["Usr"].ToString().Replace("DOMINIO", "");



                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS")
                    {

                        Session["Accede"] = "OK";


                    }

                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");

                }
                this.CargarAsignados();
                this.TraerAsignados();
                this.TraerDemoraAsignados();
                this.TraerDemoraCerrados();
                this.TraerPorcentual();
                this.TraerAbiertos();
            }
          
        }

        #region LlenoGrillas
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
                unosParametros = new SqlParameter[5];

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

        private void TraerComentarios(GridView unGrid1, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;

            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Incidente", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["NumeroIncidente"]);



                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);


                unGrid1.DataSource = unDS;

                unGrid1.DataBind();




            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        #endregion

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

        public void CargarAsignados()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_Responsables"));

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

        #region ComportamientoCampos
        private void ManejoCampos()
        {
            CargarddUsuarios();
            if (Session["Accion"].ToString() == "A")
            {
                imgEditar.Visible = false;
                imgBorrar.Visible = false;
                btnVer.Visible = false;
                Label1.Visible = true;
                lblFecha.Visible = true;
                lblFecha.Text = DateTime.Now.ToShortDateString();
                Label2.Visible = true;
                Label4.Visible = true;
                Label5.Visible = true;
                ddSolicitante.Visible = true;
                ddAsignar.Visible = true;
                Label3.Visible = true;
                DropDownList1.Visible = true;
                txtComentario.Visible = true;
                btnAceptar.Visible = true;
                btnCancelar.Visible = true;
            }
            else
            {
                if (Session["Accion"].ToString() == "M")
                {
                    Label1.Visible = true;
                    lblFecha.Visible = true;
                    Label4.Visible = true;
                    Label5.Visible = true;
                    ddAsignar.Visible = true;
                    Label3.Visible = true;
                    DropDownList1.Visible = true;
                    txtComentario.Visible = true;
                    btnAceptar.Visible = true;
                    btnCancelar.Visible = true;
                    DropDownList2.Visible = true;
                    Label6.Visible = true;
                    gwIncidentes.Visible = false;
                    imgBorrar.Visible = false;
                    imgEditar.Visible = false;
                    if (Session["bImagen"].ToString() == "SI")
                    {
                        Label7.Visible = true;
                        btnImagen.Visible = true;
                    }
                    else
                    {
                        Label7.Visible = false;
                        btnImagen.Visible = false;
                    }
                }
                else
                { 
                }
            }

        }

        private void LimpioCampos()
        {

            Session["Accion"] = "";            
            imgEditar.Enabled = true;
            imgBorrar.Enabled = true;
            btnVer.Visible = true;
            Label1.Visible = false;
            lblFecha.Visible = false;
            Label2.Visible = false;
            Label4.Visible = false;
            Label5.Visible = false;
            ddSolicitante.Visible = false;
            ddAsignar.Visible = false;
            Label3.Visible = false;
            DropDownList1.Visible = false;
            DropDownList2.Visible = false;
            Label6.Visible = false;
            Label7.Visible = false;
            btnImagen.Visible = false;
            txtComentario.Visible = false;
            btnAceptar.Visible = false;
            btnCancelar.Visible = false;
            imgNuevo.Visible = true;
            imgEditar.Visible = false;
            imgBorrar.Visible = false;
            txtComentario.Text = "";
            ddAsignar.SelectedValue = "Sistemas";
            gwComentarios.Visible = false;
            gwIncidentes.Visible = false;
            lblMensaje.Text = "Presione Agregar para Ingresar un Nuevo Incidente";
            TextBoxIni.Text = "";
            TextBoxFin.Text = "";
            

        }
        #endregion     
                
        #region Eventos

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            imgNuevo.Visible = false;

            gwIncidentes.Visible = true;
            this.TraerIncidentes(gwIncidentes, "dbo.SP_Traer_Incidentes");
            if (gwIncidentes.Rows.Count > 0)
            {
                imgEditar.Visible = true;
                imgBorrar.Visible = true;
                lblMensaje.Text = "Seleccione de la Grilla un Incidente y Presione Modificar / Eliminar";

            }
            else
            {
                lblMensaje.Text = "Su búsqueda no ha arrojado Resultados, modifique el Rango y Reintente";

            }
        }
        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

        protected void imgNuevo_Click(object sender, ImageClickEventArgs e)
        {
            Session["Accion"] = "A";
            ManejoCampos();
        }

        protected void imgEditar_Click(object sender, ImageClickEventArgs e)
        {
            Session["Accion"] = "M";
            int i = 0;

            foreach (GridViewRow row in this.gwIncidentes.Rows)
            {

                if (((CheckBox)row.FindControl("CheckBox1")).Checked)
                {
                    Session["NumeroIncidente"] = this.gwIncidentes.Rows[row.RowIndex].Cells[1].Text.ToString();
                    Session["FechaI"] = this.gwIncidentes.Rows[row.RowIndex].Cells[2].Text.ToString();
                    Session["Tipo"] = this.gwIncidentes.Rows[row.RowIndex].Cells[4].Text.ToString();
                    Session["Asignado"] = this.gwIncidentes.Rows[row.RowIndex].Cells[7].Text.ToString();
                    Session["Estado"] = this.gwIncidentes.Rows[row.RowIndex].Cells[5].Text.ToString();
                   
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
                ChequeoImagen();
                ManejoCampos();
                lblFecha.Text = Session["FechaI"].ToString();
                DropDownList1.SelectedValue = Session["Tipo"].ToString();
                ddAsignar.SelectedValue = Session["Asignado"].ToString();
                if (Session["Estado"].ToString() == "Asignado")
                {
                    DropDownList2.SelectedValue = "S";
                }
                else
                {
                    if (Session["Estado"].ToString() == "Abierto")
                        DropDownList2.SelectedValue = "A";
                    else
                    {
                        DropDownList2.SelectedValue = "C";
                    }                
                }
                gwComentarios.Visible = true;
                this.TraerComentarios(gwComentarios, "dbo.SP_Traer_Comentarios");
            }
           

        }

        protected void imgBorrar_Click(object sender, ImageClickEventArgs e)
        {
            Session["Accion"] = "B";

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

                Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

                try
                {
                    unAcceso.AbrirConexion();

                    unAcceso.EjecutarSentencia_NonQuery("exec dbo.SP_EliminarIncidentes " + Convert.ToInt32(Session["NumeroIncidente"]));
                    this.LabelErr.Text = "El Incidente se ha sido Eliminado exitosamente";
                    HiddenFieldError_ModalPopupExtender.Show();
                    LimpioCampos();
                }

                finally
                {
                    unAcceso.CerrarConexion();
                }

            }
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {
           
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            try
            {
                unAcceso.AbrirConexion();

                if (Session["Accion"].ToString() == "A")
                {
                    
                    if (ddSolicitante.SelectedValue == "0")
                    {
                        this.LabelErr.Text = "Debe Seleccionar un Solicitante";
                        HiddenFieldError_ModalPopupExtender.Show();
                        return;
                    }
                   
                    
                    string sSector = "";
                    this.TraerSector();
                    sSector = Session["Sector"].ToString().Trim();
                    unAcceso.EjecutarSentencia_NonQuery("exec dbo.SP_InsertarIncidentesAdmin '" + txtComentario.Text +
                                                                                               "','" + lblFecha.Text +
                                                                                 "','" + DropDownList1.SelectedValue +
                                                                                 "','" + ddSolicitante.SelectedValue +
                                                                                                     "','" + sSector +
                                                                               "','" + ddAsignar.SelectedValue + "'");
                    this.LabelErr.Text = "El Incidente ha sido Ingresado exitosamente";
                    HiddenFieldError_ModalPopupExtender.Show();
                    LimpioCampos();
                }
                else
                {
                    if (Session["Accion"].ToString() == "M")
                    {
                        unAcceso.EjecutarSentencia_NonQuery("exec dbo.SP_EditarIncidentesAdmin '" + txtComentario.Text +
                                                              "'," + Convert.ToInt32(Session["NumeroIncidente"]) +
                                                                              ",'" + DropDownList1.SelectedValue +
                                                                                 "','" + ddAsignar.SelectedValue +
                                                                       "','" + DropDownList2.SelectedValue +
                                                                       "','" + Session["Usr"].ToString() + "'");
                        this.LabelErr.Text = "El Incidente ha sido Editado exitosamente";
                        HiddenFieldError_ModalPopupExtender.Show();
                        LimpioCampos();
                    }
                    
                }
            }

            finally
            {
                unAcceso.CerrarConexion();
            }


            if (Session["Accion"].ToString() == "A")
            {

               
               
            }
            else
            {
 
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

        protected void gwIncidentes_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.Cells[5].Text == "Abierto")
            {
                e.Row.ControlStyle.BackColor = System.Drawing.Color.Red;
                e.Row.ControlStyle.ForeColor = System.Drawing.Color.White;
            }
            else
            {
                if (e.Row.Cells[5].Text == "Asignado")
                {
                    e.Row.ControlStyle.BackColor = System.Drawing.Color.Yellow;
                    e.Row.ControlStyle.ForeColor = System.Drawing.Color.Black;
                }
                if (e.Row.Cells[5].Text == "Cerrado")
                {
                    e.Row.ControlStyle.BackColor = System.Drawing.Color.Green;
                    e.Row.ControlStyle.ForeColor = System.Drawing.Color.White;

                }
            }
        }

        protected void btnImagen_Click(object sender, EventArgs e)
        {
            string str;
            str = "window.open('Imagenes.aspx','Titulo','width=500,height=500,sc rollbars=no,resizable=no')";
            Response.Write("<script languaje=javascript>" + str + "</script>");
        }

        protected void Timer1_Tick(object sender, EventArgs e)
        {
            Session["CantAbiertos"] = Convert.ToInt32(lblAbiertos.Text);
            this.TraerAbiertos();
            if (Convert.ToInt32(lblAbiertos.Text) > Convert.ToInt32(Session["CantAbiertos"]))
            {
                this.LabelErr.Text = "Ha Ingresado un Nuevo Incidente. Verifique";
                HiddenFieldError_ModalPopupExtender.Show();

            }

        }
        #endregion

        #region Dataset's

        public void TraerSector()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = ddSolicitante.SelectedValue;
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_TraerSector"), unosParametros);

                Session["Sector"] = unDS.Tables[0].Rows[0]["Sector"].ToString();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void ChequeoImagen()
        {
            byte[] img = null;
            int idI = Convert.ToInt16(Session["NumeroIncidente"]);
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            SqlParameter[] unosParametros = null;
            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Incidente", System.Data.SqlDbType.Int);
                unosParametros[0].Value = idI;
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_Imagen"), unosParametros);


                if (!String.IsNullOrEmpty(unDs.Tables[0].Rows[0]["Imagen"].ToString()))
                {

                    img = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }

            if (img != null)
            {
                Session["bImagen"] = "SI";
            }
            else
            {
                Session["bImagen"] = "NO";
            }
        }

        private void TraerAsignados()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            try
            {
                
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_TraeIncidentesAsignados"));
                lblAsignados.Text = (unDs.Tables[0].Rows[0]["asignados"]).ToString();
                Session["CantAsignados"] = unDs.Tables[0].Rows[0]["asignados"];

                }            
            finally
            {
                unAcceso.CerrarConexion();
            }

            
        }

        private void TraerDemoraAsignados()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            try
            {

                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_TraeDemoraIncidentesAsignados"));
                decimal demora = Convert.ToDecimal(unDs.Tables[0].Rows[0]["diferencia"]);
                decimal indicador = demora / Convert.ToDecimal(Session["CantAsignados"]);
                lblDemoraA.Text = String.Format("{0:n}", indicador); 

            }
            finally
            {
                unAcceso.CerrarConexion();
            }


        }

        private void TraerDemoraCerrados()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            try
            {

                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_TraeDemoraIncidentesCerrados"));
                decimal demora = Convert.ToDecimal(unDs.Tables[0].Rows[0]["diferencia"]);
                decimal cantidad = Convert.ToDecimal(unDs.Tables[0].Rows[0]["cantidad"]);
                decimal indicador = demora / cantidad;
                lblDemoraC.Text = String.Format("{0:n}", indicador);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }


        }

        private void TraerPorcentual()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            try
            {

                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_TraeIncidentesPorcentual"));
                decimal cantidad = Convert.ToDecimal(unDs.Tables[0].Rows[0]["mes"]);
                decimal indicador = (Convert.ToDecimal(Session["CantAsignados"]) * 100) / cantidad;
                lblPorcentual.Text = String.Format("{0:n}", indicador);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }


        }

        private void TraerAbiertos()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            try
            {

                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_TraeIncidentesAbiertos"));
                lblAbiertos.Text = (unDs.Tables[0].Rows[0]["abiertos"]).ToString();
                
                

            }
            finally
            {
                unAcceso.CerrarConexion();
            }


        }
        #endregion

       

        

       
      
        
    }
     
}