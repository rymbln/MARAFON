using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Marafon
{
    public partial class ClinicalMaterialGroup : System.Web.UI.Page
    {
        private string strIDName = "Clinical_Material_Group_id";
        private string strTableName = "Clinical_Material_Group";
        private string strClinical_MaterialIDName = "Clinical_Material_id";
        private string strClinical_MaterialTableName = "Clinical_Material";

        private bool boolEditMode = false;

        private bool IsEditing()
        {
            //return (this.gvwCenter.EditIndex >= 0) || (this.gvwWard.EditIndex >= 0);
            return boolEditMode;
        }

        private void SwitchEditing(bool IsEdit)
        {
            this.btnAddClinical_Material.Enabled = IsEdit;
            this.btnAddClinical_Material_Group.Enabled = IsEdit;
            this.btnFindPopup.Enabled = IsEdit;
            this.btnRefreshClinical_Material_Group.Enabled = IsEdit;
            boolEditMode = !IsEdit;
            this.gvwClinical_Material.AllowSorting = IsEdit;
            this.gvwClinical_Material_Group.AllowSorting = IsEdit;
        }

        private string fnFilterClinical_Material_Group()
        {
            string strFind = "";
            if ((this.tboxFindClinical_Material_Group.Text != ""))
            {
                if (this.tboxFindClinical_Material_Group.Text != "")
                {
                    strFind += string.Format("description like '%{0}%'", this.tboxFindClinical_Material_Group.Text);
                }
            }
            return strFind;
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                dsrcClinical_Material_Group.FilterExpression = fnFilterClinical_Material_Group();
                if (gvwClinical_Material_Group.SelectedIndex < 0)
                {
                    gvwClinical_Material_Group.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnRefreshClinical_Material_Group_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindClinical_Material_Group.Text = "";
                dsrcClinical_Material_Group.FilterExpression = fnFilterClinical_Material_Group();
                dsrcClinical_Material_Group.DataBind();
                gvwClinical_Material_Group.DataBind();
                gvwClinical_Material_Group.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnAddClinical_Material_Group_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindClinical_Material_Group.Text = "";
                dsrcClinical_Material_Group.FilterExpression = fnFilterClinical_Material_Group();
                SwitchEditing(false);
                int intID = MarafonHelper.AddRecord(this.gvwClinical_Material_Group, "MarafonConnection", strTableName, "DESCRIPTION,SUSER", String.Format("'-','{0}'", Session["uid"]), strIDName);
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

        protected void gvwClinical_Material_Group_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwClinical_Material_Group_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
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

        protected void gvwClinical_Material_Group_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
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

        protected void gvwClinical_Material_Group_RowCreated(object sender, GridViewRowEventArgs e)
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

        protected void gvwClinical_Material_Group_PageIndexChanging(object sender, GridViewPageEventArgs e)
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





        protected void btnAddClinical_Material_Click(object sender, System.EventArgs e)
        {
            try
            {
                SwitchEditing(false);
                int intID = MarafonHelper.AddRecord(this.gvwClinical_Material, "MarafonConnection", strClinical_MaterialTableName, "CLINICAL_MATERIAL_GROUP_ID,DESCRIPTION,SUSER", String.Format("{0},'-','{1}'", gvwClinical_Material_Group.SelectedValue, Session["uid"]), strClinical_MaterialIDName);
                if (intID > 0)
                {
                    Session[strClinical_MaterialIDName] = intID;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwClinical_Material_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwClinical_Material_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strClinical_MaterialIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwClinical_Material_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strClinical_MaterialIDName] = MarafonHelper.DelRecord("MarafonConnection", strClinical_MaterialTableName, strClinical_MaterialIDName, Session[strClinical_MaterialIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteClinical_Material_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strClinical_MaterialIDName] = MarafonHelper.DelRecord("MarafonConnection", strClinical_MaterialTableName, strClinical_MaterialIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwClinical_Material_RowCreated(object sender, GridViewRowEventArgs e)
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

        protected void gvwClinical_Material_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnFindClinicalMaterialGroup_Click(object sender, EventArgs e)
        {
            try
            {
                dsrcClinical_Material_Group.FilterExpression = fnFilterClinical_Material_Group();
                dsrcClinical_Material_Group.DataBind();
                gvwClinical_Material_Group.DataBind();
                gvwClinical_Material_Group.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwClinical_Material_Group_DataBound(object sender, EventArgs e)
        {
            try
            {
                if (!IsEditing())
                {
                    this.btnAddClinical_Material.Enabled = !(this.gvwClinical_Material_Group.SelectedValue == null);
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }



    }
}
