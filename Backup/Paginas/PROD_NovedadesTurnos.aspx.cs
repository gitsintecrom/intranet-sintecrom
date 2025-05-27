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
using System.Drawing;
using System.Drawing.Imaging;


namespace SintecromNet.Paginas
{
    public partial class PROD_NovedadesTurnos : System.Web.UI.Page
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

                    if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_PRODUCCION")
                    {

                        Session["Accede"] = "OK";


                    }

                }
                if (Session["Accede"].ToString() == "NO")
                {
                    Response.Redirect("Restringida.aspx");

                }



            }
            
            
            
            lblFecha.Text = DateTime.Now.ToShortDateString();
            string sUsuario = Session["Usr"].ToString();
            sUsuario = Clases.Varias.RemoveSpecialCharacters(sUsuario);
            lblUsuario.Text = sUsuario.Replace("DOMINIO", "");
          
        }

        protected void btnAceptar_Click(object sender, EventArgs e)
        {  

           
            this.InsertarNovedades("dbo.SP_InsertarNovedadesTurnos");
            this.LabelErr.Text = "Las Novedades del turno han sido Ingresadas exitosamente";
            HiddenFieldError_ModalPopupExtender.Show();

            txtComentario.Text = ""; 
        }

        protected void Button2_Click1(object sender, EventArgs e)
        {
           
        }


        private void InsertarNovedades(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            SqlParameter[] unosParametros = null;           

            try
            {
               
                    unosParametros = new SqlParameter[3];

                    unosParametros[0] = new SqlParameter("@Turno", System.Data.SqlDbType.VarChar);
                    unosParametros[0].Value = DropDownList1.SelectedValue;

                    unosParametros[1] = new SqlParameter("@Usuario", System.Data.SqlDbType.VarChar);
                    unosParametros[1].Value = lblUsuario.Text;

                    unosParametros[2] = new SqlParameter("@Comentario", System.Data.SqlDbType.VarChar);
                    unosParametros[2].Value = txtComentario.Text;


                unAcceso.AbrirConexion();
                unAcceso.ExecuteNonQuerySP(new SqlCommand(nombreStored), unosParametros);

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }
      
       
      
        
    }
     
}