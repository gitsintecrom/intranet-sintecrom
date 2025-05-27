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
using System.Xml;
using System.Web.Services.Protocols;





namespace SintecromNet.Paginas
{
    public partial class PRODUCTO_TraerCatalogoTernium : System.Web.UI.Page
    {


        //private ProductosWS.CatalogSoap _CatalogoWS;
        //private string _usuarioWS = "WL_SINTECR";
        //private string _passwordWS = "ADMSINTE";
        //List<ProductosWS.Product> _Producto = new List<ProductosWS.Product>();

        

        //List<svCatalogoTernium.Product> _Catalogo = new List<svCatalogoTernium.Product>();
        //public class AuthHeader : SoapHeader
        //{

        //    public string usuario = "WL_SINTECR";
        //    public string pass = "ADMSINTE";

        //}
        
        

        protected void Page_Load(object sender, EventArgs e)
        {


            
            
            
            //wsCatalogo.Authentication aut = new wsCatalogo.Authentication();
            //aut.userName = "WL_SINTECR";
            //aut.password = "ADMSINTE";

            //ProductosWS.GetCatalogRequest _catalogo = new ProductosWS.GetCatalogRequest();
            //ProductosWS.Authentication aut = new ProductosWS.Authentication();
            //aut.userName = _usuarioWS;
            //aut.password = _passwordWS;

           
        

           

            
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";


                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_COMPRAS") || group == ("DOMINIOW_CALIDAD"))
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

        protected void LinkButton1_Click(object sender, EventArgs e)
        {
           

        }

      

        //private void TraerGrilla(GridView unGrid, GridView dosGrid, string nombreStored)
        //{
        //    Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromNet");
        //    DataSet unDS = null;
        //    SqlParameter[] unosParametros = null;         
            

        //    try
        //    {
        //        unosParametros = new SqlParameter[13];
               
              
        //        unosParametros[0] = new SqlParameter("@Familia", System.Data.SqlDbType.VarChar);
        //        unosParametros[0].Value = txtFamilia.Text;

        //        unosParametros[1] = new SqlParameter("@Espesor", System.Data.SqlDbType.VarChar);
        //        unosParametros[1].Value = txtEspesor.Text;

        //        unosParametros[2] = new SqlParameter("@Aleacion", System.Data.SqlDbType.VarChar);
        //        unosParametros[2].Value = txtAleacion.Text;

        //        unosParametros[3] = new SqlParameter("@Temple", System.Data.SqlDbType.VarChar);
        //        unosParametros[3].Value = txtTemple.Text;

        //        unosParametros[4] = new SqlParameter("@Terminacion", System.Data.SqlDbType.VarChar);
        //        unosParametros[4].Value = txtTerminacion.Text;

        //        unosParametros[5] = new SqlParameter("@Recubrimiento", System.Data.SqlDbType.VarChar);
        //        unosParametros[5].Value = txtRecubrimiento.Text;

        //        unosParametros[6] = new SqlParameter("@Forma", System.Data.SqlDbType.VarChar);
        //        unosParametros[6].Value = txtForma.Text;

        //        unosParametros[7] = new SqlParameter("@Estado", System.Data.SqlDbType.VarChar);
        //        unosParametros[7].Value = DropDownList1.SelectedValue;

        //        unosParametros[8] = new SqlParameter("@Buje", System.Data.SqlDbType.VarChar);
        //        unosParametros[8].Value = txtBuje.Text;

        //        unosParametros[9] = new SqlParameter("@DiametroInterno", System.Data.SqlDbType.VarChar);
        //        unosParametros[9].Value = txtDiametroInterno.Text;

        //        unosParametros[10] = new SqlParameter("@Empalme", System.Data.SqlDbType.VarChar);
        //        unosParametros[10].Value = txtEmpalme.Text;

        //        unosParametros[11] = new SqlParameter("@TipoEmbalaje", System.Data.SqlDbType.VarChar);
        //        unosParametros[11].Value = DropDownList2.SelectedValue;

        //        unosParametros[12] = new SqlParameter("@CodigoEmbalaje", System.Data.SqlDbType.VarChar);
        //        unosParametros[12].Value = txtCodigoEmbalaje.Text;
               

               
        //        unAcceso.AbrirConexion();
        //        unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);
                

        //        unGrid.DataSource = unDS;

        //        unGrid.DataBind();

        //        dosGrid.DataSource = unDS;

        //        dosGrid.DataBind();
              

        //    }
        //    finally
        //    {
        //        unAcceso.CerrarConexion();
        //    }
        //}
      

      
     

      

    //    protected void LinkButton2_Click(object sender, EventArgs e)
    //    {
    //        GridView1.Visible = true;
    //        StringBuilder sb = new StringBuilder();
    //        StringWriter sw = new StringWriter(sb);
    //        HtmlTextWriter htw = new HtmlTextWriter(sw);
    //        Page page = new Page();
    //        HtmlForm form = new HtmlForm();

    //        GridView1.EnableViewState = false;
    //        page.EnableEventValidation = false;
    //        page.DesignerInitialize();
    //        page.Controls.Add(form);
    //        form.Controls.Add(GridView1);
    //        page.RenderControl(htw);

    //        Page.Response.Clear();
    //        Page.Response.Buffer = true;
    //        Page.Response.ContentType = "application/vnd.ms-excel";

    //        Page.Response.AddHeader("Content-Disposition", "attachment; filename= FichasTecnicas.xls");
    //        Page.Response.Charset = "UTF-8";
    //        Page.Response.ContentEncoding = Encoding.Default;
    //        Page.Response.Write(sb.ToString());
    //        Page.Response.End();
    //        GridView1.Visible = false;

    //    }

    //    protected void LinkButton1_Click(object sender, EventArgs e)
    //    {
    //        this.TraerGrilla(gwGrilla, GridView1, "dbo.SP_CAL_TraerFichaTecnica");
    //        LinkButton2.Visible = true;
    //    }

    }

       
}
