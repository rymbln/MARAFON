using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;

namespace Marafon
{
    public partial class Tablet : System.Web.UI.Page
    {
        private string strIDName = "Pack_Store_id";
        private string strTableName = "Pack_Store";

        private string fnFilterPack_Store()
        {
            string strFind;
            strFind = "";
            if (this.tboxFindPack_Store.Text != "")
            {
                strFind +=String.Format("Pack_Store_ID = {0}",this.tboxFindPack_Store.Text);
            }
            return strFind;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                MarafonHelper.ClientMsgBox(lblAddError, "");
                MarafonHelper.ClientMsgBox(lblFindError, "");
                MarafonHelper.ClientMsgBox(lblRefreshError, "");
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnRefreshPack_Store_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindPack_Store.Text = "";
                MarafonHelper.CheckEditMode(this.gvwPack_Store, lblRefreshError, this.dsrcPack_Store, fnFilterPack_Store());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnFindPack_Store_Click(object sender, System.EventArgs e)
        {
            try
            {
                MarafonHelper.CheckEditMode(this.gvwPack_Store, lblFindError, this.dsrcPack_Store, fnFilterPack_Store());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnAddPack_Store_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindPack_Store.Text = "";
                int intID = MarafonHelper.AddRecord(this.gvwPack_Store, "MarafonConnection", strTableName, "DESCRIPTION,SUSER", String.Format("'-','{0}'", Session["uid"]), strIDName, lblAddError);
                if (intID > 0)
                {
                    Session[strIDName] = intID;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwPack_Store_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            try
            {
                if (this.gvwPack_Store.EditIndex >= 0)
                {
                    MarafonHelper.ClientMsgBox((MarafonHelper.RecursiveFindControl<Control>((sender as GridView).Rows[e.NewEditIndex], "lblEditError") as Label), "Сохраните или отмените изменения!");
                    e.Cancel = true;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwPack_Store_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strIDName] = 0;
                this.dsrcPack_Store.FilterExpression = fnFilterPack_Store();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwPack_Store_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strIDName] = MarafonHelper.DelRecord("MarafonConnection", strTableName, strIDName, Session[strIDName], Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwPack_Store_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName != "Update")
                {
                    this.dsrcPack_Store.FilterExpression = fnFilterPack_Store();
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDelete_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strIDName] = MarafonHelper.DelRecord("MarafonConnection", strTableName, strIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }


        protected void gvwPack_Store_RowCreated(object sender, GridViewRowEventArgs e)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                //if((e.Row.RowState & DataControlRowState.Edit) != 0)
                //{
                //    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                //    cnnValues.Open();
                //    cmdValues = new SqlCommand(String.Format("SELECT TRADE_AB_ID,TABLET_PACK_ID FROM VW_INTERFACE_PACK_STORE WHERE PACK_STORE_ID={0}", (sender as GridView).DataKeys[e.Row.RowIndex].Value), cnnValues);
                //    rdValues = cmdValues.ExecuteReader();
                //    if (rdValues.HasRows)
                //    {
                //        while(rdValues.Read())
                //        {
                //            (MarafonHelper.RecursiveFindControl<Control>(e.Row, "cddTradeAB") as CascadingDropDown).SelectedValue = rdValues.GetInt32(0).ToString();
                //            (MarafonHelper.RecursiveFindControl<Control>(e.Row, "cddTabletPack") as CascadingDropDown).SelectedValue = rdValues.GetInt32(1).ToString();
                //        }
                //    }
                //}
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

        protected void gvwPack_Store_PageIndexChanged(object sender, EventArgs e)
        {
            try
            {
                if ((((sender as GridView).SelectedIndex < 0) || ((sender as GridView).SelectedIndex >= (sender as GridView).Rows.Count)))
                {
                    (sender as GridView).SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwPack_Store_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                Decimal decPackQuantity;
                if (Decimal.TryParse(e.NewValues[1].ToString(), out decPackQuantity))
                {
                    e.NewValues[1] = decPackQuantity;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }


    }
}
