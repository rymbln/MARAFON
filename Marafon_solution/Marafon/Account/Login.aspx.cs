using System;
using System.Collections;
using System.Configuration;
using System.Data;
//using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;

namespace Marafon
{
    public partial class Login : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void MainLogin_LoggedIn(object sender, EventArgs e)
        {
            try
            {
                int crfCount = 0;
                int packStoreCount = 0;
                SqlDataSource1.SelectParameters["SUSER"].DefaultValue = MainLogin.UserName;
                IDataReader dr1 = (IDataReader)SqlDataSource1.Select(DataSourceSelectArguments.Empty);
                while (dr1.Read())
                {
                    packStoreCount = int.Parse(dr1["cnt"].ToString());
                }

                SqlDataSource2.SelectParameters["SUSER"].DefaultValue = MainLogin.UserName;
                IDataReader dr2 = (IDataReader)SqlDataSource2.Select(DataSourceSelectArguments.Empty);
                while (dr2.Read())
                {
                    crfCount = int.Parse(dr2["cnt"].ToString());
                }

                SqlDataSource3.SelectParameters["SUSER"].DefaultValue = MainLogin.UserName;
                IDataReader dr3 = (IDataReader)SqlDataSource3.Select(DataSourceSelectArguments.Empty);
                while (dr3.Read())
                {
                    Session["Center_ID"] = int.Parse(dr3["Center_ID"].ToString());
                }

                if ((crfCount > 5) || (packStoreCount > 5))
                {
                    MainLogin.DestinationPageUrl = "~/Contacts.aspx";
                }
                else
                {
                    MainLogin.DestinationPageUrl = "~/Contacts.aspx";
                }
                Session["uid"] = MainLogin.UserName;
                Session["ROLE_NAME"] = Roles.GetRolesForUser(Session["uid"].ToString())[0];
                if (Roles.IsUserInRole(Session["uid"].ToString(), "Administrator"))
                {
                    Session["is_admin"] = 1;
                }
                else
                {
                    Session["is_admin"] = 0;
                }
                //Response.Redirect(MainLogin.DestinationPageUrl,true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }
    }
}
