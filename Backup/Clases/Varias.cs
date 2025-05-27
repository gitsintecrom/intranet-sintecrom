using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Text;
using System.Data;
using System.Web.UI.WebControls;
using System.Net.Mail;




namespace SintecromNet.Clases
{
    public class Varias
    {
        public static string RemoveSpecialCharacters(string str)
        {
            StringBuilder sb = new StringBuilder();
            foreach (char c in str)
            {
                if ((c >= '0' && c <= '9') || (c >= 'A' && c <= 'Z') || (c >= 'a' && c <= 'z') || c == '.' || c == '_')
                {
                    sb.Append(c);
                }
            }
            return sb.ToString();
        }

        public static void ExportToSpreadsheet(DataTable table, string name)
        {
            HttpContext context = HttpContext.Current;
            context.Response.Clear();
            foreach (DataColumn column in table.Columns)
            {
                context.Response.Write(column.ColumnName + ";");
            }
            context.Response.Write(Environment.NewLine);
            foreach (DataRow row in table.Rows)
            {
                for (int i = 0; i < table.Columns.Count; i++)
                {
                    context.Response.Write(row[i].ToString().Replace(";", string.Empty) + ";");
                }
                context.Response.Write(Environment.NewLine);
            }
            context.Response.ContentType = "text/csv";
            context.Response.AppendHeader("Content-Disposition", "attachment; filename=" + name + ".csv");
            context.Response.End();
        }

        public static bool EnviarEmail()
        {

            MailMessage msg = new MailMessage();

            msg.To.Add("sistemas@sintecrom.com.ar");

            msg.From = new MailAddress("mail_sistemas@sintecrom.com.ar", "Mensaje enviado desde el Aplicativo Chequeo de Hornos", System.Text.Encoding.UTF8);

            msg.Subject = "Posible caída Aplicativo Hornos";

            msg.SubjectEncoding = System.Text.Encoding.UTF8;

            msg.Body = "Chequear el aplicativo de Hornos en Sintranet http://sintranet/index.php?id=507";

            msg.BodyEncoding = System.Text.Encoding.UTF8;

            msg.IsBodyHtml = false; //Si vas a enviar un correo con contenido html entonces cambia el valor a true
            //Aquí es donde se hace lo especial

            SmtpClient client = new SmtpClient();

            client.Credentials = new System.Net.NetworkCredential("mail_sistemas@sintecrom.com.ar", "Sinte1234");

            client.Port = 587;

            client.Host = "smtp.gmail.com";//Este es el smtp valido para Gmail

            client.EnableSsl = true; //Esto es para que vaya a través de SSL que es obligatorio con GMail

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

    }
       
}
