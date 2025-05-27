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
using System.Drawing;

namespace SintecromNet.Paginas
{
    public partial class SC_PendientesPesada_Back
        : System.Web.UI.Page
    {        
            public decimal dTotalR;
            public decimal dTotal1;
            public decimal dTotal2;
            public decimal dTotal3;
            public decimal dTotal4;
            public decimal dTotal;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";           
           

            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_SUPPLYCHAIN")
                {

                    Session["Accede"] = "OK";


                }

            }
            if (Session["Accede"].ToString() == "NO")
            {
                Response.Redirect("Restringida.aspx");

            }

            this.TraerPendientesPesada("dbo.SP_I_TraerPendientesPesadaTotales");
        }

     
      
        private void TraerPendientesPesada(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
            DataSet unDS = null;


            try
            {

                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored));
                
                //Cargo el Chart con la lista de los usuarios con rol
                Chart1.DataSource = unDS;
                Chart1.Series["Series1"].XValueMember = "Cliente";
                Chart1.Series["Series1"].YValueMembers = "Retraso";
                Chart1.Series["Series2"].YValueMembers = "Semana1";
                Chart1.Series["Series3"].YValueMembers = "Semana2";
                Chart1.Series["Series4"].YValueMembers = "Semana3";
                Chart1.Series["Series5"].YValueMembers = "Semana4";

                Chart1.DataBind();

                gwPendientesPesada.DataSource = unDS;
                gwPendientesPesada.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }


        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

        protected void gwPendientesPesada_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Retraso").ToString()))
                {
                    dTotalR += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Retraso"));                   
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana1").ToString()))
                {
                    dTotal1 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana1"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana2").ToString()))
                {                    
                    dTotal2 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana2"));                   
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana3").ToString()))
                {                   
                    dTotal3 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana3"));                   
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Semana4").ToString()))
                {                   
                    dTotal4 += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Semana4"));
                }

                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Total").ToString()))
                {
                    dTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Total"));
                }

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.BackColor = Color.DarkRed;
                e.Row.ForeColor = Color.White;
                e.Row.Cells[0].Text = "Totales:";
                e.Row.Cells[0].HorizontalAlign = HorizontalAlign.Center; 
                e.Row.Cells[1].Text = dTotalR.ToString("0.00");
                e.Row.Cells[1].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[2].Text = dTotal1.ToString("0.00");
                e.Row.Cells[2].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[3].Text = dTotal2.ToString("0.00");
                e.Row.Cells[3].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[4].Text = dTotal3.ToString("0.00");
                e.Row.Cells[4].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[5].Text = dTotal4.ToString("0.00");
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
                e.Row.Cells[6].Text = dTotal.ToString("0.00");
                e.Row.Cells[6].HorizontalAlign = HorizontalAlign.Center;
 
               
                
            }   


        }
    }
}