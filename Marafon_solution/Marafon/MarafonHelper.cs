using System;
using System.Collections;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Xml.Linq;
using System.Web.SessionState;
using System.Data.SqlClient;

namespace Marafon
{
    [Serializable] public class MarafonHelper
    {
        public static void HandleError(Page p, Exception ex)
        {
            ////p.Session["ErrorMessage"] = ex.Message;
            //////p.Response.Redirect("~/Error.aspx");
            try
            {
                if (ex != null)
                {
                    //Записываем непосредственно исключение, вызвавшее данное, в
                    //Session для дальнейшего использования
                    p.Session["ErrorMessage"] = ex;
                }

                // Обнуление ошибки на сервере
                p.Server.ClearError();

                // Перенаправление на свою страницу отображения ошибки
                p.Response.Redirect("~/Error.aspx");
            }
            catch (Exception)
            {
                // если мы всёже приходим сюда - значит обработка исключения 
                // сама сгенерировала исключение, мы ничего не делаем, чтобы
                // не создать бесконечный цикл
                p.Response.Write("К сожалению произошла критическая ошибка. Нажмите кнопку 'Назад' в браузере и попробуйте ещё раз. ");
            }
        }
        public static void HandleError(MasterPage p, Exception ex)
        {
            ////p.Session["ErrorMessage"] = ex.Message;
            //////p.Response.Redirect("Error.aspx");

            try
            {
                if (ex != null)
                {
                    //Записываем непосредственно исключение, вызвавшее данное, в
                    //Session для дальнейшего использования
                    p.Session["ErrorMessage"] = ex;
                }

                // Обнуление ошибки на сервере
                p.Server.ClearError();

                // Перенаправление на свою страницу отображения ошибки
                p.Response.Redirect("~/Error.aspx");
            }
            catch (Exception)
            {
                // если мы всёже приходим сюда - значит обработка исключения 
                // сама сгенерировала исключение, мы ничего не делаем, чтобы
                // не создать бесконечный цикл
                p.Response.Write("К сожалению произошла критическая ошибка. Нажмите кнопку 'Назад' в браузере и попробуйте ещё раз. ");
            }
        }

        public static void ClientMsgBox(Label lblMessage, string strMessage)
        {
            lblMessage.Text = strMessage;
        }

        public static T RecursiveFindControl<T>(Control container, string name) where T : Control
        {
            T found = null;
            found = container as T;
            if ((found.ID != null) && (found.ID.Equals(name)))
                return found;

            foreach (T ctrl in container.Controls)
            {
                //found = ctrl as T;
                found = RecursiveFindControl<T>(ctrl, name);
                if (found != null)
                    return found;
            }
            return null;
        }

        public static Control RecursiveFindParent(Control ctrlSource, Type tpParent)
        {
            Control found = ctrlSource;
            if (found != null)
            {
                if (found.GetType() != tpParent)
                {
                    found = RecursiveFindParent(found.NamingContainer, tpParent);
                    return found;
                }
                else
                {
                    return found;
                }
            }
            else
            {
                return null;
            }
        }

        public static void GridViewsDataBound(Control container, string name)
        {
            Control found = container;
            if ((found.ID != null) && (found.ID != name) && (found.GetType() == typeof(GridView)))
            {
                (found as GridView).DataBind();
            }
            else
            {
                foreach (Control ctrl in container.Controls)
                {
                    GridViewsDataBound(ctrl, name);
                }
            }
        }

        //private Control RecursiveFindControl(Control root, string id)
        //    {
        //        if (root.ID == id)
        //        {
        //            return root;
        //        }
        //        foreach (Control c in root.Controls)
        //        {
        //            Control t = RecursiveFindControl(c, id);
        //            if (t != null)
        //            {
        //                return t;
        //            }
        //        }
        //        return null;
        //    }

        public static bool CheckEditMode(GridView gvwSource, Label lblMessage, SqlDataSource dsrcSource, string strFilter)
        {
            if (gvwSource.EditIndex >= 0)
            {
                ClientMsgBox(lblMessage, "Сохраните или отмените изменения!");
                return true;
            }
            else
            {
                dsrcSource.FilterExpression = strFilter;
                dsrcSource.DataBind();
                gvwSource.DataBind();
                return false;
            }
        }
        public static bool CheckEditMode(GridView gvwSource, Label lblMessage, GridViewEditEventArgs e)
        {
            if (gvwSource.EditIndex >= 0)
            {
                e.Cancel = true;
                ClientMsgBox(lblMessage, "Сохраните или отмените изменения!");
                return true;
            }
            else
            {
                return false;
            }
        }

        public static int AddRecord(GridView gvwSource, string strConnectionName, string strTableName, string strFields, string strValues, string strIDName)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings[strConnectionName].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("INSERT INTO dbo.{0}({1}) VALUES({2})\n\r SELECT CAST(IDENT_CURRENT('dbo.{0}') AS INT)", strTableName, strFields, strValues), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    int intID = 0;
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            intID = rdValues.GetInt32(0);
                        }
                        //int intPageIndex = gvwSource.PageCount-1;
                        (gvwSource.DataSourceObject as SqlDataSource).FilterExpression = "";
                        gvwSource.Sort(strIDName, SortDirection.Ascending);
                        gvwSource.DataBind();
                        if ((gvwSource.PageIndex != gvwSource.PageCount - 1) && (gvwSource.PageCount > 0))
                        {
                            gvwSource.PageIndex = gvwSource.PageCount - 1;
                            gvwSource.DataBind();
                        }
                        gvwSource.SelectedIndex = gvwSource.Rows.Count - 1;
                        gvwSource.DataBind();
                        gvwSource.EditIndex = gvwSource.Rows.Count - 1;
                        gvwSource.SelectedIndex = gvwSource.EditIndex;
                    }
                    return intID;
            }
            finally
            {
                if (rdValues!=null)
                {
                    rdValues.Close();
                    rdValues = null;
                }
                if (cmdValues!=null)
                {
                    cmdValues.Dispose();
                    cmdValues = null;
                }
                if (cnnValues!=null)
                {
                    cnnValues.Close();
                    cnnValues = null;
                }
            }
        }


        public static int AddRecord(GridView gvwSource, DetailsView dvwSource, string strConnectionName, string strTableName, string strFields, string strValues, string strIDName, out bool boolRequery)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings[strConnectionName].ConnectionString);
                cnnValues.Open();
                cmdValues = new SqlCommand(String.Format("INSERT INTO dbo.{0}({1}) VALUES({2})\n\r SELECT CAST(IDENT_CURRENT('dbo.{0}') AS INT)", strTableName, strFields, strValues), cnnValues);
                rdValues = cmdValues.ExecuteReader();
                int intID = 0;
                boolRequery = true;
                if (rdValues.HasRows)
                {
                    while (rdValues.Read())
                    {
                        intID = rdValues.GetInt32(0);
                    }
                    //int intPageIndex = gvwSource.PageCount-1;
                    (gvwSource.DataSourceObject as SqlDataSource).FilterExpression = "";
                    gvwSource.Sort(strIDName, SortDirection.Ascending);
                    gvwSource.DataBind();
                    //gvwSource.PageIndex = gvwSource.PageCount - 1;
                    //gvwSource.SelectedIndex = gvwSource.Rows.Count - 1;
                    //gvwSource.DataBind();
                    ////(dvwSource.DataSourceObject as SqlDataSource).DataBind();
                    //dvwSource.DataBind();
                    //dvwSource.ChangeMode(DetailsViewMode.Edit);
                    if ((gvwSource.PageIndex != gvwSource.PageCount - 1) && (gvwSource.PageCount > 0))
                    {
                        gvwSource.PageIndex = gvwSource.PageCount - 1;
                        gvwSource.DataBind();
                    }
                    gvwSource.SelectedIndex = gvwSource.Rows.Count - 1;
                    gvwSource.DataBind();
                    //dvwSource.DataBind();
                    //dvwSource.ChangeMode(DetailsViewMode.Edit);
                    //dvwSource.DataBind();


                }
                return intID;
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


        public static int DelRecord(string strConnectionName, string strTableName, string strIDName, object objIDValue, string strUserName)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            try
            {
                if (objIDValue != null && (int)objIDValue > 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings[strConnectionName].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("DELETE FROM dbo.{0} WHERE {1}={2}", strTableName, strIDName, objIDValue.ToString()), cnnValues);
                    cmdValues.ExecuteNonQuery();
                    cmdValues = new SqlCommand(String.Format("UPDATE {0}_archive SET SUSER='{3}' WHERE {1}={2} AND ACTION_TYPE=1", strTableName, strIDName, objIDValue.ToString(), strUserName), cnnValues);
                    cmdValues.ExecuteNonQuery();
                }
                return 0;
            }
            finally
            {
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

        public static void RefreshGridViews(Control sender)
        {
            GridView gvwSource = (RecursiveFindParent(sender, typeof(GridView)) as GridView);
            if (gvwSource != null)
            {
                string strGridViewName = gvwSource.ID;
                Control ctrl = RecursiveFindParent(gvwSource, typeof(ContentPlaceHolder));
                GridViewsDataBound(ctrl, strGridViewName);
            }
        }

        public static void RefreshGridViews(object sender)
        {
            Control ctrl = RecursiveFindParent((sender as Control), typeof(ContentPlaceHolder));
            GridViewsDataBound(ctrl, "");
        }

        public static string GetValidatorFunctionJS(string strFunctionName, string strOperation, DateTime dtDate)
        {
            string strResult="<script language = 'javascript'>";
            strResult += "function " + strFunctionName + "(source, args)\n\r";
            strResult += "{\n\r";
            strResult += "    if (args.Value == null) \n\r";
            strResult += "    {\n\r";
            strResult += "        args.IsValid = true;\n\r";
            strResult += "        return true;\n\r";
            strResult += "    }\n\r";

            strResult += "    var arrDate = args.Value.split('.');\n\r";
            strResult += "    var strDate = arrDate[1] + '/' + arrDate[0] + '/' + arrDate[2];\n\r";
            strResult += "    var dtDate = Date.parse(strDate);\n\r";
            strResult += "    if (dtDate == NaN) \n\r";
            strResult += "    {\n\r";
            strResult += "        args.IsValid = true;\n\r";
            strResult += "        return true;\n\r";
            strResult += "    }\n\r";

            strResult += "    var dtCompare = Date.parse('" + dtDate.ToString("MM/dd/yyyy").Replace(".","/") + "');\n\r";

            strResult += "    if (dtDate " + strOperation + " dtCompare)\n\r";
            strResult += "    {\n\r";
            strResult += "        args.IsValid = true;\n\r";
            strResult += "    }\n\r";
            strResult += "    else {\n\r";
            strResult += "        args.IsValid = false;\n\r";
            strResult += "    }\n\r";
            strResult += "    return true;\n\r";
            strResult += "}\n\r";
            strResult += "</script>\n\r";
            return strResult;

            //ScriptManager.RegisterStartupScript(this.gvwCrf, this.GetType(), "ValidatorsScriptMaxNow", MarafonHelper.GetValidatorFunctionJS("fnValidateMaxNow", "<", DateTime.Now), false);
            //ClientScript.RegisterStartupScript(this.GetType(), "ValidatorsScriptMin1900", MarafonHelper.GetValidatorFunctionJS("fnValidateMin1900", ">", DateTime.Parse("01.01.1900")));
            //ScriptManager.RegisterStartupScript(this.dvwCrf, this.GetType(), "ValidatorsScriptMinBirthDate", MarafonHelper.GetValidatorFunctionJS("fnValidateBirthDate", ">", this.GetCrfDate("Birth_Date")), false);
            //ClientScript.RegisterStartupScript(this.GetType(), "ValidatorsScriptMinHospDate", MarafonHelper.GetValidatorFunctionJS("fnValidateHospDate", ">", this.GetCrfDate("Hospitalization_Date_Time")));

        }


    }
}