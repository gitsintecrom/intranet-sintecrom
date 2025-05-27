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
using System.Net.Mail;
using System.Web.UI.HtmlControls;



namespace SintecromNet.Paginas
{
    public partial class CAL_GestionMuestras : System.Web.UI.Page
    {
        public string sAcceso { get; set; }
        public string sVendedor { get; set; }

        protected void Page_Load(object sender, EventArgs e)
        {
           if(Request.QueryString["Parametro"] != null)
            {
                sVendedor = Request.QueryString["Parametro"];
            }
            
            if (!IsPostBack)
            {
                sAcceso = "NO";

                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_VENTAS" || group == "DOMINIOW_CALIDAD"
                        || group == "DOMINIOW_VENDEDORES" || group == "DOMINIOW_GERENTES")
                    {

                        sAcceso = "OK";


                    }

                }
                if (sAcceso == "NO")
                {
                    Response.Redirect("Restringida.aspx");
                }
                else
                {
                    if(!String.IsNullOrEmpty(sVendedor))
                    {
                        ddVendedor.SelectedValue = sVendedor.ToString();
                        ddVendedor.Enabled = false;
                    }
                    CargarComboClientes();
                    CargarCombo();
                    CargarComboAleacion();
                    CargarComboTemple();
                    CargarComboEspesor();
                }
              
            }

        
        }
      

        protected void btnEjecutar_Click(object sender, EventArgs e)
        {

           
        this.InsertarDatos("dbo.SP_CAL_InsertarMuestrasTMP");
            EnviarEmail();

            LimpiarCampos();
            Response.Write("<script>window.confirm('La Solicitud de Muestra ha Sido Ingresada Exitosamente');</script>");

        }

        protected void Button1_Click(object sender, EventArgs e)
        {
            LimpiarCampos();
        }

        private void InsertarDatos(string nombreSP)
        {
            SqlParameter[] unosParametros = null;
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlCommand cmd = new SqlCommand(nombreSP);

            try
            {
                unosParametros = new SqlParameter[35];

                if(ddPotencial.SelectedValue == "No")
                {
                    unosParametros[0] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = ddClientes.SelectedItem.Text.ToString();
                }
                else
                {
                    unosParametros[0] = new SqlParameter("@Cliente", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = txtPotencial.Text.ToString();
                }                
                
                unosParametros[1] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = ddVendedor.SelectedItem.Text.ToString(); 

                unosParametros[2] = new SqlParameter("@Telefono", System.Data.SqlDbType.VarChar);
                unosParametros[2].Value = txtTelefono.Text.Trim();

                unosParametros[3] = new SqlParameter("@Email", System.Data.SqlDbType.VarChar);
                unosParametros[3].Value = txtEmail.Text.Trim();

                unosParametros[4] = new SqlParameter("@Transporte", System.Data.SqlDbType.VarChar);
                unosParametros[4].Value = txtTransporte.Text;

                unosParametros[5] = new SqlParameter("@FechaSolicitada", System.Data.SqlDbType.DateTime);
                unosParametros[5].Value = txtFechaSolicitada.Text;

                unosParametros[6] = new SqlParameter("@RequiereCertificado", System.Data.SqlDbType.VarChar);
                unosParametros[6].Value = ddlCertificado.SelectedValue;

                unosParametros[7] = new SqlParameter("@EmailCertificado", System.Data.SqlDbType.VarChar);
                unosParametros[7].Value = txtMailCertificado.Text.Trim();

                unosParametros[8] = new SqlParameter("@Material", System.Data.SqlDbType.VarChar);
                unosParametros[8].Value = ddFamilia.SelectedItem.Text.ToString();

                unosParametros[9] = new SqlParameter("@Serie", System.Data.SqlDbType.VarChar);
                unosParametros[9].Value = txtSerieSugerida.Text.Trim();

                unosParametros[10] = new SqlParameter("@Espesor", System.Data.SqlDbType.VarChar);
                unosParametros[10].Value = ddEspesor.SelectedValue;

                unosParametros[11] = new SqlParameter("@Ancho", System.Data.SqlDbType.VarChar);
                unosParametros[11].Value = txtAncho.Text.Trim();

                unosParametros[12] = new SqlParameter("@UnidadMedida", System.Data.SqlDbType.VarChar);
                unosParametros[12].Value = ddUnidadMedida.SelectedValue;

                unosParametros[13] = new SqlParameter("@Cantidad", System.Data.SqlDbType.Int);
                unosParametros[13].Value = txtCantidad.Text.Trim();

                unosParametros[14] = new SqlParameter("@Embalaje", System.Data.SqlDbType.VarChar);
                unosParametros[14].Value = txtEmbalaje.Text.Trim();

                unosParametros[15] = new SqlParameter("@Plegado", System.Data.SqlDbType.VarChar);
                unosParametros[15].Value = DropDownList1.SelectedValue;

                unosParametros[16] = new SqlParameter("@PlegadoDesc", System.Data.SqlDbType.VarChar);
                unosParametros[16].Value = txtPlegado.Text.Trim();

                unosParametros[17] = new SqlParameter("@Profundidad", System.Data.SqlDbType.VarChar);
                unosParametros[17].Value = DropDownList2.SelectedValue;

                unosParametros[18] = new SqlParameter("@ProfundidadDesc", System.Data.SqlDbType.VarChar);
                unosParametros[18].Value = txtProfundidad.Text.Trim();

                unosParametros[19] = new SqlParameter("@Pintado", System.Data.SqlDbType.VarChar);
                unosParametros[19].Value = DropDownList3.SelectedValue;

                unosParametros[20] = new SqlParameter("@PintadoDesc", System.Data.SqlDbType.VarChar);
                unosParametros[20].Value = txtPintado.Text.Trim();

                unosParametros[21] = new SqlParameter("@Anodizado", System.Data.SqlDbType.VarChar);
                unosParametros[21].Value = DropDownList4.SelectedValue;

                unosParametros[22] = new SqlParameter("@AnodizadoDesc", System.Data.SqlDbType.VarChar);
                unosParametros[22].Value = txtAnodizado.Text.Trim();

                unosParametros[23] = new SqlParameter("@Perforado", System.Data.SqlDbType.VarChar);
                unosParametros[23].Value = DropDownList5.SelectedValue;

                unosParametros[24] = new SqlParameter("@PerforadoDesc", System.Data.SqlDbType.VarChar);
                unosParametros[24].Value = txtPerforado.Text.Trim();

                unosParametros[25] = new SqlParameter("@Conformado", System.Data.SqlDbType.VarChar);
                unosParametros[25].Value = DropDownList6.SelectedValue;

                unosParametros[26] = new SqlParameter("@ConformadoDesc", System.Data.SqlDbType.VarChar);
                unosParametros[26].Value = txtConformado.Text.Trim();

                unosParametros[27] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                unosParametros[27].Value = Session["Usr"].ToString();

                unosParametros[28] = new SqlParameter("@Largo", System.Data.SqlDbType.VarChar);
                unosParametros[28].Value = txtLargo.Text.Trim();

                unosParametros[29] = new SqlParameter("@Comentarios", System.Data.SqlDbType.VarChar);
                unosParametros[29].Value = txtComentarios.Text.Trim();

                unosParametros[30] = new SqlParameter("@Domicilio", System.Data.SqlDbType.VarChar);
                unosParametros[30].Value = txtDomicilio.Text.Trim();

                unosParametros[31] = new SqlParameter("@Aleacion", System.Data.SqlDbType.VarChar);
                unosParametros[31].Value = ddAleacion.SelectedValue;

                unosParametros[32] = new SqlParameter("@Temple", System.Data.SqlDbType.VarChar);
                unosParametros[32].Value = ddTemple.SelectedValue;

                unosParametros[33] = new SqlParameter("@UsoFinal", System.Data.SqlDbType.VarChar);
                unosParametros[33].Value = txtUsoFinal.Text.Trim();

                unosParametros[34] = new SqlParameter("@Origen", System.Data.SqlDbType.VarChar);
                unosParametros[34].Value = txtOrigen.Text.Trim();

                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(cmd, unosParametros);
              
                
                
            }
            finally
            {
                unAcceso.CerrarConexion();

            }
        }



        private void LimpiarCampos()
        {
            ddPotencial.SelectedValue = "No";
            ddlCertificado.SelectedValue = "No";
            txtLargo.Text = "";
            ddClientes.SelectedValue = "";
            //ddVendedor.SelectedValue = "amilone";
            txtEmail.Text = "";
            ddEspesor.SelectedValue = "";
            ddTemple.SelectedValue = "";
            ddAleacion.SelectedValue = "";
            txtAncho.Text = "";
            txtAnodizado.Text = "";
            txtCantidad.Text = "0";
            txtConformado.Text = "";
            txtEmail.Text = "";
            txtEmbalaje.Text = "";
            txtFechaSolicitada.Text = "";
            txtMailCertificado.Text = "";
            txtPerforado.Text = "";
            txtPintado.Text = "";
            txtPlegado.Text = "";
            txtProfundidad.Text = "";
            txtSerieSugerida.Text = "";
            txtTelefono.Text = "";
            //txtUnidadMedida.Text = "";
            ddFamilia.SelectedValue = "";
            DropDownList1.SelectedValue = "No";
            DropDownList2.SelectedValue = "No";
            DropDownList3.SelectedValue = "No";
            DropDownList4.SelectedValue = "No";
            DropDownList5.SelectedValue = "No";
            ddlEntrega.SelectedValue = "No";
            ddPotencial.SelectedValue = "No";
            txtTransporte.Text = "";
            txtComentarios.Text = "";
            txtDomicilio.Text = "";

        }

        private void CargarCombo()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_TraerFamilias"));

                ddFamilia.DataSource = unDS;
                ddFamilia.DataValueField = "Codigo";
                ddFamilia.DataTextField = "Descripcion";
                ddFamilia.DataBind();
                ddFamilia.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboAleacion()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_CAL_TraerAleacion"));

                ddAleacion.DataSource = unDS;
                ddAleacion.DataValueField = "Codigo";
                ddAleacion.DataTextField = "Descripcion";
                ddAleacion.DataBind();
                ddAleacion.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboTemple()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_CAL_TraerTemple"));

                ddTemple.DataSource = unDS;
                ddTemple.DataValueField = "Codigo";
                ddTemple.DataTextField = "Descripcion";
                ddTemple.DataBind();
                ddTemple.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboEspesor()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");

            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_CAL_TraerEspesor"));

                ddEspesor.DataSource = unDS;
                ddEspesor.DataValueField = "Codigo";
                ddEspesor.DataTextField = "Descripcion";
                ddEspesor.DataBind();
                ddEspesor.Items.Insert(0, new ListItem("Seleccione...", ""));

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void CargarComboClientes()
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");          

            DataSet unDS = null;
            SqlParameter[] unosParametros = null;


            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Vendedor", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = sVendedor;

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_CAL_TraerComboClientes"), unosParametros);

                ddClientes.DataSource = unDS;
                ddClientes.DataValueField = "Codigo";
                ddClientes.DataTextField = "Denominacion";
                ddClientes.DataBind();
                ddClientes.Items.Insert(0, new ListItem("Seleccione...", ""));

                DataTable dt = unDS.Tables[0].Copy();
                Session["Cliente"] = dt;


            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        protected void Button2_Click(object sender, EventArgs e)
        {
           
         
          
        }

       
       
        private bool EnviarEmail()
        {

            MailMessage msg = new MailMessage();

            msg.To.Add("calidad@sintecrom.com.ar, programacion@sintecrom.com.ar");

            msg.From = new MailAddress("mail.sistemas.sintecrom@gmail.com", "Solicitud de Muestras", System.Text.Encoding.UTF8);

            msg.Subject = "Solicitud de Muestras";

            msg.SubjectEncoding = System.Text.Encoding.UTF8;

            if (ddClientes.SelectedValue == "" )
            {
                msg.Body = "Existe un Nueva Solicitud de Muestra Para Autorizar del Cliente: " + txtPotencial.Text;
            }
            else
            {
                msg.Body = "Existe un Nueva Solicitud de Muestra Para Autorizar del Cliente: " + ddClientes.SelectedItem.Text.ToString();
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
            client.Credentials = new System.Net.NetworkCredential("mail.sistemas.sintecrom@gmail.com", "ikufgkkbcffcuzsz");
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

        protected void ddClientes_SelectedIndexChanged(object sender, EventArgs e)
        {
            DataTable dtc = (DataTable)Session["Cliente"];
            foreach (DataRow row in dtc.Rows)
            {
                if (row["Codigo"].ToString() == ddClientes.SelectedValue.ToString())
                {
                    txtTelefono.Text = row["TELEFONO"].ToString();
                    txtEmail.Text = row["EMAIL"].ToString();
                }
            }
        }
    }

       
}
