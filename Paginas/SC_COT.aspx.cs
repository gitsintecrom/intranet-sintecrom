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
using System.Xml.Linq;
using System.Xml.XPath;


namespace SintecromNet.Paginas
{
    public partial class SC_COT : System.Web.UI.Page
    {
       

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                Session["Accede"] = "NO";
                Session["Accion"] = "";
              

                IdentityReferenceCollection irc = WindowsIdentity.GetCurrent().Groups;
                foreach (IdentityReference i in irc)
                {
                    string group = Clases.Varias.RemoveSpecialCharacters(i.Translate(typeof(NTAccount)).ToString());

                    //if (group == "DOMINIOW_SISTEMAS" || group == ("DOMINIOW_GERENTES") || group == ("DOMINIOW_SUPPLYCHAIN"))
                    if (group == "DOMINIOW_SISTEMAS")
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

      




        private void ObtenerRespuesta()
        {
            //Creamos un documento y lo cargamos con los datos del XML.
            string sXml = Session["sXml"].ToString();

            XElement xmldoc = XElement.Parse(sXml);

           // XElement query = (from item in xmldoc.XPathSelectElements("./personas/persona")
                              //where item.Element("nombre").Value == "Paola"
                              //select item).FirstOrDefault();

            //txtEdad.Text = Convert.ToString(query.Element("edad").Value);

            //XmlDocument documento = new XmlDocument();
            //documento.Load(Session["sXml"].ToString());

            //Obtenemos una colección con todos los empleados.
            //XmlNodeList listaEmpleados = documento.SelectNodes("empleados/empleado");

            //Creamos un único empleado.
            //XmlNode unEmpleado;

            ////Recorremos toda la lista de empleados.
            //for (int i = 0; i < listaEmpleados.Count; i++)
            //{
            //    //Obtenemos cada empleado.
            //    unEmpleado = listaEmpleados.Item(i);

            //    //Seleccionamos el id del empleado.
            //    int idEmpleado = Convert.ToInt32(unEmpleado.SelectSingleNode("idEmpleado").InnerText);

            //    //Comprobamos que el id de empleado sea el mismo que el número introducido por el usuario.
            //    if (numEmpleado == idEmpleado)
            //    {
            //        Console.WriteLine();

            //        //Obtenemos el nombre.
            //        Console.WriteLine("Nombre: {0}", unEmpleado.SelectSingleNode("nombre").InnerText);

            //        //Obtenemos los apellidos.
            //        Console.WriteLine("Apellidos: {0}", unEmpleado.SelectSingleNode("apellidos").InnerText);

            //        //Obtenemos el número de la seguridad social.
            //        Console.WriteLine("N.S.S.: {0}", unEmpleado.SelectSingleNode("numeroSS").InnerText);

            //        //Obtenemos la lista de telefonos.
            //        XmlNodeList telefonos = unEmpleado.SelectSingleNode("telefonos").ChildNodes;

            //        //Obtenemos el teléfono fijo y movil.
            //        XmlNode tlfFijo = telefonos[0];
            //        XmlNode tlfMovil = telefonos[1];

            //        Console.WriteLine("Teléfono fijo: {0}", tlfFijo.InnerText);
            //        Console.WriteLine("Teléfono movil: {0}", tlfMovil.InnerText);
                //}
            //}
        }

        private Boolean ValidarCertificado(object sender, System.Security.Cryptography.X509Certificates.X509Certificate certificate, System.Security.Cryptography.X509Certificates.X509Chain chain, System.Net.Security.SslPolicyErrors sslPolicyErrors)
        {
            return true;
        }

     


        protected void btnAgregar_Click2(object sender, EventArgs e)
        {
            //string strFileName;
            //string sPath;
            //strFileName = fuCOT.PostedFile.FileName;
            //strFileName = Path.GetFileName(strFileName);
            //sPath = "\\\\sinte2\\publica\\COT\\";
            string sRutaCompleta = "";

            string strFileName; string strFilePath;
            string strFolder;
            strFolder = Server.MapPath("./");

            // Retrieve the name of the file that is posted.

            //strFileName = oFile.PostedFile.FileName;
            //strFileName = Path.GetFileName(strFileName);
            //sRutaCompleta = strFolder + strFileName;



            if (File.Exists(sRutaCompleta))
            {


                //byte[] bArchivo = null;

                //string sUrl = "https://cot.test.arba.gov.ar/TransporteBienes/SeguridadCliente/presentarRemitos.do?user=30504408473&password=673642&file=";
                string sUrl = "https://cot.test.arba.gov.ar/TransporteBienes/SeguridadCliente/presentarRemitos.do";
                //bArchivo = File.ReadAllBytes(sRutaCompleta);

                 
                //Para poder obtener respuesta de una página No Segura
                System.Net.ServicePointManager.ServerCertificateValidationCallback = new System.Net.Security.RemoteCertificateValidationCallback(ValidarCertificado);

                //Clases.RemoteUpload Sube = new Clases.RemoteUpload(bArchivo, sRutaCompleta, sUrl);

                //leerPaginaWeb(sUrl + sRutaCompleta);
                leerPaginaWeb(sUrl);
                //leerResultado(sUrl + sRutaCompleta);

                string strHTML = GetHTMLFromURL(sUrl);
            }
           
        }

        //public interface IPostBackEventHandler
        //{
        //    void RaisePostBackEvent(string eventArgument);
        //}

        protected void btnEditClienteX_Click(object sender, EventArgs e)
        {
            //Acciones
            leerPaginaWeb("https://cot.test.arba.gov.ar/TransporteBienes/SeguridadCliente/presentarRemitos.do"); 
        }
        protected void btnSalir_Click(object sender, EventArgs e)
        {

        }

        

        private void leerPaginaWeb(string laUrl)
        {
            // Cear la solicitud de la URL.
            WebRequest request = WebRequest.Create(laUrl);

            

            // Obtener la respuesta.
            WebResponse response = request.GetResponse();

            // Abrir el stream de la respuesta recibida.
            StreamReader reader =
                new StreamReader(response.GetResponseStream());

            // Leer el contenido.
            string res = reader.ReadToEnd();
            Session["sXml"] = Clases.Varias.RemoveSpecialCharacters(res);

            // Mostrarlo.
            //Console.WriteLine(res);

            // Cerrar los streams abiertos.
            reader.Close();
            response.Close();
        }

      
      

        private void leerResultado(string laUrl)
        {
            String URLString = laUrl;

            XmlTextReader reader = new XmlTextReader(URLString);
            while (reader.Read())
            {
                switch (reader.NodeType)
                {
                    case XmlNodeType.Element: // El nodo es un elemento.
                        Console.Write("<" + reader.Name);

                        while (reader.MoveToNextAttribute()) // Lee los atributos.
                            Console.Write(" " + reader.Name + "='" + reader.Value + "'");
                        Console.Write(">");
                        Console.WriteLine(">");
                        break;
                    case XmlNodeType.Text: //Muestra el texto en cada elemento.
                        Console.WriteLine(reader.Value);
                        break;
                    case XmlNodeType.EndElement: //Muestra el final del elemento.
                        Console.Write("</" + reader.Name);
                        Console.WriteLine(">");
                        break;
                }
            }
        }

        protected void btnEditClienteX_Click1(object sender, EventArgs e)
        {

        }


        public string GetHTMLFromURL(string URL)
        {
            System.Text.ASCIIEncoding ASCII = new System.Text.ASCIIEncoding();
            System.Net.WebClient netWeb = new System.Net.WebClient();
            string lsWeb = null;
            byte[] laWeb = null;
            try
            {
                laWeb = netWeb.DownloadData(URL);
                lsWeb = ASCII.GetString(laWeb);
            }
            catch (Exception ex)
            {
                //throw new Exception(ex);
            }
            return lsWeb;
        }

        protected void btnImportar_Click(object sender, EventArgs e)
        {
            //this.GetHTMLFromURL("https://cot.test.arba.gov.ar/TransporteBienes/SeguridadCliente/presentarRemitos.do");
        }

        protected void btnAgregar_Click(object sender, EventArgs e)
        {
           //form1.Action = "https://cot.test.arba.gov.ar/TransporteBienes/SeguridadCliente/presentarRemitos.do";
            //string Url = "https://cot.test.arba.gov.ar/TransporteBienes/SeguridadCliente/presentarRemitos.do";
            //string formId = "form1";

            //StringBuilder htmlForm = new StringBuilder();
            //htmlForm.AppendLine("<html>");
            //htmlForm.AppendLine(String.Format("<body onload='document.forms[\"{0}\"].submit()'>", formId));
            //htmlForm.AppendLine(String.Format("<form id='{0}' method='POST' action='{1}'>", formId, Url));
            //htmlForm.AppendLine("<input type='text' name='user' value='30504408473' />");
            //htmlForm.AppendLine("<input type='password' name='password' value='673642' />");
            //htmlForm.AppendLine("<input type='file' name='file' value='\\\\sinte2\\sistemas\\0-Proyectos\\Intranet\\SintecromNet\\PaginasTB_30504408473_000000_20171019_000013.TXT' />");
            //htmlForm.AppendLine("</form>");
            //htmlForm.AppendLine("</body>");
            //htmlForm.AppendLine("</html>");


           //HttpContext.Current.Response.Clear();
           //HttpContext.Current.Response.Write(htmlForm.ToString());
           //HttpContext.Current.Response.End();   
        }

        protected void btnAgregar_Click1(object sender, EventArgs e)
        {

        }

        protected void btnImportar_Click1(object sender, EventArgs e)
        {

        }

        protected void btnAgregar_Click3(object sender, EventArgs e)
        {
            System.Net.ServicePointManager.ServerCertificateValidationCallback = new System.Net.Security.RemoteCertificateValidationCallback(ValidarCertificado);
            
            form1.Action = "https://cot.test.arba.gov.ar/TransporteBienes/SeguridadCliente/presentarRemitos.do";
            Page.ClientScript.RegisterStartupScript(this.GetType(), "submit", "javascript:document.form1.submit()", true);
        }

      

     

    }

       
}
