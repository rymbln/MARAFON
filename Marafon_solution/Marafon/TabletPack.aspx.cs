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
    public partial class TabletPack : System.Web.UI.Page
    {
        private string strIDName = "Tablet_Pack_id";
        private string strTableName = "Tablet_Pack";

        private bool boolEditMode = false;
        private bool boolRequery = false;

        private bool IsEditing()
        {
            return boolEditMode;
        }

        private void SwitchEditing(bool IsEdit)
        {
            this.btnAddTablet_Pack.Enabled = IsEdit;
            this.btnFindPopupTablet_Pack.Enabled = IsEdit;
            this.btnRefreshTablet_Pack.Enabled = IsEdit;
            boolEditMode = !IsEdit;
            this.gvwTablet_Pack.AllowSorting = IsEdit;
        }

        private string fnFilterTablet_Pack()
        {
            string strFind;
            strFind = "";
            if (this.tboxFindTrade_AB.Text != "")
            {
                strFind += String.Format("TRADE_AB_DESCRIPTION LIKE '%{0}%'", this.tboxFindTrade_AB.Text);
            }
            if (this.tboxFindMedical_Form.Text != "")
            {
                if (strFind != "")
                {
                    strFind += " AND ";
                }
                strFind += string.Format("MEDICAL_FORM_DESCRIPTION  LIKE '%{0}%'", this.tboxFindMedical_Form.Text);
            }
            if (this.tboxFindCompany.Text != "")
            {
                if (strFind != "")
                {
                    strFind += " AND ";
                }
                strFind += string.Format("COMPANY_DESCRIPTION LIKE '%{0}%'", this.tboxFindCompany.Text);
            }
            return strFind;
        }

        //private int GetMeasureItemID(string strCode)
        //{
        //    SqlConnection cnnValues = null;
        //    SqlCommand cmdValues = null;
        //    SqlDataReader rdValues = null;
        //    try
        //    {
        //        cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
        //        cnnValues.Open();
        //        cmdValues = new SqlCommand(String.Format("SELECT MEASURE_ITEM_ID FROM MEASURE_ITEM WHERE MEASURE_ITEM_CODE=N'{0}'", strCode), cnnValues);
        //        rdValues = cmdValues.ExecuteReader();
        //        int intID = 0;
        //        if (rdValues.HasRows)
        //        {
        //            while (rdValues.Read())
        //            {
        //                intID = rdValues.GetInt32(0);
        //            }
        //        }
        //        return intID;
        //    }
        //    finally
        //    {
        //        if (rdValues != null)
        //        {
        //            rdValues.Close();
        //            rdValues = null;
        //        }
        //        if (cmdValues != null)
        //        {
        //            cmdValues.Dispose();
        //            cmdValues = null;
        //        }
        //        if (cnnValues != null)
        //        {
        //            cnnValues.Close();
        //            cnnValues = null;
        //        }
        //    }
        //}

        //private bool RecognizeStr(string strSource, out int intMeasureItemID, out double dblABInDose, out double dblDosesInPack, out double dblTabletPackCoeff)
        //{
        //    string SrcStr = strSource;
        //    string TempStr;
        //    int TempPos;
        //    Single TempVal;

        //    SrcStr = SrcStr.Trim();
        //    SrcStr = SrcStr.Replace(" |", "|");
        //    SrcStr = SrcStr.Replace("| ", "|");
        //    SrcStr = SrcStr.Replace(" мг", "мг");
        //    SrcStr = SrcStr.Replace(" г", "г");
        //    SrcStr = SrcStr.Replace(" мл", "мл");
        //    SrcStr = SrcStr.Replace(" ЕД", "ЕД");
        //    SrcStr = SrcStr.Replace(" МЕ", "МЕ");
        //    SrcStr = SrcStr.Replace(" +", "+");
        //    SrcStr = SrcStr.Replace("+ ", "+");
        //    SrcStr = SrcStr.Replace(".", ",");
        //    SrcStr = SrcStr.Replace("/", "|");
        //    SrcStr = SrcStr.Replace("|мл", "|1мл");

        //    TempPos = SrcStr.IndexOf("№");
        //    if (TempPos > 0)
        //    {
        //        dblDosesInPack = double.Parse(SrcStr.Substring(TempPos+1));
        //        SrcStr = SrcStr.Substring(0,TempPos - 1).Trim();
        //    }
        //    else
        //    {
        //        intMeasureItemID = 0;
        //        dblABInDose = 0;
        //        dblDosesInPack = 0;
        //        dblTabletPackCoeff = 0;
        //        return false;
        //    }

        //    TempPos = SrcStr.IndexOf("+");
        //    if(TempPos > 0)
        //    {
        //        TempStr = SrcStr.Substring(0,TempPos).Replace("г", "").Trim();
        //        SrcStr = SrcStr.Substring(TempPos + 1);
        //        TempVal = (TempStr.IndexOf("м") >= 0) ? Single.Parse(TempStr) : Single.Parse(TempStr.Replace("м",""))/1000;
        //        TempPos = SrcStr.IndexOf("|");
        //        if (TempPos < 0){TempPos = SrcStr.IndexOf(" ");}
        //        if (TempPos < 0){TempPos = SrcStr.Length-1;}
        //        TempStr = SrcStr.Substring(0, TempPos).Replace("г", "").Trim();
        //        SrcStr = SrcStr.Substring(TempPos + 1);
        //        TempVal = (TempStr.IndexOf("м") >= 0) ? Single.Parse(TempStr) : Single.Parse(TempStr.Replace("м",""))/1000;
        //        SrcStr = TempVal.ToString() + "г" + SrcStr;
        //    }
        //    //'если в строке стоит мг|мл без последующих мл, убираем |
        //    TempPos = SrcStr.IndexOf(" ");
        //    if(TempPos == 0){TempPos = SrcStr.Length-1;}
        //    TempStr = SrcStr.Substring(TempPos);
        //    if (TempStr.IndexOf("мл") == 0) { SrcStr = SrcStr.Replace("|", " "); }

        //    //'разбираем МЕ|мл - перевод только в МЕ
        //    TempPos = SrcStr.IndexOf("МЕ|");
        //    if(TempPos > 0)
        //    {
        //        TempStr = SrcStr.Substring(0,TempPos + 2);
        //        SrcStr = SrcStr.Substring(TempPos + 2);
        //        TempVal =Single.Parse(TempStr);
        //        TempPos = SrcStr.IndexOf(" ");
        //        TempStr = SrcStr.Substring(0, TempPos - 1).Replace("мл", "");
        //        SrcStr = SrcStr.Substring(TempPos);
        //        TempPos = SrcStr.IndexOf("мл");
        //        dblABInDose = TempVal * Single.Parse(SrcStr.Substring(0, TempPos - 1).Replace("мл", "")) / Single.Parse(TempStr);
        //        dblTabletPackCoeff = 1;
        //        intMeasureItemID = GetMeasureItemID("МЕ");
        //        return true;
        //    }

        //    //'разбираем ЕД|мл - превод только в ЕД
        //    TempPos = SrcStr.IndexOf("ЕД|");
        //    if(TempPos > 0)
        //    {
        //        TempStr = SrcStr.Substring(0, TempPos + 2);
        //        SrcStr = SrcStr.Substring(TempPos + 2);
        //        TempVal = Single.Parse(TempStr);
        //        TempPos = SrcStr.IndexOf(" ");
        //        TempStr = SrcStr.Substring(0, TempPos - 1).Replace("мл", "");
        //        SrcStr = SrcStr.Substring(TempPos);
        //        TempPos = SrcStr.IndexOf("мл");
        //        dblABInDose = TempVal * Single.Parse(SrcStr.Substring(0, TempPos - 1).Replace("мл", "")) / Single.Parse(TempStr);
        //        dblTabletPackCoeff = 1;
        //        intMeasureItemID = GetMeasureItemID("ЕД");
        //        return true;
        //    }
        //    //'преобразуем мг|мл в %
        //    TempPos = SrcStr.IndexOf("|");
        //    if(TempPos > 0)
        //    {
        //        TempStr = SrcStr.Substring(0, TempPos - 1).Replace("г", "").Trim();
        //        SrcStr = SrcStr.Substring(TempPos);
        //        TempVal = (TempStr.IndexOf("м") >= 0) ? Single.Parse(TempStr) : Single.Parse(TempStr.Replace("м",""))/1000;
        //        TempPos =SrcStr.IndexOf(" ");
        //        TempStr = SrcStr.Substring(0, TempPos - 1).Replace("мл", "").Trim();
        //        SrcStr = SrcStr.Substring(TempPos + 1);
        //        TempVal = TempVal / Single.Parse(TempStr) * 100;
        //        SrcStr = TempVal.ToString() + "%" + SrcStr;
        //    }

        //    //'разбор %
        //    TempPos = SrcStr.IndexOf("%");
        //    if(TempPos > 0)
        //    {
        //        //'в tempval получаем %
        //        dblTabletPackCoeff = Single.Parse(SrcStr.Substring(TempPos - 1).Trim()) / 100;
        //        SrcStr = SrcStr.Substring(TempPos).Trim();
        //        TempPos = SrcStr.IndexOf("мл");
        //        if(TempPos > 0)
        //        {
        //            intMeasureItemID = GetMeasureItemID("мл");
        //            dblABInDose = double.Parse(SrcStr.Substring(0, TempPos - 1).Trim());
        //            return true;
        //        }
        //        else
        //        {
        //            //'есть %, но нет мл
        //            intMeasureItemID = 0;
        //            dblABInDose = 0;
        //            dblDosesInPack = 0;
        //            dblTabletPackCoeff = 0;
        //            return false;
        //        }
        //    }

        //    //'разбор г
        //    TempPos = SrcStr.IndexOf("г");
        //    if(TempPos > 0)
        //    {
        //        SrcStr = SrcStr.Substring(0, TempPos - 1);
        //        TempVal = (TempStr.IndexOf("м") >= 0) ? Single.Parse(TempStr) : Single.Parse(TempStr.Replace("м",""))/1000;
        //        dblTabletPackCoeff = 1;
        //        intMeasureItemID = GetMeasureItemID("г");
        //        dblABInDose = TempVal;
        //        return true;
        //    }

        //    //'разбор МЕ
        //    TempPos = SrcStr.IndexOf("МЕ");
        //    if(TempPos > 0)
        //    {
        //        SrcStr = SrcStr.Substring(0, TempPos - 1);
        //        TempVal = Single.Parse(SrcStr);
        //        dblTabletPackCoeff = 1;
        //        intMeasureItemID = GetMeasureItemID("МЕ");
        //        dblABInDose = TempVal;
        //        return true;
        //    }

        //    //'разбор ЕД
        //    TempPos = SrcStr.IndexOf("ЕД");
        //    if(TempPos > 0)
        //    {
        //        SrcStr = SrcStr.Substring(0, TempPos - 1);
        //        TempVal = Single.Parse(SrcStr);
        //        dblTabletPackCoeff = 1;
        //        intMeasureItemID = GetMeasureItemID("ЕД");
        //        dblABInDose = TempVal;
        //        return true;
        //    }

        //    intMeasureItemID = 0;
        //    dblABInDose = 0;
        //    dblDosesInPack = 0;
        //    dblTabletPackCoeff = 0;
        //    return false;
        //}

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                dsrcTablet_Pack.FilterExpression = fnFilterTablet_Pack();
                if (this.gvwTablet_Pack.SelectedIndex < 0)
                {
                    this.gvwTablet_Pack.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnRefreshTablet_Pack_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindTrade_AB.Text = "";
                this.tboxFindMedical_Form.Text = "";
                this.tboxFindCompany.Text = "";
                dsrcTablet_Pack.FilterExpression = fnFilterTablet_Pack();
                dsrcTablet_Pack.DataBind();
                gvwTablet_Pack.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnAddTablet_Pack_Click(object sender, System.EventArgs e)
        {
            try
            {
                SwitchEditing(false);
                this.tboxFindTrade_AB.Text = "";
                this.tboxFindMedical_Form.Text = "";
                this.tboxFindCompany.Text = "";
                dsrcTablet_Pack.FilterExpression = fnFilterTablet_Pack();
                int intID = MarafonHelper.AddRecord(this.gvwTablet_Pack, this.dvwTablet_Pack, "MarafonConnection", strTableName, "SUSER", String.Format("'{0}'", Session["uid"]), strIDName, out boolRequery);
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

        protected void gvwTablet_Pack_RowCommand(object sender, System.Web.UI.WebControls.GridViewCommandEventArgs e)
        {
            try
            {
                if (e.CommandName != "Update")
                {
                    //this.dsrcTablet_Pack.FilterExpression = fnFilterTablet_Pack();
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
                object intDelID = (MarafonHelper.RecursiveFindParent((sender as Control), typeof(DetailsView)) as DetailsView).SelectedValue;
                Session[strIDName] = MarafonHelper.DelRecord("MarafonConnection", strTableName, strIDName, intDelID, Session["uid"].ToString());
                int intPageIndex = gvwTablet_Pack.PageIndex;
                gvwTablet_Pack.DataBind();
                if (intPageIndex > gvwTablet_Pack.PageIndex)
                {
                    gvwTablet_Pack.SelectedIndex = gvwTablet_Pack.Rows.Count - 1;
                }
                if (gvwTablet_Pack.SelectedIndex > gvwTablet_Pack.Rows.Count - 1)
                {
                    gvwTablet_Pack.SelectedIndex = gvwTablet_Pack.Rows.Count - 1;
                }

            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwTablet_Pack_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnFindTablet_Pack_Click(object sender, EventArgs e)
        {
            try
            {
                dsrcTablet_Pack.FilterExpression = fnFilterTablet_Pack();
                dsrcTablet_Pack.DataBind();
                gvwTablet_Pack.DataBind();
                gvwTablet_Pack.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwTablet_Pack_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            try
            {
                //int intTradeABID = int.Parse(e.NewValues[0].ToString());
                //int intCompanyID = int.Parse(e.NewValues[1].ToString());
                //int intMedicalFormID = int.Parse(e.NewValues[2].ToString());
                //double dblUserABInDose;
                //double dblABInDose;
                //double dblDosesInPack;
                //int intMeasureItemID;
                double dblTabletPackCoeff;
                //string strTabletPackStr = e.NewValues[4].ToString();
                if (e.NewValues[6] != null)
                {
                    if (double.TryParse(e.NewValues[6].ToString(), out dblTabletPackCoeff))
                    {
                        if (dblTabletPackCoeff > 0)
                        {
                            e.NewValues[6] = dblTabletPackCoeff / 100;
                        }
                        else
                        {
                            e.NewValues[6] = 1;
                        }
                    }
                }
                else
                {
                    e.NewValues[6] = 1;
                }

                //if(RecognizeStr(strTabletPackStr, out intMeasureItemID, out dblABInDose, out dblDosesInPack, out dblTabletPackCoeff))
                //{
                //    if (!Double.TryParse(e.NewValues[3].ToString(), out dblUserABInDose))
                //    {
                //        dblUserABInDose = 0;
                //    }
                //    e.NewValues.Clear();
                //    e.NewValues.Add("TRADE_AB_ID", intTradeABID);
                //    e.NewValues.Add("COMPANY_ID", intCompanyID);
                //    e.NewValues.Add("MEDICAL_FORM_ID", intMedicalFormID);
                //    e.NewValues.Add("AB_IN_DOSE", (dblUserABInDose > 0) ? dblUserABInDose : dblABInDose);
                //    e.NewValues.Add("DOSES_IN_PACK", dblDosesInPack);
                //    e.NewValues.Add("MEASURE_ITEM_ID", intMeasureItemID);
                //    e.NewValues.Add("TABLET_PACK_COEFFICIENT", dblTabletPackCoeff);
                //    e.NewValues.Add("TABLET_PACK_STR", strTabletPackStr);
                //}
                //else
                //{
                //    e.Cancel = true;
                //}
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }


        protected void gvwTablet_Pack_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                //dvwTablet_Pack.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwTablet_Pack_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            try
            {
                gvwTablet_Pack.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwTablet_Pack_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            try
            {
                gvwTablet_Pack.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwTablet_Pack_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
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
                int intPageIndex = gvwTablet_Pack.PageIndex;
                gvwTablet_Pack.DataBind();
                if (intPageIndex > gvwTablet_Pack.PageIndex)
                {
                    gvwTablet_Pack.SelectedIndex = gvwTablet_Pack.Rows.Count - 1;
                }
                if (gvwTablet_Pack.SelectedIndex > gvwTablet_Pack.Rows.Count - 1)
                {
                    gvwTablet_Pack.SelectedIndex = gvwTablet_Pack.Rows.Count - 1;
                }
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwTablet_Pack_RowCreated(object sender, GridViewRowEventArgs e)
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
                gvwTablet_Pack.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwTablet_Pack_DataBound(object sender, EventArgs e)
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
