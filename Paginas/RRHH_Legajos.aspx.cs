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


namespace SintecromNet.Paginas
{
    public partial class RRHH_Legajos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Cert"] = "";




                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_RRHH")
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
                    this.TraerEmpleados("dbo.SP_I_TraerEmpleados");
                    Panel5.Visible = false;
                    //Panel6.Visible = false;

                }
              
            }

        
        }

        private void TraerEmpleados(string nombreStored)
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

        private void CargarGrilla(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;
            

            try
            {
                unosParametros = new SqlParameter[3];

                unosParametros[0] = new SqlParameter("@Legajo", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = txtLegajo.Text;

                unosParametros[1] = new SqlParameter("@Nombre", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = txtNombre.Text;

                unosParametros[2] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = DropDownList1.SelectedValue;
               

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

        private void CargarGrillaAusencias(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Legajo_Id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();


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

        private void CargarGrillaEstudios(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Legajo_Id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();


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

        private void CargarGrillaSanciones(GridView unGrid, string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Legajo_Id", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();              


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
      

        protected void Button2_Click1(object sender, EventArgs e)
        {
            Panel9.Visible = false;
        }

        protected void btnExcel_Click(object sender, ImageClickEventArgs e)
        {
            string nombre = "EstadoCartera" + DateTime.Now.ToShortDateString();
            DataTable tabla = (DataTable)(Session["Tabla"]);

            Clases.Varias.ExportToSpreadsheet(tabla, nombre);
        }

        protected void btnModificar_Click(object sender, EventArgs e)
        {

            byte[] imagen;
            string strFileName;
            string strFolder;
            string strExtension;
            strFolder = Server.MapPath("./");
            if (!String.IsNullOrEmpty(fuImagen.ToString()))
            {
                strFileName = fuImagen.PostedFile.FileName;
                strFileName = Path.GetFileName(strFileName);
                strExtension = Path.GetExtension(strFileName);
                btnModificar.Enabled = true;

                if (!ValidarExtension(strExtension))
                {
                    this.LabelErr.Text = "El Archivo Seleccionado no es una Imagen";
                    HiddenFieldError0_ModalPopupExtender.Show();
                    return;
                }
                else
                {
                    using (BinaryReader reader = new BinaryReader(fuImagen.PostedFile.InputStream))
                    {
                        imagen = reader.ReadBytes(fuImagen.PostedFile.ContentLength);
                        Session["imgInc"] = imagen;
                        Session["NombreArchivo"] = strFileName;

                    }
                }
                this.ActualizaFoto("dbo.SP_InsertarImagenLegajo");
               // btnModificar.Enabled = false;
            }
            
            //this.TraerComposiciones(gwComposicionesQuimicas, "dbo.SP_I_TraerComposicionesQuimicas");
            Cargar_Foto();
        }
      
        private Boolean ValidarExtension(string sExtension)
        {
            Boolean verif = false;
            switch (sExtension)
            {
                case ".jpg":
                case ".jpeg":
                case ".png":
                case ".gif":
                case ".bmp":
                case ".JPG":
                case ".JPEG":
                case ".PNG":
                case ".GIF":
                case ".BMP":
                    verif = true;
                    break;
                default:
                    verif = false;
                    break;
            }
            return verif;
        }
        private void Cargar_Foto()
        {
            byte[] img = null;
            //string sArchivo = "";
            //string sPath = "/0-Proyectos/0-Proyectos/SintecromNet/SintecromNet/Images/Foto.jpg";
            //string sPath = "/Images/Foto.jpg";
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            SqlParameter[] unosParametros = null;
            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Legajo_ID", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = Session["IDMODI"].ToString();
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ImagenLegajo1"), unosParametros);

                if (unDs.Tables[0].Rows.Count > 0)
                {
                    if (!String.IsNullOrEmpty(unDs.Tables[0].Rows[0]["Imagen"].ToString()))
                    {

                        img = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
                        Session["Chota"] = (byte[])unDs.Tables[0].Rows[0]["Imagen"];
                        Session["NombreArchivo"] = unDs.Tables[0].Rows[0]["NombreArchivo"].ToString();
                        string sArchivo = unDs.Tables[0].Rows[0]["NombreArchivo"].ToString();
                        string sPath = "//intranet/TempImageFiles/";
                        File.WriteAllBytes(sPath + sArchivo, img);
                        //Session["Chota"] = sPath + sArchivo;


                        imgFoto.ImageUrl = ("~/HImagen.ashx");
                    }
                    else 
                    {
                        Session["Chota"] = "Sin";
                    }
                    
                   
                }
                else
                {
                    Session["Chota"] = "Sin";
                }
            }
            finally
            {
                unAcceso.CerrarConexion();
            }

            if (img != null)
            {
                //Response.ContentType = "image/jpeg";
                //Response.Expires = 0;
                //Response.Buffer = true;
                //Response.Clear();
                //Response.BinaryWrite(img);
                //Response.End();

                //File.WriteAllBytes(sPath, img);
                //imgFoto.ImageUrl = sPath;
            }
            //else
            //{
            //    Image1.Visible = false;
            //    lblMensaje.Visible = true;
            //    lblMensaje.Text = "El incidente Seleccionado no posee imágenes adjuntas";
            //}
        }

        private void ActualizaFoto(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[5];

                unosParametros[0] = new SqlParameter("@Tipo", System.Data.SqlDbType.Int);
                unosParametros[0].Value = 1;

                unosParametros[1] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = Session["Usuario"].ToString().Trim();

                unosParametros[2] = new SqlParameter("@Imagen", System.Data.SqlDbType.Image);
                unosParametros[2].Value = Session["imgInc"];

                unosParametros[3] = new SqlParameter("@Archivo", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["NombreArchivo"].ToString().Trim();

                unosParametros[4] = new SqlParameter("@Legajo_id", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = Session["IDMODI"].ToString();

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        
        }

        private void ActualizaCertificado(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[4];

                unosParametros[0] = new SqlParameter("@Tipo", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt16(Session["Cert"]);                

                unosParametros[1] = new SqlParameter("@Imagen", System.Data.SqlDbType.Image);
                unosParametros[1].Value = Session["imgInc"];

                unosParametros[2] = new SqlParameter("@Archivo", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = Session["NombreArchivo"].ToString().Trim();

                unosParametros[3] = new SqlParameter("@Legajo_id", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = Session["IDMODI"].ToString();

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }

        private void EliminarCertificado(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Numero", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt32(Session["IDIMAGEN"]);
                               
                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreSP), unosParametros);
            }
            finally
            {
                unAcceso.CerrarConexion();

            }

        }
              

        protected void gwLegajos_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["IDMODI"] = this.gwLegajos.DataKeys[index].Values[0].ToString();
                Session["Usuario"] = this.gwLegajos.DataKeys[index].Values[1].ToString();
                btnModificar.Enabled = true;

            }
        }

        protected void gwLegajos_SelectedIndexChanged(object sender, EventArgs e)
        {
         
            GridViewRow row = gwLegajos.SelectedRow;
          
            Panel5.Visible = true;
            //Panel6.Visible = true;
            Cargar_Foto();
            lblLegajo.Text = row.Cells[1].Text;
            lblEmpleado.Text = row.Cells[2].Text;
            lblEstado.Text = row.Cells[6].Text;

           if (row.Cells[6].Text == "Activo")
           {
               lblEstado.ForeColor = Color.Green;
           }
           else
           {
               if (row.Cells[6].Text == "Suspendido")
               {
                   lblEstado.ForeColor = Color.Orange;
 
               }
               else
               {
                   lblEstado.ForeColor = Color.Red;
               }
           }
           gwLegajos.Visible = false;

        }

        protected void gwLegajos_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                e.Row.Attributes.Add("onMouseOver", "this.style.background='#f2d9d9';this.style.cursor='pointer'");

                e.Row.Attributes.Add("onMouseOut", "this.style.background='#ffffff'");


                e.Row.Attributes["onClick"] = ClientScript.GetPostBackClientHyperlink(this.gwLegajos, "Select$" + e.Row.RowIndex);
                e.Row.ToolTip = "Haga Click para Seleccionar la línea.";

            }
        }

        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            gwLegajos.Visible = true;
            Panel5.Visible = false;
            //Panel6.Visible = false;
            Panel9.Visible = false;
            this.CargarGrilla(gwLegajos, "dbo.SP_TraerGrillaEmpleados");

        }

      

        protected void btnFoto_Click(object sender, EventArgs e)
        {
             HiddenFieldError_ModalPopupExtender.Show();

        }

        protected void gwCertificados_RowCommand(object sender, GridViewCommandEventArgs e)
        {
            if (e.CommandName == "Select")
            {

                int index = Convert.ToInt32(e.CommandArgument);


                Session["IDIMAGEN"] = this.gwCertificados.DataKeys[index].Values[0].ToString();
                btnAgregar.Enabled = true;

            }
           
        }

        protected void gwCertificados_SelectedIndexChanged(object sender, EventArgs e)
        {
            GridViewRow row = gwCertificados.SelectedRow;

            string str;
            str = "window.open('RRHH_Imagenes.aspx','Titulo','width=500,height=500,sc rollbars=no,resizable=no')";
            Response.Write("<script languaje=javascript>" + str + "</script>");


            //gwCertificados.Visible = false;
        }

        protected void gwCertificados_RowDataBound(object sender, GridViewRowEventArgs e)
        {
           
        }

        protected void btnAusencias_Click(object sender, EventArgs e)
        {
            Panel9.Visible = true;
            this.CargarGrillaAusencias(gwCertificados, "dbo.SP_Traer_ImagenLegajo2");
            Session["Cert"] = "2";
            lblCertificados.Text = "Certificados de Ausencias";
        }

        protected void btnEstudio_Click(object sender, EventArgs e)
        {
            Panel9.Visible = true;
            this.CargarGrillaEstudios(gwCertificados, "dbo.SP_Traer_ImagenLegajo3");
            Session["Cert"] = "3";
            lblCertificados.Text = "Certificados de Estudios";


        }

        protected void btnSanciones_Click(object sender, EventArgs e)
        {
            Panel9.Visible = true;
            this.CargarGrillaSanciones(gwCertificados, "dbo.SP_Traer_ImagenLegajo4");
            Session["Cert"] = "4";
            lblCertificados.Text = "Certificados de Sanciones";


        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
            byte[] imagen;
            string strFileName;
            string strFolder;
            string strExtension;
            strFolder = Server.MapPath("./");
            if (!String.IsNullOrEmpty(fuImagen.ToString()))
            {
                strFileName = fuICertificado.PostedFile.FileName;
                strFileName = Path.GetFileName(strFileName);
                strExtension = Path.GetExtension(strFileName);
               

                if (!ValidarExtension(strExtension))
                {
                    this.LabelErr.Text = "El Archivo Seleccionado no es una Imagen";
                    HiddenFieldError0_ModalPopupExtender.Show();
                    return;
                }
                else
                {
                    using (BinaryReader reader = new BinaryReader(fuICertificado.PostedFile.InputStream))
                    {
                        imagen = reader.ReadBytes(fuICertificado.PostedFile.ContentLength);
                        Session["imgInc"] = imagen;
                        Session["NombreArchivo"] = strFileName;

                    }
                }
                this.ActualizaCertificado("dbo.SP_InsertarImagenCertificado");
                //btnAgregar.Enabled = false;
                
            }
            if (Session["Cert"].ToString() == "2")
            {
                this.CargarGrillaAusencias(gwCertificados, "dbo.SP_Traer_ImagenLegajo2");
            }
            else
            {
                if (Session["Cert"].ToString() == "3")
                    this.CargarGrillaEstudios(gwCertificados, "dbo.SP_Traer_ImagenLegajo3");
                else
                {
                    this.CargarGrillaSanciones(gwCertificados, "dbo.SP_Traer_ImagenLegajo4");
                }
            }
           
        }

        protected void gwCertificados_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            Response.Write("<script>window.confirm('Esta Seguro de Eliminar la Imagen');</script>");
            
            
            int index = Convert.ToInt32(e.RowIndex);

            

            Session["IDIMAGEN"] = this.gwCertificados.DataKeys[index].Values[0].ToString();
            this.EliminarCertificado("SP_EliminarImagenesLegajo");
            if (Session["Cert"].ToString() == "2")
            {
                this.CargarGrillaAusencias(gwCertificados, "dbo.SP_Traer_ImagenLegajo2");
            }
            else
            {
                if (Session["Cert"].ToString() == "3")
                    this.CargarGrillaEstudios(gwCertificados, "dbo.SP_Traer_ImagenLegajo3");
                else
                {
                    this.CargarGrillaSanciones(gwCertificados, "dbo.SP_Traer_ImagenLegajo4");
                }
            }


           

        }

       
    }

       
}
