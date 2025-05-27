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
    public partial class SC_ParteDiario : System.Web.UI.Page
    {        
            
            public decimal dTotal;
            public decimal dTotalMO;
            public decimal dTotalCO;
            public decimal dTotalSC;
        
        protected void Page_Load(object sender, EventArgs e)
        {
            Session["Accede"] = "NO";           
           

            IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
            foreach (IdentityReference i in irc)
            {
                string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                if (group == "DOMINIOW_SISTEMAS" || group == "DOMINIOW_SUPPLYCHAIN" || group == "DOMINIOW_DIRECCION" || group == "DOMINIOW_ADMINISTRACION" || group == "DOMINIOW_VENTAS")
                {

                    Session["Accede"] = "OK";


                }

            }
            if (Session["Accede"].ToString() == "NO")
            {
                Response.Redirect("Restringida.aspx");
            }           
        }   
       


        protected void Button2_Click1(object sender, EventArgs e)
        {

        }

      
        private void TraerEgresos(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
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
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                gwParteDiario.DataSource = unDS;
                gwParteDiario.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerEgresosMO(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
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
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                gwParteDiario0.DataSource = unDS;
                gwParteDiario0.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerEgresosCO(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
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
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                gwParteDiario1.DataSource = unDS;
                gwParteDiario1.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }

        private void TraerEgresosSC(string nombreStored)
        {
            Clases.AccesoDatos unAcceso = new Clases.AccesoDatos("SintecromDesa");
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
                unosParametros = new SqlParameter[2];

                unosParametros[0] = new SqlParameter("@fechaDesde", System.Data.SqlDbType.VarChar);
                unosParametros[0].Value = FechaInicial;

                unosParametros[1] = new SqlParameter("@fechaHasta", System.Data.SqlDbType.VarChar);
                unosParametros[1].Value = FechaFinal;


                unAcceso.AbrirConexion();
                unDS = unAcceso.ExecuteDataSet(new SqlCommand(nombreStored), unosParametros);

                gwParteDiario2.DataSource = unDS;
                gwParteDiario2.DataBind();

            }
            finally
            {
                unAcceso.CerrarConexion();
            }
        }



        protected void ButtonVer_Click(object sender, EventArgs e)
        {
            this.TraerEgresos("dbo.SP_I_TraerParteDiario_RV");
            this.TraerEgresosMO("dbo.SP_I_TraerParteDiario_MO");
            this.TraerEgresosCO("dbo.SP_I_TraerParteDiario_CO");
            this.TraerEgresosSC("dbo.SP_I_TraerParteDiario_SC");
            
        }

        protected void gwParteDiario_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kgs").ToString()))
                {
                    dTotal += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kgs"));
                }
                
            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.BackColor = Color.Black;
                e.Row.ForeColor = Color.White;
                e.Row.Cells[4].Text = "Total Egresos:";

                e.Row.Cells[5].Text = dTotal.ToString("0.00");
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
            }
        }

        protected void gwParteDiario0_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kgs").ToString()))
                {
                    dTotalMO += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kgs"));
                }

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.BackColor = Color.Black;
                e.Row.ForeColor = Color.White;
                e.Row.Cells[4].Text = "Total Egresos Mano de Obra:";

                e.Row.Cells[5].Text = dTotalMO.ToString("0.00");
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
            }
        }

        protected void gwParteDiario1_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kgs").ToString()))
                {
                    dTotalCO += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kgs"));
                }

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.BackColor = Color.Black;
                e.Row.ForeColor = Color.White;
                e.Row.Cells[4].Text = "Total Egresos Consignados:";

                e.Row.Cells[5].Text = dTotalCO.ToString("0.00");
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
            }
        }

        protected void gwParteDiario2_RowDataBound(object sender, GridViewRowEventArgs e)
        {
            if (e.Row.RowType == DataControlRowType.DataRow)
            {
                if (!String.IsNullOrEmpty(DataBinder.Eval(e.Row.DataItem, "Kgs").ToString()))
                {
                    dTotalSC += Convert.ToDecimal(DataBinder.Eval(e.Row.DataItem, "Kgs"));
                }

            }
            if (e.Row.RowType == DataControlRowType.Footer)
            {
                e.Row.BackColor = Color.Black;
                e.Row.ForeColor = Color.White;
                e.Row.Cells[4].Text = "Total Egresos Scrap:";

                e.Row.Cells[5].Text = dTotalSC.ToString("0.00");
                e.Row.Cells[5].HorizontalAlign = HorizontalAlign.Center;
            }
        }
    }
}