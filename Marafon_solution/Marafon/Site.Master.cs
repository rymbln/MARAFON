using System;
using System.Data;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using System.Web.Security;

namespace Marafon
{
    public partial class SiteMaster : System.Web.UI.MasterPage
    {
        private void BuildMenuLevel(string strConnectionStringName, string strRoleName, int strParentItemID = 0, int intParentItemIndex = 0)
        {
            try
            {
                string menuText;
                int menuValue;
                string menuImageURL;
                string menuNavigationURL;
                MenuItem miCurrent;

                //if(intParentItemIndex == 0)
                //{
                //    NavigationMenu.Items.Clear();
                //}

                string connStr = ConfigurationManager.ConnectionStrings[strConnectionStringName].ConnectionString;
                SqlDataAdapter cmd1;
                cmd1 = new SqlDataAdapter(string.Format("select role_menu_id, item_text, item_navigate_url, item_image_url from role_menu where isnull(parent_item,0)={0} and role_name='{1}' order by menu_order", strParentItemID, strRoleName), connStr);
                DataSet ds = new DataSet();
                cmd1.Fill(ds, "MenuItems");
                DataTable dt = ds.Tables["MenuItems"];

                foreach (DataRow dr in dt.Rows)
                {
                    menuText = string.Format("{0:c}", dr["item_text"]);
                    menuValue = int.Parse(dr["role_menu_id"].ToString());
                    menuImageURL = string.Format("{0:c}", dr["item_image_url"]); ;
                    menuNavigationURL = string.Format("{0:c}", dr["item_navigate_url"]); ;
                    miCurrent = new MenuItem(menuText, menuValue.ToString(), menuImageURL, menuNavigationURL);

                    if (intParentItemIndex == 0)
                    {
                        NavigationMenu.Items.Add(miCurrent);
                    }
                    else
                    {
                        NavigationMenu.Items[intParentItemIndex].ChildItems.Add(miCurrent);
                    }
                    BuildMenuLevel(strConnectionStringName, strRoleName, menuValue, NavigationMenu.Items.IndexOf(miCurrent));
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;

            try
            {


                
                if (Session["ROLE_NAME"] != null)
                {
                    string strPageName = this.Page.AppRelativeVirtualPath.Trim()/*.Substring(this.Page.AppRelativeVirtualPath.IndexOf("/") + 1)*/;
                    int i = strPageName.IndexOf("?");
                    if(i > 0)
                    {
                        strPageName = strPageName.Remove(i);
                    }
                    
                    if (strPageName.IndexOf("Error.aspx")<=0)
                    {
                        cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                        cnnValues.Open();
                        cmdValues = new SqlCommand(String.Format("select role_menu_id from role_menu where role_name='{0}' and item_navigate_url like '%{1}%'", (Session["ROLE_NAME"] as string), strPageName), cnnValues);
                        rdValues = cmdValues.ExecuteReader();
                        int intID = 0;
                        if (rdValues.HasRows)
                        {
                            while (rdValues.Read())
                            {
                                intID = rdValues.GetInt32(0);
                            }
                            if (intID > 0)
                            {
                                BuildMenuLevel("MarafonConnection", string.Format("{0:c}", Roles.GetRolesForUser()), 0, 0);
                            }
                            else
                            {
                                throw new Exception("Отказано в доступе!");
                            }
                        }
                        else
                        {
                            //redirect to login.aspx
                           // Response.Redirect("~/Account/Login.aspx", true);
                            throw new Exception("Нет связи с базой данных!");
                        }
                    }
                }
                else
                {
                    //redirect to login.aspx
                   // Response.Redirect("~/Account/Login.aspx", true);
                    throw new Exception("Время ожидания истекло!");
                }
                    
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
            finally
            {
                if (rdValues != null)
                {
                    rdValues.Close();
                    rdValues = null;
                }
                if (cmdValues != null)
                {
                    cmdValues.Dispose();
                    cmdValues = null;
                }
                if (cnnValues != null)
                {
                    cnnValues.Close();
                    cnnValues = null;
                }
            }
        }
    }
}


