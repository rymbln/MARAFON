using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Marafon
{
    public partial class WardBedDays : System.Web.UI.Page
    {
        private string strIDName = "Ward_id";
        private string strTableName = "Ward";
        private string strWard_Bed_DaysIDName = "Ward_Bed_Days_id";
        private string strWard_Bed_DaysTableName = "Ward_Bed_Days";

        private bool boolEditMode = false;

        private bool IsEditing()
        {
            return boolEditMode;
        }

        private void SwitchEditing(bool IsEdit)
        {
            this.btnAddWard_Bed_Days.Enabled = IsEdit;
            this.btnFindPopup.Enabled = IsEdit;
            this.btnRefreshWard.Enabled = IsEdit;
            this.gvwWard.AllowSorting = IsEdit;
            this.gvwWard_Bed_Days.AllowSorting = IsEdit;
            boolEditMode = !IsEdit;
        }

        private string fnFilterWard()
        {
            string strFind = "";
            if ((this.tboxFindWard.Text != ""))
            {
                if (this.tboxFindWard.Text != "")
                {
                    strFind += string.Format("description like '%{0}%'", this.tboxFindWard.Text);
                }
            }
            return strFind;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                dsrcWard.FilterExpression = fnFilterWard();
                if (gvwWard.SelectedIndex < 0)
                {
                    gvwWard.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnRefreshWard_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindWard.Text = "";
                dsrcWard.FilterExpression = fnFilterWard();
                dsrcWard.DataBind();
                gvwWard.DataBind();
                gvwWard.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnAddWard_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindWard.Text = "";
                dsrcWard.FilterExpression = fnFilterWard();
                SwitchEditing(false);
                int intID = MarafonHelper.AddRecord(this.gvwWard, "MarafonConnection", strTableName, "DESCRIPTION,SUSER", String.Format("'-','{0}'", Session["uid"]), strIDName);
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

        protected void gvwWard_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
                {
                    ImageButton btnTemp;
                    btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnSelect") as ImageButton);
                    btnTemp.Enabled = false;
                    btnTemp.ImageUrl = "~/images/16_publish_grey.gif";
                    //btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnEdit") as ImageButton);
                    //btnTemp.Enabled = false;
                    //btnTemp.ImageUrl = "~/images/ico_16_4207_grey.gif";
                    //btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnDelete") as ImageButton);
                    //btnTemp.Enabled = false;
                    //btnTemp.ImageUrl = "~/images/16_L_remove_grey.gif";
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWard_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnAddWard_Bed_Days_Click(object sender, System.EventArgs e)
        {
            try
            {
                SwitchEditing(false);
                int intID = MarafonHelper.AddRecord(this.gvwWard_Bed_Days, "MarafonConnection", strWard_Bed_DaysTableName, "WARD_ID,SUSER", String.Format("{0},'{1}'", gvwWard.SelectedValue, Session["uid"]), strWard_Bed_DaysIDName);
                if (intID > 0)
                {
                    Session[strWard_Bed_DaysIDName] = intID;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWard_Bed_Days_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            try
            {
                SwitchEditing(false);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWard_Bed_Days_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strWard_Bed_DaysIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWard_Bed_Days_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strWard_Bed_DaysIDName] = MarafonHelper.DelRecord("MarafonConnection", strWard_Bed_DaysTableName, strWard_Bed_DaysIDName, Session[strWard_Bed_DaysIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteWard_Bed_Days_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strWard_Bed_DaysIDName] = MarafonHelper.DelRecord("MarafonConnection", strWard_Bed_DaysTableName, strWard_Bed_DaysIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWard_Bed_Days_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
                {
                    ImageButton btnTemp;
                    btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnEdit") as ImageButton);
                    btnTemp.Enabled = false;
                    btnTemp.ImageUrl = "~/images/ico_16_4207_grey.gif";
                    btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnDelete") as ImageButton);
                    btnTemp.Enabled = false;
                    btnTemp.ImageUrl = "~/images/16_L_remove_grey.gif";
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWard_Bed_Days_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnEdit_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(false);
                MarafonHelper.RefreshGridViews((sender as Control));
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnSave_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                MarafonHelper.RefreshGridViews((sender as Control));
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancel_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                MarafonHelper.RefreshGridViews((sender as Control));
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnFindWard_Click(object sender, EventArgs e)
        {
            try
            {
                dsrcWard.FilterExpression = fnFilterWard();
                dsrcWard.DataBind();
                gvwWard.DataBind();
                gvwWard.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWard_DataBound(object sender, EventArgs e)
        {
            try
            {
                if (!IsEditing())
                {
                    this.btnAddWard_Bed_Days.Enabled = !(this.gvwWard.SelectedValue == null);
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

    }
}
