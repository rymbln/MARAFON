using System;
using System.Collections.Generic;
//using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Marafon;


namespace Marafon
{
    public partial class Frequency : System.Web.UI.Page
    {
        private string strIDName = "Frequency_id";
        private string strTableName = "Frequency";

        private string fnFilterDictionary()
        {
            string strFind;
            strFind = "";
            if (this.tboxFindDictionary.Text != "")
            {
                strFind = strFind + "description LIKE '%" + this.tboxFindDictionary.Text + "%'";
            }
            return strFind;
        }

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

        protected void btnRefreshDictionary_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindDictionary.Text = "";
                dsrcDictionary.FilterExpression = fnFilterDictionary();
                dsrcDictionary.DataBind();
                gvwDictionary.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnAddDictionary_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.btnFindPopup.Enabled = false;
                this.btnRefreshDictionary.Enabled = false;
                this.btnAddDictionary.Enabled = false;
                this.tboxFindDictionary.Text = "";
                int intID = MarafonHelper.AddRecord(this.gvwDictionary, "MarafonConnection", strTableName, "DESCRIPTION,SUSER", String.Format("'-','{0}'", Session["uid"]), strIDName);
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

        protected void gvwDictionary_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
        {
            try
            {
                this.btnRefreshDictionary.Enabled = false;
                this.btnFindPopup.Enabled = false;
                this.btnAddDictionary.Enabled = false;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwDictionary_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strIDName] = 0;
                this.dsrcDictionary.FilterExpression = fnFilterDictionary();
                this.btnFindPopup.Enabled = true;
                this.btnRefreshDictionary.Enabled = true;
                this.btnAddDictionary.Enabled = true;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwDictionary_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strIDName] = MarafonHelper.DelRecord("MarafonConnection", strTableName, strIDName, Session[strIDName], Session["uid"].ToString());
                this.btnFindPopup.Enabled = true;
                this.btnRefreshDictionary.Enabled = true;
                this.btnAddDictionary.Enabled = true;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwDictionary_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName != "Update")
                {
                    this.dsrcDictionary.FilterExpression = fnFilterDictionary();
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

        protected void gvwDictionary_RowCreated(object sender, GridViewRowEventArgs e)
        {
            try
            {
                if (((sender as GridView).EditIndex >= 0) && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
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

        protected void gvwDictionary_PageIndexChanging(object sender, GridViewPageEventArgs e)
        {
            try
            {
                if ((sender as GridView).EditIndex >= 0)
                {
                    e.Cancel = true;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnFindDictionary_Click(object sender, EventArgs e)
        {
            try
            {
                dsrcDictionary.FilterExpression = fnFilterDictionary();
                dsrcDictionary.DataBind();
                gvwDictionary.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }


    }
}
