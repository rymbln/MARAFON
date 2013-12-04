using System;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Marafon
{
    public partial class Center : System.Web.UI.Page
    {
        private string strIDName = "Center_id";
        private string strTableName = "Center";
        private string strWardIDName = "Ward_id";
        private string strWardTableName = "Ward";
        private string strWardPatientGroupAmountIDName = "ward_patient_group_amount_id";
        private string strWardPatientGroupAmountTableName = "ward_patient_group_amount";

        private bool boolEditMode = false;

        private bool IsEditing()
        {
            return boolEditMode;
        }

        private void SwitchEditing(bool IsEdit)
        {
            this.btnAddCenter.Enabled = IsEdit;
            this.btnAddWard.Enabled = IsEdit;
            this.btnFindPopup.Enabled = IsEdit;
            this.btnRefreshCenter.Enabled = IsEdit;
            boolEditMode = !IsEdit;
            this.gvwCenter.AllowSorting = IsEdit;
            this.gvwWard.AllowSorting = IsEdit;
            this.gvwWardPatientGroupAmount.AllowSorting = IsEdit;
        }

        private string fnFilterCenter()
        {
            string strFind = "";
            if ((this.tboxFindCenter.Text != "") || (this.tboxFindCenterNumber.Text != "") || (this.tboxFindCity.Text != "") || (this.tboxFindRegion.Text != ""))
            {
                if (this.tboxFindCenter.Text != "")
                {
                    strFind += string.Format("description like '%{0}%'", this.tboxFindCenter.Text);
                }
                if (this.tboxFindCenterNumber.Text != "")
                {
                    if (strFind != "")
                    {
                        strFind += " AND ";
                    }
                    strFind += string.Format("center_number = {0}", this.tboxFindCenterNumber.Text);
                }
                if (this.tboxFindCity.Text != "")
                {
                    if (strFind != "")
                    {
                        strFind += " AND ";
                    }
                    strFind += string.Format("city_name like '%{0}%'", this.tboxFindCity.Text);
                }
                if (this.tboxFindRegion.Text != "")
                {
                    if (strFind != "")
                    {
                        strFind += " AND ";
                    }
                    strFind += string.Format("region_description like '%{0}%'", this.tboxFindRegion.Text);
                }
            }
            return strFind;

        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                dsrcCenter.FilterExpression = fnFilterCenter();
                if (gvwCenter.SelectedIndex < 0)
                {
                    gvwCenter.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnRefreshCenter_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindCenter.Text = "";
                this.tboxFindCenterNumber.Text = "";
                this.tboxFindCity.Text = "";
                this.tboxFindRegion.Text = "";
                dsrcCenter.FilterExpression = fnFilterCenter();
                dsrcCenter.DataBind();
                gvwCenter.DataBind();
                gvwWardPatientGroupAmount.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnAddCenter_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindCenter.Text = "";
                this.tboxFindCenterNumber.Text = "";
                this.tboxFindCity.Text = "";
                this.tboxFindRegion.Text = "";
                dsrcCenter.FilterExpression = fnFilterCenter();
                SwitchEditing(false);
                int intID = MarafonHelper.AddRecord(this.gvwCenter, "MarafonConnection", strTableName, "DESCRIPTION,SUSER", String.Format("'-','{0}'", Session["uid"]), strIDName);
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

        protected void gvwCenter_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwCenter_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
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

        protected void gvwCenter_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                if (Session[strIDName] != null && (int)Session[strIDName] > 0)
                {
                    (sender as GridView).SelectedIndex = 0;
                }
                Session[strIDName] = MarafonHelper.DelRecord("MarafonConnection", strTableName, strIDName, Session[strIDName], Session["uid"].ToString());
                SwitchEditing(true);
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

        protected void gvwCenter_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
                {
                    ImageButton btnTemp;
                    btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnSelect") as ImageButton);
                    btnTemp.Enabled = false;
                    btnTemp.ImageUrl = "~/images/16_publish_grey.gif";
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

        protected void gvwCenter_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnAddWard_Click(object sender, System.EventArgs e)
        {
            try
            {
                SwitchEditing(false);
                int intID = MarafonHelper.AddRecord(this.gvwWard, "MarafonConnection", strWardTableName, "CENTER_ID,DESCRIPTION,SUSER", String.Format("{0},'-','{1}'", this.gvwCenter.SelectedValue, Session["uid"]), strWardIDName);
                if (intID > 0)
                {
                    Session[strWardIDName] = intID;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWard_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwWard_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strWardIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWard_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strWardIDName] = MarafonHelper.DelRecord("MarafonConnection", strWardTableName, strWardIDName, Session[strWardIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteWard_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strWardIDName] = MarafonHelper.DelRecord("MarafonConnection", strWardTableName, strWardIDName, intDelID, Session["uid"].ToString());
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

        protected void btnFindCenter_Click(object sender, EventArgs e)
        {
            try
            {
                dsrcCenter.FilterExpression = fnFilterCenter();
                dsrcCenter.DataBind();
                gvwCenter.DataBind();
                gvwCenter.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCenter_DataBound(object sender, EventArgs e)
        {
            try
            {
                if (!IsEditing())
                {
                    this.btnAddWard.Enabled = !(this.gvwCenter.SelectedValue == null);
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }



        protected void btnAddWardPatientGroupAmount_Click(object sender, System.EventArgs e)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                try
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select top 1 ward_id from ward where center_id={0}", this.gvwCenter.SelectedValue), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        rdValues.Read();
                        SwitchEditing(false);
                        int intID = MarafonHelper.AddRecord(this.gvwWardPatientGroupAmount, "MarafonConnection", strWardPatientGroupAmountTableName, "ward_id,patient_amount,suser", String.Format("{0},0,'{1}'", rdValues.GetInt32(0).ToString(), Session["uid"]), strWardPatientGroupAmountIDName);
                        if (intID > 0)
                        {
                            Session[strWardPatientGroupAmountIDName] = intID;
                        }
                    }
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
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWardPatientGroupAmount_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwWardPatientGroupAmount_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strWardPatientGroupAmountIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWardPatientGroupAmount_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strWardPatientGroupAmountIDName] = MarafonHelper.DelRecord("MarafonConnection", strWardPatientGroupAmountTableName, strWardPatientGroupAmountIDName, Session[strWardPatientGroupAmountIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteWardPatientGroupAmount_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strWardPatientGroupAmountIDName] = MarafonHelper.DelRecord("MarafonConnection", strWardPatientGroupAmountTableName, strWardPatientGroupAmountIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwWardPatientGroupAmount_RowCreated(object sender, GridViewRowEventArgs e)
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

        protected void gvwWardPatientGroupAmount_PageIndexChanging(object sender, GridViewPageEventArgs e)
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





    }
}





