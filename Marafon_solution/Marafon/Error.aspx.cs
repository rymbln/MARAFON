using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Marafon
{
    public partial class Error : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            Exception ex;

            if ((Session["ErrorMessage"] != null) && (Session["ErrorMessage"].ToString() != ""))
            {
                ex = (Session["ErrorMessage"] as Exception);
                Session["ErrorMessage"] = null;
            }
            else
            {
                ex = this.Server.GetLastError();
            }
            if (ex != null)
            {
                lblError.Text = ex.ToString();
            }
            else
            {
                lblError.Text = "Неизвестная ошибка!";
            }
            //////if ((Session["ErrorMessage"] != null) && (Session["ErrorMessage"].ToString() != ""))
            //////{
            //////    lblError.Text = Session["ErrorMessage"].ToString();
            //////    Session["ErrorMessage"] = null;
            //////}
            //////else
            //////{
            //////    errCurrent = this.Server.GetLastError().Message;
            //////    if ((errCurrent != null) && (errCurrent != ""))
            //////    {
            //////        lblError.Text = errCurrent;
            //////    }
            //////    else
            //////    {
            //////        lblError.Text = "Неизвестная ошибка!";
            //////    }
            //////}
            //Response.Redirect("~/Error.aspx");
        }
    }
}