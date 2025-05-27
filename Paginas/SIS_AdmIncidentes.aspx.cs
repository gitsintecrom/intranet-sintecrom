using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Collections;
using System.Data;
using System.DirectoryServices;
using System.DirectoryServices.ActiveDirectory;
using System.Security.Principal;
using System.Net.Mail;
using System.Text;
using System.IO;
using System.Web.UI.HtmlControls;



namespace SintecromNet.Paginas
{
    public partial class SIS_AdmIncidentes : System.Web.UI.Page
    {
        public string FechaInicial = "";
        public string FechaFinal = "";
        protected void Page_Load(object sender, EventArgs e)
        {            
            if (!IsPostBack)
            {

                Session["Accede"] = "NO";


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
                else
                {
                    Session["Accion"] = "K";
                    this.CargarAsignados();
                }
            }
        }


        //protected void Submit(object sender, EventArgs e)
        //{
        //    string name = Request.Form["Name1"];
        //    string email = TextBoxIni.Text;
        //}
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

        public void CargarAsignados2()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_Responsables"));

                ddAsignar.DataSource = unDS;
                ddAsignar.DataValueField = "id";
                ddAsignar.DataTextField = "Nombre";
                ddAsignar.DataBind();
                ddAsignar.Items.Insert(0, new ListItem("Todos", "0"));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

       

       

      

        protected void btnBuscar_Click(object sender, EventArgs e)
        {

            string name = Request.Form["Name1"];
            FechaInicial = TextBoxIni.Text;
            FechaFinal = TextBoxFin.Text;
            LimpioCampos();
            lblMsg.Visible = false;
            gwIncidentes.Visible = true;

            this.TraerIncidentes(gwIncidentes, "dbo.SP_SIS_TraerIncidentes");
            imgEditar.Visible = true;
            imgBorrar.Visible = true;
            imgExcel.Visible = true;    
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            Session["Accion"] = "A";
            ManejoCampos();
        }

        protected void gwIncidentes_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Seleccionar")
            {
                int fila = (Convert.ToInt32(e.CommandArgument));


            }
        }
  
       
   

        private void TraerIncidentes(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;
            DataSet unDS = null;
           

            try
            {


                try
                {
                    if (FechaInicial.Trim() != "")
                    {
                        Convert.ToDateTime(FechaInicial);
                        FechaInicial = FechaInicial.Substring(0, 4) + FechaInicial.Substring(5, 2) + FechaInicial.Substring(8, 2);
                    }
                }
                catch (Exception)
                {
                    lblMsg.Visible = true;
                    lblMsg.CssClass = "alert alert-danger";
                    lblMsg.Text = "La Fecha Inicial Seleccionada No es Valida";
                    return;
                }

                try
                {
                    if (FechaFinal.Trim() != "")
                    {
                        Convert.ToDateTime(FechaFinal);
                        FechaFinal = FechaFinal.Substring(0, 4) + FechaFinal.Substring(5, 2) + FechaFinal.Substring(8, 2);
                    }
                }
                catch (Exception)
                {
                    lblMsg.Visible = true;
                    lblMsg.CssClass = "alert alert-danger";
                    lblMsg.Text = "La Fecha Final Seleccionada No es Valida";
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

        protected void PageDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Recupera la fila.
            GridViewRow pagerRow = gwIncidentes.BottomPagerRow;
            // Recupera el control DropDownList...
            DropDownList pageList = (DropDownList)pagerRow.Cells[0].FindControl("PageDropDownList");            
            gwIncidentes.PageIndex =  pageList.SelectedIndex;
        //'Quita el mensaje de información si lo hubiera...
        //lblInfo.Text = ""
        
        }

        protected void DropDownListchota_SelectedIndexChanged(object sender, EventArgs e)
        {
            // Recupera la fila.
            GridViewRow pagerRow = gwIncidentes.BottomPagerRow;
            // Recupera el control DropDownList...
            DropDownList pageList = (DropDownList)pagerRow.Cells[0].FindControl("PageDropDownList");
            gwIncidentes.PageIndex = pageList.SelectedIndex;
            //'Quita el mensaje de información si lo hubiera...
            //lblInfo.Text = ""
        }

       

        protected void gwIncidentes_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            gwIncidentes.PageIndex = e.NewPageIndex;
            this.TraerIncidentes(gwIncidentes, "dbo.SP_Traer_Incidentes");

        }

        protected void imgEditar_Click(object sender, ImageClickEventArgs e)
        {
            Session["Accion"] = "M";
            int i = 0;

            foreach (GridViewRow row in this.gwIncidentes.Rows)
            {

                if (((CheckBox)row.FindControl("CheckBox2")).Checked)
                {
                    Session["NumeroIncidente"] = this.gwIncidentes.Rows[row.RowIndex].Cells[1].Text.ToString();
                    Session["FechaI"] = this.gwIncidentes.Rows[row.RowIndex].Cells[2].Text.ToString();
                    Session["Tipo"] = this.gwIncidentes.Rows[row.RowIndex].Cells[4].Text.ToString();
                    Session["Asignado"] = this.gwIncidentes.Rows[row.RowIndex].Cells[7].Text.ToString();
                    Session["Estado"] = this.gwIncidentes.Rows[row.RowIndex].Cells[5].Text.ToString();
                    Session["Usuarioi"] = this.gwIncidentes.Rows[row.RowIndex].Cells[6].Text.ToString();

                    i++;
                }
            }



            if (i != 1)
            {
                lblMsg.Visible = true;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Text = "Debe Seleccionar un solo Incidente";
                return;
            }
            else
            {
                lblMsg.Visible = false;
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

                if (((CheckBox)row.FindControl("CheckBox2")).Checked)
                {
                    Session["NumeroIncidente"] = this.gwIncidentes.Rows[row.RowIndex].Cells[1].Text.ToString();
                    i++;
                }
            }



            if (i != 1)
            {
                lblMsg.Visible = true;
                lblMsg.CssClass = "alert alert-danger";
                lblMsg.Text = "Debe Seleccionar un solo Incidente";
                return;
            }
            else
            {
                lblMsg.Visible = false;
                Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

                try
                {
                    unAcceso.AbrirConexion();
                    unAcceso.EjecutarSentencia_NonQuery("exec dbo.SP_EliminarIncidentes " + Convert.ToInt32(Session["NumeroIncidente"]));

                    lblMsg.Visible = true;
                    lblMsg.CssClass = "alert alert-success";
                    lblMsg.Text = "El Incidente se ha Eliminado Correctamente";
                    LimpioCampos();
                }

                finally
                {
                    unAcceso.CerrarConexion();
                }

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

        private void LimpioCampos()
        {
       
            
            Session["Accion"] = "K";
            imgEditar.Enabled = true;
            imgBorrar.Enabled = true;
            btnBuscar.Visible = true;
            Label8.Visible = false;
            lblFecha.Visible = false;
            Label3.Visible = false;
            Label9.Visible = false;
            Label10.Visible = false;
            Label11.Visible = false;
            Label12.Visible = false;
            ddSolicitante.Visible = false;
            ddAsignar.Visible = false;
            DropDownList1.Visible = false;
            DropDownList2.Visible = false;
            Label7.Visible = false;
            btnImagen.Visible = false;
            txtComentario.Visible = false;
            btnAceptar.Visible = false;
            btnCancelar.Visible = false;
            //btnNuevo.Visible = true;
            imgEditar.Visible = false;
            imgBorrar.Visible = false;
            imgExcel.Visible = false;
            txtComentario.Text = "";
            ddAsignar.SelectedValue = "Sistemas";
            gwComentarios.Visible = false;
            gwIncidentes.Visible = false;
            TextBoxIni.Text = "";
            TextBoxFin.Text = "";


        }

        private void ManejoCampos()
        {
            CargarddUsuarios();
            if (Session["Accion"].ToString() == "A")
            {
                //Filtro
                //Label1.Visible = false;
                //Label2.Visible = false;
                //Label4.Visible = false;
                //Label5.Visible = false;
                //Label6.Visible = false;
                //imgEditar.Visible = false;
                //imgBorrar.Visible = false;
                //btnBuscar.Visible = false;
                //TextBoxIni.Visible = false;
                //TextBoxFin.Visible = false;
                //DropDownList3.Visible = false;
                //DropDownList4.Visible = false;
                //ddAsignar.Visible = false;
                //Fin Filtro
                gwIncidentes.Visible = false;
                lblFecha.Visible = true;
                lblFecha.Text = DateTime.Now.ToShortDateString();
                Label8.Visible = true;
                Label9.Visible = true;
                Label10.Visible = true;
                Label11.Visible = true;
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
                    //Filtro
                    //Label1.Visible = false;
                    //Label2.Visible = false;
                    //Label4.Visible = false;
                    //Label5.Visible = false;
                    //Label6.Visible = false;
                    //imgEditar.Visible = false;
                    //imgBorrar.Visible = false;
                    //btnBuscar.Visible = false;
                    //TextBoxIni.Visible = false;
                    //TextBoxFin.Visible = false;
                    //DropDownList3.Visible = false;
                    //DropDownList4.Visible = false;
                    //ddAsignar.Visible = false;
                    //Fin Filtro
                    Label8.Visible = true;
                    lblFecha.Visible = true;
                    Label11.Visible = true;
                    Label9.Visible = false;
                    ddAsignar.Visible = true;
                    Label3.Visible = true;
                    DropDownList1.Visible = true;
                    ddSolicitante.Visible = false;
                    txtComentario.Visible = true;
                    btnAceptar.Visible = true;
                    btnCancelar.Visible = true;
                    DropDownList2.Visible = true;
                    Label10.Visible = true;
                    Label12.Visible = true;
                    gwIncidentes.Visible = false;
                    imgBorrar.Visible = false;
                    imgEditar.Visible = false;
                    imgExcel.Visible = false;
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
                    LimpioCampos();
                }
            }

        }
        public void TraerSectorAlta()
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
                unosParametros[0].Value = Session["Usuarioi"].ToString();

                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_TraerSector"), unosParametros);

                Session["Sector"] = unDS.Tables[0].Rows[0]["Sector"].ToString();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        public void TraerDatos()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["Usuarioi"].ToString();
                
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_SIS_TraerUsuariosIntranet"), unosParametros);

                Session["email"] = unDS.Tables[0].Rows[0]["email"].ToString();
                Session["emailg"] = unDS.Tables[0].Rows[0]["emailg"].ToString();


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        public void TraerDatosResponsables()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Nombre", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = ddAsignar.SelectedValue;

                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_SIS_TraerResponsablesIntranet"), unosParametros);

                Session["email"] = unDS.Tables[0].Rows[0]["mail"].ToString();
                Session["emailg"] = "";
                Session["evento"] = "Asignado";

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private bool EnviarEmail()
        {

            MailMessage msg = new MailMessage();

            msg.To.Add(Session["email"].ToString());
            if(!String.IsNullOrEmpty(Session["emailg"].ToString()))
            {
                msg.CC.Add(Session["emailg"].ToString());

            }

            msg.From = new MailAddress("mail.sistemas.sintecrom@gmail.com", "SintecromNET Incidentes", System.Text.Encoding.UTF8);

            msg.Subject = "Se Ha " + Session["evento"].ToString() + "  el Incidente Número " + Session["NumeroIncidente"].ToString();

            msg.SubjectEncoding = System.Text.Encoding.UTF8;
            if(Session["evento"].ToString() == "Asignado")
            {
                msg.Body = "Se ha " + Session["evento"].ToString() + " el Incidente referenciado Generado por El Usuario: "
                    + Session["Usuarioi"].ToString();                
            }
            else
            {
                msg.Body = "Se ha " + Session["evento"].ToString() + " el Incidente referenciado Generado por El Usuario: " + Session["Usuarioi"].ToString()
                + " Cuyo Detalle es el Siguiente: " + txtComentario.Text;
            }
            

            msg.BodyEncoding = System.Text.Encoding.UTF8;

            msg.IsBodyHtml = false; //Si vas a enviar un correo con contenido html entonces cambia el valor a true
            //Aquí es donde se hace lo especial

            SmtpClient client = new SmtpClient();

            //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte1234");

            client.Port = 587;

            client.Host = "smtp.gmail.com";//Este es el smtp valido para Gmail

            client.EnableSsl = true; //Esto es para que vaya a través de SSL que es obligatorio con GMail

            client.UseDefaultCredentials = false;
            //client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "Sinte.2023*");
            client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "elvyffedyeximpwp");
            client.DeliveryMethod = SmtpDeliveryMethod.Network;

            try
            {
                client.Send(msg);

                return true;
            }

            catch (Exception)
            {
                return false;
            }

        }

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

        protected void btnImagen_Click(object sender, EventArgs e)
        {
            string str;
            str = "window.open('Imagenes.aspx','Titulo','width=500,height=500,sc rollbars=no,resizable=no')";
            Response.Write("<script languaje=javascript>" + str + "</script>");
        }

        protected void btnCancelar_Click(object sender, EventArgs e)
        {
            LimpioCampos();
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

                        lblMsg.Visible = true;
                        lblMsg.CssClass = "alert alert-danger";
                        lblMsg.Text = "Debe Seleccionar un Solicitante";
                        return;
                    }
                   
                    else
                    {
                        string sSector = "";
                        this.TraerSectorAlta();
                        sSector = Session["Sector"].ToString().Trim();
                        unAcceso.EjecutarSentencia_NonQuery("exec dbo.SP_InsertarIncidentesAdmin '" + txtComentario.Text +
                                                                                                    "','" + lblFecha.Text +
                                                                                        "','" + DropDownList1.SelectedValue +
                                                                                        "','" + ddSolicitante.SelectedValue +
                                                                                                            "','" + sSector +
                                                                                    "','" + ddAsignar.SelectedValue + "'");
                        lblMsg.Visible = true;
                        lblMsg.CssClass = "alert alert-success";
                        lblMsg.Text = "El Incidente fue Ingresado Correctamente";
                        LimpioCampos();
                    }
                   
                   
                   
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
                        lblMsg.Visible = true;
                        lblMsg.CssClass = "alert alert-success";
                        lblMsg.Text = "El Incidente fue Modificado Correctamente";
                        if (DropDownList2.SelectedValue =="C")
                        {
                            this.TraerDatos();
                            Session["evento"] = "Cerrado";
                            this.EnviarEmail();
                        }
                        else
                        {
                            if(Session["Asignado"].ToString() != ddAsignar.SelectedValue)
                            {
                                this.TraerDatosResponsables();
                                this.EnviarEmail();
                            }
                            if(!String.IsNullOrEmpty(txtComentario.Text))
                            {
                                this.TraerDatos();
                                Session["evento"] = "Modificado";
                                this.EnviarEmail();
                            }
                        }

                        //Acá debería poner un Else IF cuando lo asignan, buscar el mail y enviar al responsable
                        LimpioCampos();
                    }
                    
                }
            }

            finally
            {
                unAcceso.CerrarConexion();
            }


        
        }

       
        protected void gwIncidentes_RowDataBound1(object sender, GridViewRowEventArgs e)
        {

        }

     

        protected void imgExcel_Click(object sender, ImageClickEventArgs e)
        {
            StringBuilder sb = new StringBuilder();
            StringWriter sw = new StringWriter(sb);
            HtmlTextWriter htw = new HtmlTextWriter(sw);
            Page page = new Page();
            HtmlForm form = new HtmlForm();

            gwIncidentes.EnableViewState = false;
            page.EnableEventValidation = false;
            page.DesignerInitialize();
            page.Controls.Add(form);
            form.Controls.Add(gwIncidentes);
            page.RenderControl(htw);

            Page.Response.Clear();
            Page.Response.Buffer = true;
            Page.Response.ContentType = "application/vnd.ms-excel";

            Page.Response.AddHeader("Content-Disposition", "attachment; filename= Incidentes.xls");
            Page.Response.Charset = "UTF-8";
            Page.Response.ContentEncoding = Encoding.Default;
            Page.Response.Write(sb.ToString());
            Page.Response.End();
        }

       

        
        
    }
}