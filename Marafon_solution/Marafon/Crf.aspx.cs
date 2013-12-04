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
    public partial class Crf : System.Web.UI.Page
    {
        private string strIDName = "Crf_id";
        private string strTableName = "Crf";
        private string strCrf_Diagnosis_MainIDName = "Crf_Diagnosis_id";
        private string strCrf_Diagnosis_MainTableName = "Crf_Diagnosis";
        private string strCrf_Diagnosis_NosocomialIDName = "Crf_Diagnosis_id";
        private string strCrf_Diagnosis_NosocomialTableName = "Crf_Diagnosis";
        private string strCrf_Diagnosis_OperationIDName = "Crf_Diagnosis_id";
        private string strCrf_Diagnosis_OperationTableName = "Crf_Diagnosis";
        private string strCrf_Risk_FactorIDName = "Crf_Risk_Factor_id";
        private string strCrf_Risk_FactorTableName = "Crf_Risk_Factor";
        private string strCrf_Previous_HospitalisationIDName = "Crf_Previous_Hospitalisation_id";
        private string strCrf_Previous_HospitalisationTableName = "Crf_Previous_Hospitalisation";
        private string strCrf_Ward_TransferIDName = "Crf_Ward_Transfer_id";
        private string strCrf_Ward_TransferTableName = "Crf_Ward_Transfer";
        private string strCrf_TherapyIDName = "Crf_Therapy_id";
        private string strCrf_TherapyTableName = "Crf_Therapy";
        private string strCrf_MicrobiologyIDName = "Crf_Microbiology_id";
        private string strCrf_MicrobiologyTableName = "Crf_Microbiology";
        private string strCrf_Microbiology_MicrobeIDName = "Crf_Microbiology_Microbe_id";
        private string strCrf_Microbiology_MicrobeTableName = "Crf_Microbiology_Microbe";

        //private bool boolEditMode = false;
        private bool boolRequery = false;
        private bool boolRequeryTherapy = false;

        private bool IsEditing()
        {
            if (Session["boolEditMode_Crf"] == null)
            {
                return false;
            }
            else
            {
                return bool.Parse(Session["boolEditMode_Crf"].ToString());
            }
        }

        private void SwitchEditing(bool IsEdit)
        {
            //this.btnAddCrf.Enabled = IsEdit;
            //this.btnFindPopupCrf.Enabled = IsEdit;
            //this.btnRefreshCrf.Enabled = IsEdit;
            //this.btnAddCrf_Diagnosis_Main.Enabled = IsEdit;
            //this.btnAddCrf_Diagnosis_Nosocomial.Enabled = IsEdit;
            //this.btnAddCrf_Diagnosis_Operation.Enabled = IsEdit;
            //this.btnAddCrf_Risk_Factor.Enabled = IsEdit;
            //this.btnAddCrf_Previous_Hospitalisation.Enabled = IsEdit;
            //this.btnAddCrf_Ward_Transfer.Enabled = IsEdit;
            //this.btnAddCrf_Therapy.Enabled = IsEdit;
            //this.gvwCrf.AllowSorting = IsEdit;
            //this.gvwCrf_Diagnosis_Main.AllowSorting = IsEdit;
            //this.gvwCrf_Diagnosis_Nosocomial.AllowSorting = IsEdit;
            //this.gvwCrf_Diagnosis_Operation.AllowSorting = IsEdit;
            //this.gvwCrf_Risk_Factor.AllowSorting = IsEdit;
            //this.gvwCrf_Previous_Hospitalisation.AllowSorting = IsEdit;
            //this.gvwCrf_Ward_Transfer.AllowSorting = IsEdit;
            //this.gvwCrf_Therapy.AllowSorting = IsEdit;
            Session["boolEditMode_Crf"] = !IsEdit;

        }

        //private void ReBindTabs()
        //{
        //    this.gvwCrf_Diagnosis_Main.DataBind();
        //    this.gvwCrf_Diagnosis_Nosocomial.DataBind();
        //    this.gvwCrf_Diagnosis_Operation.DataBind();
        //    this.gvwCrf_Risk_Factor.DataBind();
        //    this.gvwCrf_Previous_Hospitalisation.DataBind();
        //    this.gvwCrf_Ward_Transfer.DataBind();
        //}

        private void ClearVerified()
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("update crf set is_verified=0 where crf_id={0}", gvwCrf.SelectedValue == null ? "0" : gvwCrf.SelectedValue), cnnValues);
                    cmdValues.ExecuteNonQuery();
                }
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

        public void Date_Min_Now_ServerValidation(object source, ServerValidateEventArgs e)
        {
            DateTime dtDate;
            if(DateTime.TryParse(e.Value, out dtDate))
            {
                if((dtDate>=DateTime.Parse("01.01.2010")) && (dtDate<=DateTime.Now))
                {
                    e.IsValid=true;
                }
                else
                {
                    e.IsValid=false;
                }
            }
            else
            {
                e.IsValid=false;
            }
        }


        public DateTime GetCrfDate(string strFieldName)
        {
            DateTime dtCrfDate = DateTime.MinValue;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select {0} from crf where crf_id={1} and {0} is not null", strFieldName, gvwCrf.SelectedValue == null ? "0" : gvwCrf.SelectedValue), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            dtCrfDate = rdValues.GetDateTime(0);
                        }
                    }
                }
                return dtCrfDate;
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

        public int GetCrfInt(string strFieldName)
        {
            int intCrfInt = 0;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select {0} from crf where crf_id={1} and {0} is not null", strFieldName, gvwCrf.SelectedValue == null ? "0" : gvwCrf.SelectedValue), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            intCrfInt = rdValues.GetInt32(0);
                        }
                    }
                }
                return intCrfInt;
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

        private bool IsNosocomial(DateTime dtInfectionStartDate)
        {
            DateTime dtHospDate=GetCrfDate("Hospitalization_Date_Time");
            dtHospDate = dtHospDate.AddMinutes(-dtHospDate.Minute).AddHours(48-dtHospDate.Hour);
            return (dtInfectionStartDate >= dtHospDate);
        }

        private int CheckCrfDiagnosis(int intCrfID)
        {
            int intDiagnosisCount = 0;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select count(diagnosis_text) from crf_diagnosis where crf_id={0}", intCrfID), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            intDiagnosisCount = rdValues.GetInt32(0);
                        }
                    }
                }
                return intDiagnosisCount;
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

        private int CheckCrfDiagnosis(int intCrfID, int intDiagnosisTypeID)
        {
            int intDiagnosisCount = 0;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select count(crf_diagnosis_id) from crf_diagnosis where crf_id={0} and diagnosis_type_id={1} and (isnull(diagnosis_text,'')<>'' or diagnosis_id>1)", intCrfID, intDiagnosisTypeID), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            intDiagnosisCount = rdValues.GetInt32(0);
                        }
                    }
                }
                return intDiagnosisCount;
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

        private int CheckMicrobiologyNosocomial(int intCrfID, int intClinicalMaterialID, DateTime dtMaterialReceivingDate)
        {
            int intDiagnosisCount = 0;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select count(crf_diagnosis_id) from crf_diagnosis inner join clinical_material on crf_diagnosis.clinical_material_group_id=clinical_material.clinical_material_group_id where crf_id={0} and Clinical_Material_id={1} and start_date<=@infection_date", intCrfID, intClinicalMaterialID), cnnValues);
                    //dtMaterialReceivingDate.AddMinutes(-dtMaterialReceivingDate.Minute).AddHours(-dtMaterialReceivingDate.Hour);
                    //, dtMaterialReceivingDate.ToString("yyyy-MM-dd HH:mm")
                    cmdValues.Parameters.Add(new SqlParameter("@infection_date", System.Data.SqlDbType.DateTime));
                    cmdValues.Parameters["@infection_date"].Value = dtMaterialReceivingDate.AddMinutes(-dtMaterialReceivingDate.Minute).AddHours(-dtMaterialReceivingDate.Hour);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            intDiagnosisCount = rdValues.GetInt32(0);
                        }
                    }
                }
                return intDiagnosisCount;
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

        private int CheckMicrobiologyIsMicrobe(int intCrfMicrobiologyID)
        {
            int intCount = 0;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select count(crf_microbiology_id) from crf_microbiology where crf_microbiology_id={0} and is_no_growth=3", intCrfMicrobiologyID), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            intCount = rdValues.GetInt32(0);
                        }
                    }
                }
                return intCount;
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

        private int CheckWardTransfer(int intCrfID)
        {
            int intCount = 0;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select count(crf_ward_transfer_id) from crf_ward_transfer where crf_id={0} and transfer_date is null", intCrfID), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            intCount = rdValues.GetInt32(0);
                        }
                    }
                }
                return intCount;
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

        private int CheckEmptyWards()
        {
            //int intCount = 0;
            //SqlConnection cnnValues = null;
            //SqlCommand cmdValues = null;
            //SqlDataReader rdValues = null;
            //try
            //{
            //    if (gvwCrf.SelectedIndex >= 0)
            //    {
            //        cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
            //        cnnValues.Open();
            //        cmdValues = new SqlCommand(string.Format("select count(crf.crf_id) from crf left outer join crf_ward_transfer on crf.crf_id=crf_ward_transfer.crf_id where crf.center_id={0} and crf_ward_transfer.crf_ward_transfer_id is null", Session["Center_ID"] == null ? "0" : Session["Center_ID"]), cnnValues);
            //        rdValues = cmdValues.ExecuteReader();
            //        if (rdValues.HasRows)
            //        {
            //            while (rdValues.Read())
            //            {
            //                intCount = rdValues.GetInt32(0);
            //            }
            //        }
            //    }
            //    return intCount;
            //}
            //finally
            //{
            //    if (rdValues != null)
            //    {
            //        rdValues.Close();
            //        rdValues = null;
            //    }
            //    if (cmdValues != null)
            //    {
            //        cmdValues.Dispose();
            //        cmdValues = null;
            //    }
            //    if (cnnValues != null)
            //    {
            //        cnnValues.Close();
            //        cnnValues = null;
            //    }
            //}
            return 0;
        }

        private bool GetCrfDiagnosisDates(int intCrfID, out object objStartDate, out object objEndDate)
        {
            bool boolResult = false;
            objStartDate = null;
            objEndDate = null;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select start_date,end_date from crf_diagnosis where crf_id={0} and start_date is not null order by start_date", intCrfID), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            objStartDate = rdValues[0];
                            objEndDate = rdValues[1];
                            boolResult = true;
                        }
                    }
                }
                return boolResult;
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

        private bool GetCrfDiagnosisDates(int intCrfID, int intDiagnosisTypeID, out object objStartDate, out object objEndDate)
        {
            bool boolResult = false;
            objStartDate = null;
            objEndDate = null;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select top 1 start_date,end_date from crf_diagnosis where crf_id={0} and diagnosis_type_id={1} and start_date is not null order by start_date", intCrfID, intDiagnosisTypeID), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            objStartDate = rdValues[0];
                            objEndDate = rdValues[1];
                            boolResult = true;
                        }
                    }
                }
                return boolResult;
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

        private bool CheckCrfSaved(int intCrfID)
        {
            bool boolResult = false;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select Hospitalization_Date_Time from crf where crf_id={0} and Hospitalization_Date_Time is not null", intCrfID), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        boolResult = true;
                    }
                }
                return boolResult;
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


        private int CheckDiagnosisAB(int intCrfDiagnosisID)
        {
            int intCount = 0;
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select count(crf_therapy_id) from crf_therapy where crf_diagnosis_id={0}", intCrfDiagnosisID), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            intCount = rdValues.GetInt32(0);
                        }
                    }
                }
                return intCount;
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


        protected void mevMaxNow_DataBinding(object sender, EventArgs e)
        {
            try
            {
                (sender as AjaxControlToolkit.MaskedEditValidator).MaximumValue = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void mevMinBirthMaxNow_DataBinding(object sender, EventArgs e)
        {
            try
            {
                (sender as AjaxControlToolkit.MaskedEditValidator).MinimumValue = GetCrfDate("Birth_Date").ToString("dd.MM.yyyy HH:mm:ss");
                (sender as AjaxControlToolkit.MaskedEditValidator).MaximumValue = DateTime.Now.ToString("dd.MM.yyyy HH:mm:ss");
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void mevMinHospMaxNow_DataBinding(object sender, EventArgs e)
        {
            try
            {
                (sender as AjaxControlToolkit.MaskedEditValidator).MinimumValue = GetCrfDate("Hospitalization_Date_Time").ToString("dd.MM.yyyy HH:mm");
                (sender as AjaxControlToolkit.MaskedEditValidator).MaximumValue = DateTime.Now.ToString("dd.MM.yyyy HH:mm");
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        private string fnGetCrfIDs(string strCriteria)
        {
            string strResult = "0";
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (gvwCrf.SelectedIndex >= 0)
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();
                    cmdValues = new SqlCommand(String.Format("select crf_id from crf_microbiology where laboratory_number like '%{0}%'", strCriteria), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            strResult += "," + rdValues.GetInt32(0).ToString();
                        }
                    }
                }
                return strResult;
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

        private string fnFilterCrf()
        {
            string strFind="";

            if (this.tboxFindCase_History.Text != "")
            {
                strFind += String.Format("case_history LIKE '%{0}%'", this.tboxFindCase_History.Text);
            }
            if (this.tbxCenterNumber.Text != "")
            {
                if (strFind != "")
                {
                    strFind += " AND ";
                }
                strFind += string.Format("center_number = {0}", this.tbxCenterNumber.Text);
            }
            if (this.tboxFindCRF_Number.Text != "")
            {
                if (strFind != "")
                {
                    strFind += " AND ";
                }
                strFind += string.Format("crf_number = {0}", this.tboxFindCRF_Number.Text);
            }
            if (this.tboxFindFIO.Text != "")
            {
                if (strFind != "")
                {
                    strFind += " AND ";
                }
                strFind += string.Format("fio LIKE '%{0}%'", this.tboxFindFIO.Text);
            }
            if (this.tboxFindLaboratory_Number.Text != "")
            {
                if (strFind != "")
                {
                    strFind += " AND ";
                }

                strFind += string.Format("crf_id in ({0})", fnGetCrfIDs(this.tboxFindLaboratory_Number.Text));
                //strFind += "crf_id in (2,5,6,7,8)";
            }
            return strFind;
        }

        protected void fnValidateBirthDate(object sender, ServerValidateEventArgs args)
        {
            DateTime dtArgs;
            args.IsValid = (!(string.IsNullOrEmpty(args.Value)) && (DateTime.TryParse(args.Value, out dtArgs)) && (dtArgs > this.GetCrfDate("Birth_Date")));
        }
        protected void fnValidateHospDate(object sender, ServerValidateEventArgs args)
        {
            DateTime dtArgs;
            args.IsValid = (!(string.IsNullOrEmpty(args.Value)) && (DateTime.TryParse(args.Value, out dtArgs)) && (dtArgs > this.GetCrfDate("Hospitalization_Date_Time")));
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            try
            {
                lblError_Crf.Text = "";
                lblError_Diagnosis_Main.Text = "";
                lblError_Nosocomial.Text = "";
                lblError_Operation.Text = "";
                lblError_Risk_Factor.Text = "";
                lblError_Ward_Transfer.Text = "";
                lblError_Previous_Hospitalisation.Text = "";
                lblError_Ward_Transfer.Text = "";
                lblError_Crf_Therapy.Text = "";
                lblError_Microbiology.Text = "";
                lblError_Microbiology_Microbe.Text = "";
                                
                dsrcCrf.FilterExpression = fnFilterCrf();
                if (this.gvwCrf.SelectedIndex < 0)
                {
                    this.gvwCrf.SelectedIndex = 0;
                }
                //if (this.gvwCrf_Therapy.SelectedIndex < 0)
                //{
                //    this.gvwCrf_Therapy.SelectedIndex = 0;
                //}
                //if (this.gvwCrf_Microbiology.SelectedIndex < 0)
                //{
                //    this.gvwCrf_Microbiology.SelectedIndex = 0;
                //}
                Session["Current_Crf_ID"] = gvwCrf.SelectedValue;
                ScriptManager.RegisterStartupScript(page: this.Page, type: this.GetType(), key: "ValidatorsScriptMaxNow", script: MarafonHelper.GetValidatorFunctionJS("fnValidateMaxNow", "<", DateTime.Now), addScriptTags: false);
                ScriptManager.RegisterStartupScript(page: this.Page, type: this.GetType(), key: "ValidatorsScriptMin1900", script: MarafonHelper.GetValidatorFunctionJS("fnValidateMin1900", ">", DateTime.Parse("01.01.2010")), addScriptTags: false);
                //ScriptManager.RegisterClientScriptBlock(control: this.dvwCrf, type: this.dvwCrf.GetType(), key: "ValidatorsScriptMinBirthDate", script: MarafonHelper.GetValidatorFunctionJS("fnValidateBirthDate", ">", this.GetCrfDate("Birth_Date")), addScriptTags: false);
                //ScriptManager.RegisterClientScriptBlock(control: this.dvwCrf, type: this.dvwCrf.GetType(), key: "ValidatorsScriptMinHospDate", script: MarafonHelper.GetValidatorFunctionJS("fnValidateHospDate", ">", this.GetCrfDate("Hospitalization_Date_Time")), addScriptTags: false);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnRefreshCrf_Click(object sender, System.EventArgs e)
        {
            try
            {
                this.tboxFindCase_History.Text = "";
                this.tboxFindCRF_Number.Text = "";
                this.tboxFindFIO.Text = "";
                this.tboxFindLaboratory_Number.Text = "";
                dsrcCrf.FilterExpression = fnFilterCrf();
                dsrcCrf.DataBind();
                gvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnAddCrf_Click(object sender, System.EventArgs e)
        {
            try
            {   // Сделано по просьбе Мищенко, на период ввода карт операторами. Отмена проверки данных о пребывании пациентов. Править функцию CheckEmptyWards
               if(CheckEmptyWards() > 0)
                { 
                    this.lblError_Crf.Text="Заполните данные о пребывании пациента в отделениях для всех внесённых карт";
                }
                else
                {
                    SwitchEditing(false);
                    this.tboxFindCase_History.Text = "";
                    this.tboxFindCRF_Number.Text = "";
                    this.tboxFindFIO.Text = "";
                    this.tboxFindLaboratory_Number.Text = "";
                    dsrcCrf.FilterExpression = fnFilterCrf();
                    int intID = MarafonHelper.AddRecord(this.gvwCrf, this.dvwCrf, "MarafonConnection", strTableName, "center_id,SUSER", String.Format("{0},'{1}'", Session["Center_ID"], Session["uid"]), strIDName, out boolRequery);
                    if (intID > 0)
                    {
                        Session[strIDName] = intID;
                    }
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteCrf_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                object intDelID = (MarafonHelper.RecursiveFindParent((sender as Control), typeof(DetailsView)) as DetailsView).SelectedValue;
                Session[strIDName] = MarafonHelper.DelRecord("MarafonConnection", strTableName, strIDName, intDelID, Session["uid"].ToString());
                int intPageIndex = gvwCrf.PageIndex;
                gvwCrf.DataBind();
                if (intPageIndex > gvwCrf.PageIndex)
                {
                    gvwCrf.SelectedIndex = gvwCrf.Rows.Count - 1;
                }
                if (gvwCrf.SelectedIndex > gvwCrf.Rows.Count - 1)
                {
                    gvwCrf.SelectedIndex = gvwCrf.Rows.Count - 1;
                }

            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnFindCrf_Click(object sender, EventArgs e)
        {
            try
            {
                dsrcCrf.FilterExpression = fnFilterCrf();
                dsrcCrf.DataBind();
                gvwCrf.DataBind();
                gvwCrf.SelectedIndex = 0;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwCrf_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            try
            {
                gvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwCrf_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            try
            {
                Session[strIDName] = 0;
                gvwCrf.DataBind();
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
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

        protected void btnSaveCrf_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                ClearVerified();
                MarafonHelper.RefreshGridViews(sender);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancelCrf_Click(object sender, ImageClickEventArgs e)
        {

            try
            {
                Session[strIDName] = MarafonHelper.DelRecord("MarafonConnection", strTableName, strIDName, Session[strIDName], Session["uid"].ToString());
                int intPageIndex = gvwCrf.PageIndex;
                gvwCrf.DataBind();
                if (intPageIndex > gvwCrf.PageIndex)
                {
                    gvwCrf.SelectedIndex = gvwCrf.Rows.Count - 1;
                }
                if (gvwCrf.SelectedIndex > gvwCrf.Rows.Count - 1)
                {
                    gvwCrf.SelectedIndex = gvwCrf.Rows.Count - 1;
                }
                SwitchEditing(true);
                MarafonHelper.RefreshGridViews(sender);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //try
            //{
            //    if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
            //    {
            //        ImageButton btnTemp;
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnSelect") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/16_publish_grey.gif";
            //    }
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }

        protected void btnEditCrf_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(false);
                gvwCrf.DataBind();
                MarafonHelper.RefreshGridViews(sender);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwCrf_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            try
            {
                string strBirth_Date = e.NewValues[3].ToString();
                DateTime dtBirth_Date=DateTime.Parse(strBirth_Date);
                string strHospitalization_Date = e.NewValues[5].ToString();
                DateTime dtHospitalization_Date = DateTime.Parse(strHospitalization_Date);
                if (dtHospitalization_Date < dtBirth_Date)
                {
                    lblError_Crf.Text = "Дата госпитализации не должна быть меньше даты рождения";
                    //(MarafonHelper.RecursiveFindControl<Control>((sender as Control), "lblHospitalization_Date_TimeError") as Label).Text = "Дата госпитализации не должна быть меньше даты рождения";
                    e.Cancel = true;
                    SwitchEditing(false);
                    return;
                }
                //if (dtHospitalization_Date > DateTime.Now)
                //{
                //    lblError_Crf.Text = "Дата госпитализации не должна быть больше текущей даты";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}

                if (e.NewValues[6] != null)
                {
                    string strRelease_Death_Date = e.NewValues[6].ToString();
                    DateTime dtRelease_Death_Date = DateTime.MaxValue;

                    if ((DateTime.TryParse(strRelease_Death_Date, out dtRelease_Death_Date)) && (dtRelease_Death_Date < dtHospitalization_Date))
                    {
                        lblError_Crf.Text = "Дата выписки/смерти не должна быть меньше даты госпитализации";
                        //(MarafonHelper.RecursiveFindControl<Control>((sender as Control), "lblRelease_Death_DateError") as Label).Text = "Дата выписки/смерти не должна быть меньше даты госпитализации";
                        e.Cancel = true;
                        SwitchEditing(false);
                        return;
                    }
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwCrf_ItemCreated(object sender, EventArgs e)
        {
            //try
            //{
            //    if (IsEditing() && ((sender as DetailsView).CurrentMode == DetailsViewMode.ReadOnly) && ((sender as DetailsView).DataKey.Value!=null))
            //    {
            //        ImageButton btnTemp;
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "btnEdit") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/ico_16_4207_grey.gif";
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "btnDelete") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/16_L_remove_grey.gif";
            //    }
            //    //if (((sender as DetailsView).CurrentMode == DetailsViewMode.Edit) && ((sender as DetailsView).DataKey.Value != null))
            //    //{
            //    //    (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "mevHospitalization_Date_Time") as AjaxControlToolkit.MaskedEditValidator).MaximumValue = DateTime.Now.ToString("dd.MM.yyyy HH:mm");
            //    //}
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }



        protected void gvwCrf_Diagnosis_Main_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwCrf_Diagnosis_Main_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strCrf_Diagnosis_MainIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Diagnosis_Main_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strCrf_Diagnosis_MainIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Diagnosis_MainTableName, strCrf_Diagnosis_MainIDName, Session[strCrf_Diagnosis_MainIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Diagnosis_Main_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //try
            //{
            //    if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
            //    {
            //        ImageButton btnTemp;
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnEdit") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/ico_16_4207_grey.gif";
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnDelete") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/16_L_remove_grey.gif";
            //    }
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }

        protected void gvwCrf_Diagnosis_Main_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnAddCrf_Diagnosis_Main_Click(object sender, System.EventArgs e)
        {
            try
            {
                if ((this.gvwCrf.SelectedValue == null) || !CheckCrfSaved(int.Parse(gvwCrf.SelectedValue.ToString())))
                {
                    this.lblError_Diagnosis_Main.Text = "Не выбрана или не сохранена информация о пациенте - добавление невозможно";
                }
                else
                {
                    SwitchEditing(false);
                    int intID = MarafonHelper.AddRecord(this.gvwCrf_Diagnosis_Main, "MarafonConnection", strCrf_Diagnosis_MainTableName, "Crf_ID,diagnosis_type_id,SUSER", String.Format("{0},2,'{1}'", gvwCrf.SelectedValue, Session["uid"]), strCrf_Diagnosis_MainIDName);
                    if (intID > 0)
                    {
                        Session[strCrf_Diagnosis_MainIDName] = intID;
                    }
                    //dvwCrf.DataBind();
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteCrf_Diagnosis_Main_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                if (CheckDiagnosisAB(int.Parse(intDelID.ToString())) <= 0)
                {
                    Session[strCrf_Diagnosis_MainIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Diagnosis_MainTableName, strCrf_Diagnosis_MainIDName, intDelID, Session["uid"].ToString());
                }
                //else
                //{
                //    this.lblError_Nosocomial.Text = "Перед удалением диагноза удалите связанную с ним терапию!";
                //}
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnEditCrf_Diagnosis_Main_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(false);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnSaveCrf_Diagnosis_Main_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                ClearVerified();
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancelCrf_Diagnosis_Main_Click(object sender, ImageClickEventArgs e)
        {
            //try
            //{
            //    //SwitchEditing(true);
            //    MarafonHelper.RefreshGridViews((sender as Control));
            //    dvwCrf.DataBind();
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }

        protected void gvwCrf_Diagnosis_Main_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Diagnosis_Nosocomial_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwCrf_Diagnosis_Nosocomial_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strCrf_Diagnosis_NosocomialIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Diagnosis_Nosocomial_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strCrf_Diagnosis_NosocomialIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Diagnosis_NosocomialTableName, strCrf_Diagnosis_NosocomialIDName, Session[strCrf_Diagnosis_NosocomialIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Diagnosis_Nosocomial_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //try
            //{
            //    if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
            //    {
            //        ImageButton btnTemp;
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnEdit") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/ico_16_4207_grey.gif";
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnDelete") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/16_L_remove_grey.gif";
            //    }
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }

        protected void gvwCrf_Diagnosis_Nosocomial_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnAddCrf_Diagnosis_Nosocomial_Click(object sender, System.EventArgs e)
        {
            try
            {
                if ((this.gvwCrf.SelectedValue == null) || !CheckCrfSaved(int.Parse(gvwCrf.SelectedValue.ToString())))
                {
                    this.lblError_Diagnosis_Main.Text = "Не выбрана или не сохранена информация о пациенте - добавление невозможно";
                }
                else
                {
                    SwitchEditing(false);
                    int intID = MarafonHelper.AddRecord(this.gvwCrf_Diagnosis_Nosocomial, "MarafonConnection", strCrf_Diagnosis_NosocomialTableName, "Crf_ID,diagnosis_type_id,SUSER", String.Format("{0},3,'{1}'", gvwCrf.SelectedValue, Session["uid"]), strCrf_Diagnosis_NosocomialIDName);
                    if (intID > 0)
                    {
                        Session[strCrf_Diagnosis_NosocomialIDName] = intID;
                    }
                    //dvwCrf.DataBind();
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteCrf_Diagnosis_Nosocomial_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                if (CheckDiagnosisAB(int.Parse(intDelID.ToString())) <= 0)
                {
                    Session[strCrf_Diagnosis_NosocomialIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Diagnosis_NosocomialTableName, strCrf_Diagnosis_NosocomialIDName, intDelID, Session["uid"].ToString());
                }
                //else
                //{
                //    this.lblError_Nosocomial.Text = "Перед удалением диагноза удалите связанную с ним терапию!";
                //}
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnEditCrf_Diagnosis_Nosocomial_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(false);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnSaveCrf_Diagnosis_Nosocomial_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                ClearVerified();
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancelCrf_Diagnosis_Nosocomial_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Diagnosis_Nosocomial_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string strStart_Date = e.NewValues[3].ToString();
                DateTime dtStart_Date = DateTime.Parse(strStart_Date);
                string strEnd_Date;
                DateTime dtEnd_Date;
                if (e.NewValues[4] != null)
                {
                    strEnd_Date = e.NewValues[4].ToString();
                    dtEnd_Date = DateTime.Parse(strEnd_Date);
                }
                else
                {
                    dtEnd_Date = DateTime.MaxValue;
                }

                if (dtEnd_Date < dtStart_Date)
                {
                    this.lblError_Nosocomial.Text = "Дата выписки не должна быть меньше даты постановки диагноза";
                    e.Cancel = true;
                    SwitchEditing(false);
                    return;
                }
                if (!IsNosocomial(dtStart_Date))
                {
                    this.lblError_Nosocomial.Text = "Инфекция не является нозокомиальной";
                    e.Cancel = true;
                    SwitchEditing(false);
                    return;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Init(object sender, EventArgs e)
        {
            try
            {
                dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwCrf_DataBound(object sender, EventArgs e)
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

        protected void gvwCrf_DataBound(object sender, EventArgs e)
        {
            //try
            //{
            //    //if (!IsEditing())
            //    //{
            //    //    this.btnAddCrf_Diagnosis_Main.Enabled = !(this.gvwCrf.SelectedValue == null);
            //    //    this.btnAddCrf_Diagnosis_Nosocomial.Enabled = !(this.gvwCrf.SelectedValue == null);
            //    //    this.btnAddCrf_Diagnosis_Operation.Enabled = !(this.gvwCrf.SelectedValue == null);
            //    //    this.btnAddCrf_Risk_Factor.Enabled = !(this.gvwCrf.SelectedValue == null);
            //    //    this.btnAddCrf_Previous_Hospitalisation.Enabled = !(this.gvwCrf.SelectedValue == null);
            //    //    this.btnAddCrf_Ward_Transfer.Enabled = !(this.gvwCrf.SelectedValue == null);
            //    //    this.btnAddCrf_Therapy.Enabled = !(this.gvwCrf.SelectedValue == null);
            //    //}
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }


        protected void gvwCrf_Diagnosis_Operation_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwCrf_Diagnosis_Operation_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strCrf_Diagnosis_OperationIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Diagnosis_Operation_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strCrf_Diagnosis_OperationIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Diagnosis_OperationTableName, strCrf_Diagnosis_OperationIDName, Session[strCrf_Diagnosis_OperationIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Diagnosis_Operation_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //try
            //{
            //    if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
            //    {
            //        ImageButton btnTemp;
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnEdit") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/ico_16_4207_grey.gif";
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnDelete") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/16_L_remove_grey.gif";
            //    }
            //    //if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) != 0) && (e.Row.RowType == DataControlRowType.DataRow))
            //    //{
            //    //    AjaxControlToolkit.MaskedEditValidator mevCurrent;
            //    //    mevCurrent=(MarafonHelper.RecursiveFindControl<Control>((sender as Control), "mevStart_Date_Operation") as AjaxControlToolkit.MaskedEditValidator);
            //    //    if (mevCurrent != null)
            //    //    {
            //    //        mevCurrent.MaximumValue = DateTime.Now.ToString("dd.MM.yyyy HH:mm");
            //    //    }
            //    //    mevCurrent = (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "mevEnd_Date_Operation") as AjaxControlToolkit.MaskedEditValidator);
            //    //    if (mevCurrent != null)
            //    //    {
            //    //        mevCurrent.MaximumValue = DateTime.Now.ToString("dd.MM.yyyy HH:mm");
            //    //    }
            //    //}
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }

        protected void gvwCrf_Diagnosis_Operation_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnAddCrf_Diagnosis_Operation_Click(object sender, System.EventArgs e)
        {
            try
            {
                if ((this.gvwCrf.SelectedValue == null) || !CheckCrfSaved(int.Parse(gvwCrf.SelectedValue.ToString())))
                {
                    this.lblError_Diagnosis_Main.Text = "Не выбрана или не сохранена информация о пациенте - добавление невозможно";
                }
                else
                {
                    SwitchEditing(false);
                    int intID = MarafonHelper.AddRecord(this.gvwCrf_Diagnosis_Operation, "MarafonConnection", strCrf_Diagnosis_OperationTableName, "Crf_ID,diagnosis_type_id,SUSER", String.Format("{0},4,'{1}'", gvwCrf.SelectedValue, Session["uid"]), strCrf_Diagnosis_OperationIDName);
                    if (intID > 0)
                    {
                        Session[strCrf_Diagnosis_OperationIDName] = intID;
                    }
                    //dvwCrf.DataBind();
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteCrf_Diagnosis_Operation_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                if (CheckDiagnosisAB(int.Parse(intDelID.ToString())) <= 0)
                {
                    Session[strCrf_Diagnosis_OperationIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Diagnosis_OperationTableName, strCrf_Diagnosis_OperationIDName, intDelID, Session["uid"].ToString());
                }
                //else
                //{
                //    this.lblError_Operation.Text = "Перед удалением диагноза удалите связанную с ним терапию!";
                //}
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnEditCrf_Diagnosis_Operation_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(false);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnSaveCrf_Diagnosis_Operation_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                ClearVerified();
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancelCrf_Diagnosis_Operation_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Diagnosis_Operation_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string strStart_Date = e.NewValues[1].ToString();
                DateTime dtStart_Date = DateTime.Parse(strStart_Date);
                string strEnd_Date = e.NewValues[2].ToString();
                DateTime dtEnd_Date = DateTime.Parse(strEnd_Date);
                //(MarafonHelper.RecursiveFindControl<Control>((sender as Control), "lblStart_DateError") as Label).Text = "";
                //(MarafonHelper.RecursiveFindControl<Control>((sender as Control), "lblEnd_DateError") as Label).Text = "";
                //if (dtStart_Date < GetCrfDate("Hospitalization_Date_Time").AddHours(-23))
                //{
                //    (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "lblStart_DateError") as Label).Text = "Дата постановки диагноза не должна быть меньше даты госпитализации";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}

                //if (dtStart_Date > DateTime.Now)
                //{
                //    this.lblError_Operation.Text = "Дата начала не должна быть больше текущей даты";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}
                //if (dtStart_Date < this.GetCrfDate("Birth_Date"))
                //{
                //    this.lblError_Operation.Text = "Дата начала не должна быть меньше даты рождения";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}
                //if (dtEnd_Date > DateTime.Now)
                //{
                //    this.lblError_Operation.Text = "Дата окончания не должна быть  больше текущей даты";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}
                //if (dtEnd_Date < this.GetCrfDate("Birth_Date"))
                //{
                //    this.lblError_Operation.Text = "Дата окончания не должна быть меньше даты рождения";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}

                if (dtEnd_Date < dtStart_Date)
                {
                    this.lblError_Operation.Text = "Дата окончания не должна быть меньше даты начала";
                    //(MarafonHelper.RecursiveFindControl<Control>((sender as Control), "lblStart_DateError") as Label).Text = "Дата окончания не должна быть меньше даты начала";
                    e.Cancel = true;
                    SwitchEditing(false);
                    return;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }






        protected void gvwCrf_Risk_Factor_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwCrf_Risk_Factor_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strCrf_Risk_FactorIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Risk_Factor_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strCrf_Risk_FactorIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Risk_FactorTableName, strCrf_Risk_FactorIDName, Session[strCrf_Risk_FactorIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Risk_Factor_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //try
            //{
            //    if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
            //    {
            //        ImageButton btnTemp;
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnEdit") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/ico_16_4207_grey.gif";
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnDelete") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/16_L_remove_grey.gif";
            //    }
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }

        protected void gvwCrf_Risk_Factor_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnAddCrf_Risk_Factor_Click(object sender, System.EventArgs e)
        {
            try
            {
                if ((this.gvwCrf.SelectedValue == null) || !CheckCrfSaved(int.Parse(gvwCrf.SelectedValue.ToString())))
                {
                    this.lblError_Diagnosis_Main.Text = "Не выбрана или не сохранена информация о пациенте - добавление невозможно";
                }
                else
                {

                    SwitchEditing(false);
                    int intID = MarafonHelper.AddRecord(this.gvwCrf_Risk_Factor, "MarafonConnection", strCrf_Risk_FactorTableName, "Crf_ID,SUSER", String.Format("{0},'{1}'", gvwCrf.SelectedValue, Session["uid"]), strCrf_Risk_FactorIDName);
                    if (intID > 0)
                    {
                        Session[strCrf_Risk_FactorIDName] = intID;
                    }
                    //dvwCrf.DataBind();
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteCrf_Risk_Factor_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strCrf_Risk_FactorIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Risk_FactorTableName, strCrf_Risk_FactorIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnEditCrf_Risk_Factor_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(false);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnSaveCrf_Risk_Factor_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                ClearVerified();
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancelCrf_Risk_Factor_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Risk_Factor_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string strStart_Date = e.NewValues[2].ToString();
                DateTime dtStart_Date = DateTime.Parse(strStart_Date);
                string strEnd_Date;
                DateTime dtEnd_Date;

                if (e.NewValues[3] != null)
                {
                    strEnd_Date = e.NewValues[3].ToString();
                    dtEnd_Date = DateTime.Parse(strEnd_Date);
                }
                else
                {
                    dtEnd_Date = DateTime.MaxValue;
                }
                if (dtEnd_Date < dtStart_Date)
                {
                    this.lblError_Risk_Factor.Text = "Дата окончания не должна быть меньше даты начала";
                    e.Cancel = true;
                    SwitchEditing(false);
                    return;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }




        protected void gvwCrf_Previous_Hospitalisation_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwCrf_Previous_Hospitalisation_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strCrf_Previous_HospitalisationIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Previous_Hospitalisation_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strCrf_Previous_HospitalisationIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Previous_HospitalisationTableName, strCrf_Previous_HospitalisationIDName, Session[strCrf_Previous_HospitalisationIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Previous_Hospitalisation_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //try
            //{
            //    if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
            //    {
            //        ImageButton btnTemp;
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnEdit") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/ico_16_4207_grey.gif";
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnDelete") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/16_L_remove_grey.gif";
            //    }
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }

        protected void gvwCrf_Previous_Hospitalisation_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnAddCrf_Previous_Hospitalisation_Click(object sender, System.EventArgs e)
        {
            try
            {
                if ((this.gvwCrf.SelectedValue == null) || !CheckCrfSaved(int.Parse(gvwCrf.SelectedValue.ToString())))
                {
                    this.lblError_Diagnosis_Main.Text = "Не выбрана или не сохранена информация о пациенте - добавление невозможно";
                }
                else if (GetCrfInt("is_previous_hospitalisation") != 3)
                {
                    this.lblError_Previous_Hospitalisation.Text = "В паспортной части не указаны предшествующие госпитализации";
                }
                else
                {
                    SwitchEditing(false);
                    int intID = MarafonHelper.AddRecord(this.gvwCrf_Previous_Hospitalisation, "MarafonConnection", strCrf_Previous_HospitalisationTableName, "Crf_ID,SUSER", String.Format("{0},'{1}'", gvwCrf.SelectedValue, Session["uid"]), strCrf_Previous_HospitalisationIDName);
                    if (intID > 0)
                    {
                        Session[strCrf_Previous_HospitalisationIDName] = intID;
                    }
                    //dvwCrf.DataBind();
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteCrf_Previous_Hospitalisation_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strCrf_Previous_HospitalisationIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Previous_HospitalisationTableName, strCrf_Previous_HospitalisationIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnEditCrf_Previous_Hospitalisation_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(false);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnSaveCrf_Previous_Hospitalisation_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                ClearVerified();
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancelCrf_Previous_Hospitalisation_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Previous_Hospitalisation_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string strStart_Date = e.NewValues[2].ToString();
                DateTime dtStart_Date = DateTime.Parse(strStart_Date);
                string strEnd_Date;
                DateTime dtEnd_Date;

                if (e.NewValues[3] != null)
                {
                    strEnd_Date = e.NewValues[3].ToString();
                    dtEnd_Date = DateTime.Parse(strEnd_Date);
                }
                else
                {
                    dtEnd_Date = DateTime.MaxValue;
                }
                if (dtEnd_Date < dtStart_Date)
                {
                    lblError_Previous_Hospitalisation.Text = "Дата выписки/перевода не должна быть меньше даты госпитализации";
                    e.Cancel = true;
                    SwitchEditing(false);
                    return;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }






        protected void gvwCrf_Ward_Transfer_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwCrf_Ward_Transfer_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strCrf_Ward_TransferIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Ward_Transfer_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strCrf_Ward_TransferIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Ward_TransferTableName, strCrf_Ward_TransferIDName, Session[strCrf_Ward_TransferIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Ward_Transfer_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //try
            //{
            //    if (IsEditing() && ((e.Row.RowState & DataControlRowState.Edit) == 0) && (e.Row.RowType == DataControlRowType.DataRow))
            //    {
            //        ImageButton btnTemp;
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnEdit") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/ico_16_4207_grey.gif";
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnDelete") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/16_L_remove_grey.gif";
            //    }
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }

        protected void gvwCrf_Ward_Transfer_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnAddCrf_Ward_Transfer_Click(object sender, System.EventArgs e)
        {
            try
            {
                if ((this.gvwCrf.SelectedValue == null) || !CheckCrfSaved(int.Parse(gvwCrf.SelectedValue.ToString())))
                {
                    this.lblError_Diagnosis_Main.Text = "Не выбрана или не сохранена информация о пациенте - добавление невозможно";
                }
                else if (CheckWardTransfer(int.Parse(this.gvwCrf.SelectedValue.ToString())) > 0)
                {
                    this.lblError_Ward_Transfer.Text = "Заполните дату перевода";
                }
                else
                {

                    SwitchEditing(false);
                    int intID = MarafonHelper.AddRecord(this.gvwCrf_Ward_Transfer, "MarafonConnection", strCrf_Ward_TransferTableName, "Crf_ID,SUSER", String.Format("{0},'{1}'", gvwCrf.SelectedValue, Session["uid"]), strCrf_Ward_TransferIDName);
                    if (intID > 0)
                    {
                        Session[strCrf_Ward_TransferIDName] = intID;
                    }
                    //dvwCrf.DataBind();
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteCrf_Ward_Transfer_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strCrf_Ward_TransferIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Ward_TransferTableName, strCrf_Ward_TransferIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnEditCrf_Ward_Transfer_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(false);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnSaveCrf_Ward_Transfer_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                ClearVerified();
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancelCrf_Ward_Transfer_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Ward_Transfer_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                string strStart_Date = e.NewValues[2].ToString();
                DateTime dtStart_Date = DateTime.Parse(strStart_Date);
                string strEnd_Date;
                DateTime dtEnd_Date;

                if (e.NewValues[3] != null)
                {
                    strEnd_Date = e.NewValues[3].ToString();
                    dtEnd_Date = DateTime.Parse(strEnd_Date);
                }
                else
                {
                    dtEnd_Date = DateTime.MaxValue;
                }
                if (dtEnd_Date < dtStart_Date)
                {
                    lblError_Ward_Transfer.Text = "Дата перевода не должна быть меньше даты поступления";
                    e.Cancel = true;
                    SwitchEditing(false);
                    return;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }



















        protected void btnAddCrf_Therapy_Click(object sender, System.EventArgs e)
        {
            try
            {
                if ((this.gvwCrf.SelectedValue == null) || !CheckCrfSaved(int.Parse(gvwCrf.SelectedValue.ToString())))
                {
                    this.lblError_Diagnosis_Main.Text = "Не выбрана или не сохранена информация о пациенте - добавление невозможно";
                }
                else
                {
                    if (CheckCrfDiagnosis(int.Parse(gvwCrf.SelectedValue.ToString())) > 0)
                    {
                        SwitchEditing(false);
                        int intID = MarafonHelper.AddRecord(this.gvwCrf_Therapy, this.dvwCrf_Therapy, "MarafonConnection", strCrf_TherapyTableName, "crf_id,SUSER", String.Format("{0},'{1}'", gvwCrf.SelectedValue, Session["uid"]), strCrf_TherapyIDName, out boolRequeryTherapy);
                        if (intID > 0)
                        {
                            Session[strCrf_TherapyIDName] = intID;
                        }
                    }
                    else
                    {
                        lblError_Crf_Therapy.Text = "Нельзя добавить информацию по антимикробной терапии без информации по диагнозам";
                    }
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteCrf_Therapy_Click(object sender, EventArgs e)
        {
            try
            {
                object intDelID = (MarafonHelper.RecursiveFindParent((sender as Control), typeof(DetailsView)) as DetailsView).SelectedValue;
                Session[strCrf_TherapyIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_TherapyTableName, strCrf_TherapyIDName, intDelID, Session["uid"].ToString());
                int intPageIndex = gvwCrf_Therapy.PageIndex;
                gvwCrf_Therapy.DataBind();
                if (intPageIndex > gvwCrf_Therapy.PageIndex)
                {
                    gvwCrf_Therapy.SelectedIndex = gvwCrf_Therapy.Rows.Count - 1;
                }
                if (gvwCrf_Therapy.SelectedIndex >= gvwCrf_Therapy.Rows.Count - 1)
                {
                    gvwCrf_Therapy.SelectedIndex = gvwCrf_Therapy.Rows.Count - 1;
                }
                SwitchEditing(true);

            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Therapy_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void dvwCrf_Therapy_ItemUpdating(object sender, DetailsViewUpdateEventArgs e)
        {
            try
            {
                //if ((e.NewValues[10] == null) || (e.NewValues[10].ToString() == ""))
                //{
                //    e.NewValues[10] = null;
                //    this.lblError_Crf_Therapy.Text = "Укажите диагноз";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}

                if ((e.NewValues[2] != null) && (e.NewValues[2].ToString() != ""))
                {
                    e.NewValues[2] = decimal.Parse(e.NewValues[2].ToString());
                }

                string strStart_Date = e.NewValues[7].ToString();
                DateTime dtStart_Date = DateTime.Parse(strStart_Date);
                string strEnd_Date;
                DateTime dtEnd_Date;
                if (e.NewValues[8] != null)
                {
                    strEnd_Date = e.NewValues[8].ToString();
                    dtEnd_Date = DateTime.Parse(strEnd_Date);
                }
                else
                {
                    dtEnd_Date = DateTime.MaxValue;
                }

                if (dtEnd_Date < dtStart_Date)
                {
                    this.lblError_Crf_Therapy.Text = "Дата отмены не должна быть меньше даты назначения";
                    e.Cancel = true;
                    SwitchEditing(false);
                    return;
                }
                
                //object objStartDiagnosisDate;
                //object objEndDiagnosisDate;
                //if ((e.NewValues[10] == null) || (e.NewValues[10].ToString() == ""))
                //{
                //    if (GetCrfDiagnosisDates(int.Parse(e.NewValues[10].ToString()), out objStartDiagnosisDate, out objEndDiagnosisDate))
                //    {
                //        DateTime dtStartDiagnosisDate = DateTime.Parse(objStartDiagnosisDate.ToString());
                //        DateTime dtEndDiagnosisDate;
                //        if (objEndDiagnosisDate != null)
                //        {
                //            dtEndDiagnosisDate = DateTime.Parse(objEndDiagnosisDate.ToString());
                //        }
                //        else
                //        {
                //            dtEndDiagnosisDate = DateTime.MaxValue;
                //        }
                //        if ((dtEnd_Date < dtStartDiagnosisDate) || (dtStart_Date < dtStartDiagnosisDate))
                //        {
                //            this.lblError_Crf_Therapy.Text = "Даты назначения и отмены не должна быть меньше даты постановки диагноза";
                //            e.Cancel = true;
                //            SwitchEditing(false);
                //            return;
                //        }
                //        if ((dtEnd_Date > dtEndDiagnosisDate) || (dtStart_Date > dtEndDiagnosisDate))
                //        {
                //            this.lblError_Crf_Therapy.Text = "Даты назначения и отмены не должна быть больше даты окончания диагноза/операции";
                //            e.Cancel = true;
                //            SwitchEditing(false);
                //            return;
                //        }
                //    }
                //}


                //string strPrescription_Date = e.NewValues[7].ToString();
                //DateTime dtPrescription_Date = DateTime.Parse(strPrescription_Date);
                //string strAbolition_Date = e.NewValues[8].ToString();
                //DateTime dtAbolition_Date = DateTime.Parse(strAbolition_Date);
                //if (dtPrescription_Date > DateTime.Now)
                //{
                //    this.lblError_Crf_Therapy.Text = "Дата назначения не должна быть больше текущей даты";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}
                //if (dtPrescription_Date < this.GetCrfDate("Hospitalization_Date_Time"))
                //{
                //    this.lblError_Crf_Therapy.Text = "Дата назначения не должна быть меньше даты госпитализации";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}
                //if (dtAbolition_Date > DateTime.Now)
                //{
                //    this.lblError_Crf_Therapy.Text = "Дата отмены не должна быть  больше текущей даты";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}
                //if (dtAbolition_Date < this.GetCrfDate("Hospitalization_Date_Time"))
                //{
                //    this.lblError_Crf_Therapy.Text = "Дата отмены не должна быть меньше даты госпитализации";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}

                
                //if (dtAbolition_Date < dtPrescription_Date)
                //{
                //    this.lblError_Crf_Therapy.Text = "Дата отмены не должна быть меньше даты назначения";
                //    e.Cancel = true;
                //    SwitchEditing(false);
                //    return;
                //}

            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwCrf_Therapy_ItemCreated(object sender, EventArgs e)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if ((((sender as DetailsView).CurrentMode == DetailsViewMode.Edit) || ((sender as DetailsView).CurrentMode == DetailsViewMode.Insert)) && ((sender as DetailsView).DataKey.Value != null))
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();

                    cmdValues = new SqlCommand(String.Format("SELECT Therapy_Reason_ID,Crf_Diagnosis_ID,Therapy_Type_ID FROM Crf_Therapy WHERE Crf_Therapy_ID={0}", (sender as DetailsView).DataKey.Value == null ? '0' : (sender as DetailsView).DataKey.Value), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "cddTherapy_Reason") as CascadingDropDown).SelectedValue = rdValues.GetInt32(0).ToString();
                            if ((rdValues[1] is DBNull))
                            {
                                (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "cddCrf_Diagnosis") as CascadingDropDown).SelectedValue = "";
                            }
                            else
                            {
                                (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "cddCrf_Diagnosis") as CascadingDropDown).SelectedValue = rdValues.GetInt32(1).ToString();
                            }
                            (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "cddTherapy_Type") as CascadingDropDown).SelectedValue = rdValues.GetInt32(2).ToString();
                        }
                    }
                }
                //if (IsEditing() && ((sender as DetailsView).CurrentMode == DetailsViewMode.ReadOnly) && ((sender as DetailsView).DataKey.Value != null))
                //{
                //    ImageButton btnTemp;
                //    btnTemp = (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "btnEdit") as ImageButton);
                //    btnTemp.Enabled = false;
                //    btnTemp.ImageUrl = "~/images/ico_16_4207_grey.gif";
                //    btnTemp = (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "btnDelete") as ImageButton);
                //    btnTemp.Enabled = false;
                //    btnTemp.ImageUrl = "~/images/16_L_remove_grey.gif";
                //}
                //if (((sender as DetailsView).CurrentMode == DetailsViewMode.Edit) && ((sender as DetailsView).DataKey.Value != null))
                //{
                //    (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "mevPrescription_Date_Time") as AjaxControlToolkit.MaskedEditValidator).MaximumValue = DateTime.Now.ToString("dd.MM.yyyy HH:mm");
                //    (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "mevAbolition_Date_Time") as AjaxControlToolkit.MaskedEditValidator).MaximumValue = DateTime.Now.ToString("dd.MM.yyyy HH:mm");
                //    (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "mevPrescription_Date_Time") as AjaxControlToolkit.MaskedEditValidator).MinimumValue = this.GetCrfDate("Hospitalization_Date_Time").ToString("dd.MM.yyyy HH:mm");
                //    (MarafonHelper.RecursiveFindControl<Control>((sender as Control), "mevAbolition_Date_Time") as AjaxControlToolkit.MaskedEditValidator).MaximumValue = this.GetCrfDate("Hospitalization_Date_Time").ToString("dd.MM.yyyy HH:mm");
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


        protected void dvwCrf_Therapy_ItemDeleted(object sender, DetailsViewDeletedEventArgs e)
        {
            try
            {
                gvwCrf_Therapy.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwCrf_Therapy_ItemUpdated(object sender, DetailsViewUpdatedEventArgs e)
        {
            try
            {
                Session[strCrf_TherapyIDName] = 0;
                gvwCrf_Therapy.DataBind();
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Therapy_SelectedIndexChanging(object sender, GridViewSelectEventArgs e)
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

        protected void btnSaveCrf_Therapy_Click(object sender, EventArgs e)
        {
            try
            {
                //Session[strCrf_TherapyIDName] = 0;
                SwitchEditing(true);
                ClearVerified();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancelCrf_Therapy_Click(object sender, EventArgs e)
        {

            try
            {
                Session[strCrf_TherapyIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_TherapyTableName, strCrf_TherapyIDName, Session[strCrf_TherapyIDName], Session["uid"].ToString());
                int intPageIndex = gvwCrf_Therapy.PageIndex;
                gvwCrf_Therapy.DataBind();
                if (intPageIndex > gvwCrf_Therapy.PageIndex)
                {
                    gvwCrf_Therapy.SelectedIndex = gvwCrf_Therapy.Rows.Count - 1;
                }
                if (gvwCrf_Therapy.SelectedIndex > gvwCrf_Therapy.Rows.Count - 1)
                {
                    gvwCrf_Therapy.SelectedIndex = gvwCrf_Therapy.Rows.Count - 1;
                }
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Therapy_RowCreated(object sender, GridViewRowEventArgs e)
        {
            //try
            //{
            //    if (IsEditing() && (e.Row.RowType == DataControlRowType.DataRow))
            //    {
            //        ImageButton btnTemp;
            //        btnTemp = (MarafonHelper.RecursiveFindControl<Control>(e.Row, "btnSelect") as ImageButton);
            //        btnTemp.Enabled = false;
            //        btnTemp.ImageUrl = "~/images/16_publish_grey.gif";
            //    }
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }

        protected void btnEditCrf_Therapy_Click(object sender, EventArgs e)
        {
            try
            {
                SwitchEditing(false);
                gvwCrf_Therapy.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dvwCrf_Therapy_DataBound(object sender, EventArgs e)
        {
            try
            {
                if (boolRequeryTherapy)
                {
                    (sender as DetailsView).ChangeMode(DetailsViewMode.Edit);
                    boolRequeryTherapy = false;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Therapy_Load(object sender, EventArgs e)
        {
            //try
            //{
            //    dvwCrf_Therapy.DataBind();
            //}
            //catch (Exception ex)
            //{
            //    MarafonHelper.HandleError(this, ex);
            //}
        }

        protected void dvwCrf_Therapy_Load(object sender, EventArgs e)
        {
            //(sender as DetailsView).Enabled = IsEditing();
        }









        protected void gvwCrf_Microbiology_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwCrf_Microbiology_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strCrf_MicrobiologyIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Microbiology_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strCrf_MicrobiologyIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_MicrobiologyTableName, strCrf_MicrobiologyIDName, Session[strCrf_MicrobiologyIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Microbiology_RowCreated(object sender, GridViewRowEventArgs e)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                if (((e.Row.RowState & DataControlRowState.Edit) != 0) && (e.Row.RowType == DataControlRowType.DataRow))
                {
                    cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                    cnnValues.Open();

                    cmdValues = new SqlCommand(String.Format("SELECT Clinical_Material_Group_ID,Clinical_Material_ID FROM VW_INTERFACE_CRF_MICROBIOLOGY WHERE Crf_Microbiology_ID={0}", (e.Row.DataItem) == null ? "0" : (sender as GridView).DataKeys[e.Row.RowIndex].Value), cnnValues);
                    rdValues = cmdValues.ExecuteReader();
                    if (rdValues.HasRows)
                    {
                        while (rdValues.Read())
                        {
                            (MarafonHelper.RecursiveFindControl<Control>((e.Row as Control), "cddClinical_Material_Group") as CascadingDropDown).SelectedValue = rdValues.GetInt32(0).ToString();
                            (MarafonHelper.RecursiveFindControl<Control>((e.Row as Control), "cddClinical_Material") as CascadingDropDown).SelectedValue = rdValues.GetInt32(1).ToString();
                        }
                    }
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

        protected void gvwCrf_Microbiology_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnAddCrf_Microbiology_Click(object sender, System.EventArgs e)
        {
            try
            {
                if ((this.gvwCrf.SelectedValue == null) || !CheckCrfSaved(int.Parse(gvwCrf.SelectedValue.ToString())))
                {
                    this.lblError_Diagnosis_Main.Text = "Не выбрана или не сохранена информация о пациенте - добавление невозможно";
                }
                else if (CheckCrfDiagnosis(int.Parse(this.gvwCrf.SelectedValue.ToString()), 3) <= 0)
                {
                    this.lblError_Microbiology.Text = "Не указаны нозокомиальные инфекции";
                }
                else
                {

                    SwitchEditing(false);
                    int intID = MarafonHelper.AddRecord(this.gvwCrf_Microbiology, "MarafonConnection", strCrf_MicrobiologyTableName, "Crf_ID,SUSER", String.Format("{0},'{1}'", gvwCrf.SelectedValue, Session["uid"]), strCrf_MicrobiologyIDName);
                    if (intID > 0)
                    {
                        Session[strCrf_MicrobiologyIDName] = intID;
                    }
                    //dvwCrf.DataBind();
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteCrf_Microbiology_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strCrf_MicrobiologyIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_MicrobiologyTableName, strCrf_MicrobiologyIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnEditCrf_Microbiology_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(false);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnSaveCrf_Microbiology_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                ClearVerified();
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancelCrf_Microbiology_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Microbiology_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
                int intIs_No_Growth = int.Parse(e.NewValues[4].ToString());
                if ((intIs_No_Growth != 3) && ((sender as GridView).Rows.Count < 2) && ((sender as GridView).PageCount < 2))
                {
                    this.lblError_Microbiology.Text = "Для включения пациента в проект необходим рост МО при первом исследовании";
                    e.Cancel = true;
                    SwitchEditing(false);
                    return;
                }
                object objStartDiagnosisDate;
                object objEndDiagnosisDate;
                if ((GetCrfDiagnosisDates(int.Parse(gvwCrf.SelectedValue.ToString()), 3, out objStartDiagnosisDate, out objEndDiagnosisDate)))
                {
                    DateTime dtStartDate=DateTime.Parse(objStartDiagnosisDate.ToString());
                    dtStartDate.AddMinutes(-dtStartDate.Minute).AddHours(-dtStartDate.Hour);
                    if(DateTime.Parse(e.NewValues[0].ToString()) < dtStartDate)
                    {
                        this.lblError_Microbiology.Text = "Дата исследования должна быть больше даты возникновения нозокомиальной инфекции";
                        e.Cancel = true;
                        SwitchEditing(false);
                        return;
                    }
                }

                DateTime dtMaterialReceivingDate=DateTime.Parse(e.NewValues[0].ToString());
                int intClinicalMaterialID=int.Parse(e.NewValues[1].ToString());
                if (CheckMicrobiologyNosocomial(int.Parse(gvwCrf.SelectedValue.ToString()),intClinicalMaterialID,dtMaterialReceivingDate)<=0)
                {
                    this.lblError_Microbiology.Text = "Выбранная локализация КМ не соответствует ни одной нозокомиальной инфекции на указанную дату";
                    e.Cancel = true;
                    SwitchEditing(false);
                    return;
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }





        protected void gvwCrf_Microbiology_Microbe_RowEditing(object sender, System.Web.UI.WebControls.GridViewEditEventArgs e)
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

        protected void gvwCrf_Microbiology_Microbe_RowUpdated(object sender, System.Web.UI.WebControls.GridViewUpdatedEventArgs e)
        {
            try
            {
                Session[strCrf_Microbiology_MicrobeIDName] = 0;
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Microbiology_Microbe_RowCancelingEdit(object sender, System.Web.UI.WebControls.GridViewCancelEditEventArgs e)
        {
            try
            {
                Session[strCrf_Microbiology_MicrobeIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Microbiology_MicrobeTableName, strCrf_Microbiology_MicrobeIDName, Session[strCrf_Microbiology_MicrobeIDName], Session["uid"].ToString());
                SwitchEditing(true);
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Microbiology_Microbe_RowCreated(object sender, GridViewRowEventArgs e)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
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

        protected void gvwCrf_Microbiology_Microbe_PageIndexChanging(object sender, GridViewPageEventArgs e)
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

        protected void btnAddCrf_Microbiology_Microbe_Click(object sender, System.EventArgs e)
        {
            try
            {
                if (this.gvwCrf_Microbiology.SelectedValue == null)
                {
                    this.lblError_Microbiology_Microbe.Text = "Не выбрана информация о микробиологическом анализе - добавление невозможно";
                }
                else if (CheckMicrobiologyIsMicrobe(int.Parse(this.gvwCrf_Microbiology.SelectedValue.ToString())) <= 0)
                {
                    this.lblError_Microbiology_Microbe.Text = "В микробиологическом анализе указано отсутствие МО";
                }
                else
                {

                    SwitchEditing(false);
                    int intID = MarafonHelper.AddRecord(this.gvwCrf_Microbiology_Microbe, "MarafonConnection", strCrf_Microbiology_MicrobeTableName, "Crf_Microbiology_ID,SUSER", String.Format("{0},'{1}'", gvwCrf_Microbiology.SelectedValue, Session["uid"]), strCrf_Microbiology_MicrobeIDName);
                    if (intID > 0)
                    {
                        Session[strCrf_Microbiology_MicrobeIDName] = intID;
                    }
                    //dvwCrf.DataBind();
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnDeleteCrf_Microbiology_Microbe_Click(object sender, System.Web.UI.ImageClickEventArgs e)
        {
            try
            {
                GridViewRow gvr = (((sender as ImageButton).Parent as DataControlFieldCell).Parent as GridViewRow);
                object intDelID = (gvr.NamingContainer as GridView).DataKeys[gvr.RowIndex].Value;
                Session[strCrf_Microbiology_MicrobeIDName] = MarafonHelper.DelRecord("MarafonConnection", strCrf_Microbiology_MicrobeTableName, strCrf_Microbiology_MicrobeIDName, intDelID, Session["uid"].ToString());
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnEditCrf_Microbiology_Microbe_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(false);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnSaveCrf_Microbiology_Microbe_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                ClearVerified();
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void btnCancelCrf_Microbiology_Microbe_Click(object sender, ImageClickEventArgs e)
        {
            try
            {
                SwitchEditing(true);
                //MarafonHelper.RefreshGridViews((sender as Control));
                //dvwCrf.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Microbiology_Microbe_RowUpdating(object sender, GridViewUpdateEventArgs e)
        {
            try
            {
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_SelectedIndexChanged(object sender, EventArgs e)
        {
            try
            {
                this.gvwCrf_Microbiology.DataBind();
                this.gvwCrf_Therapy.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_PageIndexChanged(object sender, EventArgs e)
        {
            try
            {
                (sender as GridView).SelectedIndex = 0;
                gvwCrf.DataBind();

                //this.gvwCrf_Diagnosis_Main.DataBind();
                //this.gvwCrf_Diagnosis_Nosocomial.DataBind();
                //this.gvwCrf_Diagnosis_Operation.DataBind();
                //this.gvwCrf_Microbiology.DataBind();
                //this.gvwCrf_Microbiology_Microbe.DataBind();
                //this.gvwCrf_Previous_Hospitalisation.DataBind();
                //this.gvwCrf_Risk_Factor.DataBind();
                //this.gvwCrf_Therapy.DataBind();
                //this.gvwCrf_Ward_Transfer.DataBind();
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void gvwCrf_Diagnosis_Main_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            object intDelID = (sender as GridView).DataKeys[e.RowIndex].Value;
            if (CheckDiagnosisAB(int.Parse(intDelID.ToString())) > 0)
            {
                this.lblError_Diagnosis_Main.Text = "Перед удалением диагноза удалите связанную с ним терапию!";
                e.Cancel = true;

            }
        }

        protected void gvwCrf_Diagnosis_Nosocomial_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            object intDelID = (sender as GridView).DataKeys[e.RowIndex].Value;
            if (CheckDiagnosisAB(int.Parse(intDelID.ToString())) > 0)
            {
                this.lblError_Nosocomial.Text = "Перед удалением диагноза удалите связанную с ним терапию!";
                e.Cancel = true;

            }
        }

        protected void gvwCrf_Diagnosis_Operation_RowDeleting(object sender, GridViewDeleteEventArgs e)
        {
            object intDelID = (sender as GridView).DataKeys[e.RowIndex].Value;
            if (CheckDiagnosisAB(int.Parse(intDelID.ToString())) > 0)
            {
                this.lblError_Operation.Text = "Перед удалением диагноза удалите связанную с ним терапию!";
                e.Cancel = true;

            }
        }



    }
}
