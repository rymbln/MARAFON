using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.SqlClient;
using System.Configuration;
using AjaxControlToolkit;

namespace Marafon
{
    public partial class PackStore : System.Web.UI.Page
    {
        private string strIDName = "Pack_Store_id";
        private string strTableName = "Pack_Store";

        private bool boolEditMode = false;
        private bool boolRequery = false;

        private bool IsEditing()
        {
            return boolEditMode;
        }

        private void SwitchEditing(bool IsEdit)
        {
            this.btnAddPack_Store.Enabled = IsEdit;
            this.btnFindPopupPack_Store.Enabled = IsEdit;
            this.btnRefreshPack_Store.Enabled = IsEdit;
            this.btnDoubleInput.Enabled = IsEdit;
            this.ddlInputNumber.Enabled = IsEdit;
            boolEditMode = !IsEdit;
            this.gvwPack_Store.AllowSorting = IsEdit;
        }

        private string fnFilterPack_Store()
        {
            string strFind;
            strFind = "";
            if (this.tboxFindPack_StoreID.Text != "")
            {
                strFind += String.Format("PACK_STORE_ID = {0}", this.tboxFindPack_StoreID.Text);
            }
            if (this.tboxFindTradeAB.Text != "")
            {
                if (strFind != "")
                {
                    strFind += " AND ";
                }
                strFind += string.Format("TABLET_PACK_DESCRIPTION_VW LIKE '%{0}%'", this.tboxFindTradeAB.Text);
            }
            if (this.tboxFindWard.Text != "")
            {
                if (strFind != "")
                {
                    strFind += " AND ";
                }
                strFind += string.Format("WARD_DESCRIPTION LIKE '%{0}%'", this.tboxFindWard.Text);
            }
            return strFind;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                Session["input_number"] = this.ddlInputNumber.SelectedValue;
                dsrcPack_Store.FilterExpression = fnFilterPack_Store();
                if (this.gvwPack_Store.SelectedIndex < 0)
                {
                    this.gvwPack_Store.SelectedIndex = 0;
                }
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
                this.tboxFindPack_StoreID.Text = "";
                this.tboxFindTradeAB.Text = "";
                this.tboxFindWard.Text = "";
                dsrcPack_Store.FilterExpression = fnFilterPack_Store();
                dsrcPack_Store.DataBind();
                gvwPack_Store.DataBind();
                gvwPack_Store.SelectedIndex = 0;
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
                SwitchEditing(false);
                this.tboxFindPack_StoreID.Text = "";
                this.tboxFindTradeAB.Text = "";
                this.tboxFindWard.Text = "";
                dsrcPack_Store.FilterExpression = fnFilterPack_Store();
                int intID = MarafonHelper.AddRecord(this.gvwPack_Store, this.dvwPack_Store, "MarafonConnection", strTableName, "INPUT_NUMBER,SUSER", String.Format("{0},'{1}'", Session["INPUT_NUMBER"], Session["uid"]), strIDName, out boolRequery);
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

        protected void gvwPack_Store_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName != "Update")
                {
                    //this.dsrcPack_Store.FilterExpression = fnFilterPack_Store();
                    //dsrcPack_Store.DataBind();
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDelete_Click(object sender, EventArgs e)
        {
            try
            {
                object intDelID = (MarafonHelper.RecursiveFindParent((sender as Control),typeof(DetailsView)) as DetailsView).SelectedValue;
                Session[strIDName] = MarafonHelper.DelRecord("MarafonConnection", strTableName, strIDName, intDelID, Session["uid"].ToString());
                int intPageIndex = gvwPack_Store.PageIndex;
                gvwPack_Store.DataBind();
                gvwInputCompare.DataBind();
                if (intPageIndex > gvwPack_Store.PageIndex)
                {
                    gvwPack_Store.SelectedIndex = gvwPack_Store.Rows.Count - 1;
                }
                if (gvwPack_Store.SelectedIndex >= gvwPack_Store.Rows.Count - 1)
                {
                    gvwPack_Store.SelectedIndex = gvwPack_Store.Rows.Count - 1;
                }
                SwitchEditing(true);

            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwPack_Store_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                if (IsEditing())
                {
                    e.Cancel = true;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnFindPack_Store_Click(object sender, EventArgs e)
        {
            try
            {
                dsrcPack_Store.FilterExpression = fnFilterPack_Store();
                dsrcPack_Store.DataBind();
                gvwPack_Store.DataBind();
                gvwPack_Store.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwPack_Store_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            try
            {
                Decimal decPackQuantity;
                if (Decimal.TryParse(e.NewValues[0].ToString(), out decPackQuantity))
                {
                    e.NewValues[0] = decPackQuantity;
                }
                if ((e.NewValues[2] == null) || ((int.Parse(e.NewValues[2].ToString()) == 1) && ((e.NewValues[3] == null) || (e.NewValues[3].ToString() == ""))))
                {
                    (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "lblError_Pack_Store") as Label).Text = "Выберите АМП и форму выпуска";
                    Session[strIDName] = (sender as DetailsView).DataKey.Value;
                    e.Cancel = true;
                }

            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwPack_Store_ItemCreated(object sender, EventArgs e)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if ((((sender as DetailsView).CurrentMode == DetailsViewMode.Edit) || ((sender as DetailsView).CurrentMode == DetailsViewMode.Insert)) && ((sender as DetailsView).DataKey.Value != null))
                {
                    (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "lblError_Pack_Store") as Label).Text = "";
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();

                    cmdValues = new SqlCommand(String.Format("SELECT TRADE_AB_ID,TABLET_PACK_ID FROM VW_INTERFACE_PACK_STORE WHERE PACK_STORE_ID={0}", (sender as DetailsView).DataKey.Value == null ? '0' : (sender as DetailsView).DataKey.Value), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "cddTradeAB") as CascadingDropDown).SelectedValue = rdValues.GetInt32(0).ToString();
                            (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "cddTabletPack") as CascadingDropDown).SelectedValue = rdValues.GetInt32(1).ToString();
                        }
                    }
                    //(MarafonHelper.RecursiveFindControl<Control>((sender as Control), "rvDateReceive") as RangeValidator).MaximumValue = DateTime.Now.Date.ToString("dd.MM.yyyy");
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

        protected void gvwPack_Store_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                //dvwPack_Store.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwPack_Store_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            try
            {
                gvwPack_Store.DataBind();
                gvwInputCompare.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwPack_Store_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            try
            {
                gvwPack_Store.DataBind();
                gvwInputCompare.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwPack_Store_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
        {
            try
            {
                if (IsEditing())
                {
                    e.Cancel = true;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }

        }

        protected void btnSave_Click(object sender, EventArgs e)
        {
            try
            {
                Session[strIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancel_Click(object sender, EventArgs e)
        {

            try
            {
                Session[strIDName] = MarafonHelper.DelRecord("MarafonConnection", strTableName, strIDName, Session[strIDName], Session["uid"].ToString());
                int intPageIndex = gvwPack_Store.PageIndex;
                gvwPack_Store.DataBind();
                if (intPageIndex > gvwPack_Store.PageIndex)
                {
                    gvwPack_Store.SelectedIndex = gvwPack_Store.Rows.Count - 1;
                }
                if (gvwPack_Store.SelectedIndex > gvwPack_Store.Rows.Count - 1)
                {
                    gvwPack_Store.SelectedIndex = gvwPack_Store.Rows.Count - 1;
                }
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwPack_Store_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (IsEditing() && (e.Row.RowType == DataControlRowType.DataRow))
                {
                    ImageButton btnTemp;
                    btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnSelect") as ImageButton);
                    btnTemp.Enabled = false;
                    btnTemp.ImageUrl = "~/images/16_publish_grey.gif";
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnEdit_Click(object sender, EventArgs e)
        {
            try
            {
                SwitchEditing(false);
                //dsrcPack_Store.FilterExpression = fnFilterPack_Store();
                gvwPack_Store.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwPack_Store_DataBound(object sender, EventArgs e)
        {
            try
            {
                if (boolRequery)
                {
                    (sender as DetailsView).ChangeMode(DetailsViewMode.Edit);
                    boolRequery = false;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

    }
}
