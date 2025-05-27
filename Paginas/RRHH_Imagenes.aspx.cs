using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Data.SqlClient;


namespace SintecromNet.Paginas
{
    public partial class RRHH_Imagenes : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            byte[] img = null;
            int idI = Convert.ToInt16(Session["ID"]);
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
            DataSet unDs = null;
            SqlParameter[] unosParametros = null;
            try
            {
                unosParametros = new SqlParameter[1];

                unosParametros[0] = new SqlParameter("@Numero", System.Data.SqlDbType.Int);
                unosParametros[0].Value = Convert.ToInt16(Session["IDIMAGEN"]);
                unAcceso.AbrirConexion();
                unDs = unAcceso.ExecuteDataSet(new SqlCommand("dbo.SP_Traer_ImagenRRHH"), unosParametros);


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
                Response.ContentType = "image/jpeg";
                Response.Expires = 0;
                Response.Buffer = true;
                Response.Clear();
                Response.BinaryWrite(img);
                Response.End();
            }
            else
            {
                Image1.Visible = false;
                lblMensaje.Visible = true;
                lblMensaje.Text = "La Imagen No Puede ser Visualizada, Reintente";
            }
        }
       

       
           

        }

    
       
}


