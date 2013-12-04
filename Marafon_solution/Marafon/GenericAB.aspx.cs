using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using AjaxControlToolkit;

namespace Marafon
{
    public partial class GenericAB : System.Web.UI.Page
    {
        private string strIDName = "Generic_AB_id";
        private string strTableName = "Generic_AB";
        private string strTrade_ABIDName = "Trade_AB_id";
        private string strTrade_ABTableName = "Trade_AB";
        private string strDDD_CoeffIDName = "DDD_Coeff_id";
        private string strDDD_CoeffTableName = "DDD_Coeff";
        private string strGeneric_AB_CoeffIDName = "Generic_AB_Coeff_id";
        private string strGeneric_AB_CoeffTableName = "Generic_AB_Coeff";

        private bool boolEditMode = false;

        private bool IsEditing()
        {
            //return (this.gvwCenter.EditIndex >= 0) || (this.gvwWard.EditIndex >= 0);
            return boolEditMode;
        }

        private void SwitchEditing(bool IsEdit)
        {
            this.btnAddDDD_Coeff.Enabled = IsEdit;
            this.btnAddGeneric_AB.Enabled = IsEdit;
            this.btnAddGeneric_AB_Coeff.Enabled = IsEdit;
            this.btnAddTrade_AB.Enabled = IsEdit;
            this.btnFindPopup.Enabled = IsEdit;
            this.btnRefreshGeneric_AB.Enabled = IsEdit;
            boolEditMode = !IsEdit;
            this.gvwDDD_Coeff.AllowSorting = IsEdit;
            this.gvwGeneric_AB.AllowSorting = IsEdit;
            this.gvwTrade_AB.AllowSorting = IsEdit;
            this.gvwGeneric_AB_Coeff.AllowSorting = IsEdit;

            //foreach(TabPanel tpCurrent in TabContainer1.Tabs)
            //{
            //    if (tpCurrent != TabContainer1.ActiveTab)
            //    {
            //        tpCurrent.Enabled = IsEdit;
            //    }
            //}

        }

        private string fnFilterGeneric_AB()
        {
            string strFind;
            strFind = "";
            if (this.tboxFindGeneric_AB.Text != "")
            {
                strFind = strFind + "description LIKE '%" + this.tboxFindGeneric_AB.Text + "%'";
            }
            if (this.tboxFindTrade_AB.Text != "")
            {
                if (strFind != "")
                {
                    strFind += " AND ";
                }
                strFind += string.Format("generic_ab_id in (select generic_ab_id from trade_ab where trade_ab.description like '%{0}%')", this.tboxFindTrade_AB.Text);
            }
            return strFind;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                dsrcGeneric_AB.FilterExpression = fnFilterGeneric_AB();
                if (gvwGeneric_AB.SelectedIndex < 0)
                {
                    gvwGeneric_AB.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnRefreshGeneric_AB_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindGeneric_AB.Text = "";
                this.tboxFindTrade_AB.Text = "";
                dsrcGeneric_AB.FilterExpression = fnFilterGeneric_AB();
                dsrcGeneric_AB.DataBind();
                gvwGeneric_AB.DataBind();
                gvwGeneric_AB.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnFindGeneric_AB_Click(object sender, System.EventArgs e)
        {
            try
            {
                dsrcGeneric_AB.FilterExpression = fnFilterGeneric_AB();
                dsrcGeneric_AB.DataBind();
                gvwGeneric_AB.DataBind();
                gvwGeneric_AB.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnAddGeneric_AB_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindGeneric_AB.Text = "";
                this.tboxFindTrade_AB.Text = "";
                dsrcGeneric_AB.FilterExpression = fnFilterGeneric_AB();
                SwitchEditing(false);
                int intID = MarafonHelper.AddRecord(this.gvwGeneric_AB, "MarafonConnection", strTableName, "DESCRIPTION,SUSER", String.Format("'-','{0}'", Session["uid"]), strIDName);
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

        protected void gvwGeneric_AB_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwGeneric_AB_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
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

        protected void gvwGeneric_AB_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
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

        protected void gvwGeneric_AB_RowCreated(object sender, GridViewRowEventArgs e)
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

        protected void gvwGeneric_AB_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        

        protected void btnAddTrade_AB_Click(object sender, System.EventArgs e)
        {
            try
            {
                SwitchEditing(false);
                int intID = MarafonHelper.AddRecord(this.gvwTrade_AB, "MarafonConnection", strTrade_ABTableName, "GENERIC_AB_ID,DESCRIPTION,SUSER", String.Format("{0},'-','{1}'", gvwGeneric_AB.SelectedValue, Session["uid"]), strTrade_ABIDName);
                if (intID > 0)
                {
                    Session[strTrade_ABIDName] = intID;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwTrade_AB_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwTrade_AB_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strTrade_ABIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwTrade_AB_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strTrade_ABIDName] = MarafonHelper.DelRecord("MarafonConnection", strTrade_ABTableName, strTrade_ABIDName, Session[strTrade_ABIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteTrade_AB_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strTrade_ABIDName] = MarafonHelper.DelRecord("MarafonConnection", strTrade_ABTableName, strTrade_ABIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwTrade_AB_RowCreated(object sender, GridViewRowEventArgs e)
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

        protected void gvwTrade_AB_PageIndexChanging(object sender, GridViewPageEventArgs e)
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




        protected void btnAddDDD_Coeff_Click(object sender, System.EventArgs e)
        {
            try
            {
                SwitchEditing(false);
                int intID = MarafonHelper.AddRecord(this.gvwDDD_Coeff, "MarafonConnection", strDDD_CoeffTableName, "GENERIC_AB_ID,SUSER", String.Format("{0},'{1}'", gvwGeneric_AB.SelectedValue, Session["uid"]), strDDD_CoeffIDName);
                if (intID > 0)
                {
                    Session[strDDD_CoeffIDName] = intID;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwDDD_Coeff_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwDDD_Coeff_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strDDD_CoeffIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwDDD_Coeff_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strDDD_CoeffIDName] = MarafonHelper.DelRecord("MarafonConnection", strDDD_CoeffTableName, strDDD_CoeffIDName, Session[strDDD_CoeffIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteDDD_Coeff_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strDDD_CoeffIDName] = MarafonHelper.DelRecord("MarafonConnection", strDDD_CoeffTableName, strDDD_CoeffIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwDDD_Coeff_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if ((e.Row.RowState & DataControlRowState.Edit) != 0)
                {
                    (MarafonHelper.RecursiveFindControl<Control>(e.Row, "rvUpdate_Year") as RangeValidator).MaximumValue = DateTime.Now.Year.ToString();
                }
                else
                {
                    if (IsEditing() && (e.Row.RowType == DataControlRowType.DataRow))
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

            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwDDD_Coeff_PageIndexChanging(object sender, GridViewPageEventArgs e)
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


        protected void btnAddGeneric_AB_Coeff_Click(object sender, System.EventArgs e)
        {
            try
            {
                SwitchEditing(false);
                int intID = MarafonHelper.AddRecord(this.gvwGeneric_AB_Coeff, "MarafonConnection", strGeneric_AB_CoeffTableName, "GENERIC_AB_ID,SUSER", String.Format("{0},'{1}'", gvwGeneric_AB.SelectedValue, Session["uid"]), strGeneric_AB_CoeffIDName);
                if (intID > 0)
                {
                    Session[strGeneric_AB_CoeffIDName] = intID;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwGeneric_AB_Coeff_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwGeneric_AB_Coeff_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strGeneric_AB_CoeffIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwGeneric_AB_Coeff_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strGeneric_AB_CoeffIDName] = MarafonHelper.DelRecord("MarafonConnection", strGeneric_AB_CoeffTableName, strGeneric_AB_CoeffIDName, Session[strGeneric_AB_CoeffIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteGeneric_AB_Coeff_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strGeneric_AB_CoeffIDName] = MarafonHelper.DelRecord("MarafonConnection", strGeneric_AB_CoeffTableName, strGeneric_AB_CoeffIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwGeneric_AB_Coeff_RowCreated(object sender, GridViewRowEventArgs e)
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

        protected void gvwGeneric_AB_Coeff_PageIndexChanging(object sender, GridViewPageEventArgs e)
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
                //this.TabPanel1.Enabled = true;
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

        protected void gvwGeneric_AB_DataBound(object sender, EventArgs e)
        {
            try
            {
                if (!IsEditing())
                {
                    this.btnAddDDD_Coeff.Enabled = !(this.gvwGeneric_AB.SelectedValue == null);
                    this.btnAddGeneric_AB_Coeff.Enabled = !(this.gvwGeneric_AB.SelectedValue == null);
                    this.btnAddTrade_AB.Enabled = !(this.gvwGeneric_AB.SelectedValue == null);
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }

        }


    }
}
