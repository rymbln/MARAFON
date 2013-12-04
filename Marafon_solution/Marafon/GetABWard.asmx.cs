using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Services;
using System.Data.SqlClient;
using System.Configuration;

namespace Marafon
{
    /// <summary>
    /// Сводное описание для GetABWard
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class GetABWard : System.Web.Services.WebService
    {

        [WebMethod (EnableSession=true)]
        public AjaxControlToolkit.CascadingDropDownNameValue[] GetDropDownAB(string knownCategoryValues, string category)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                string strSQL="";
                List<AjaxControlToolkit.CascadingDropDownNameValue> values =  new List<AjaxControlToolkit.CascadingDropDownNameValue>();
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                cnnValues.Open();
                System.Collections.Specialized.StringDictionary prm = new System.Collections.Specialized.StringDictionary();
                prm = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
                switch (category)
	            {
                    case "TRADE_AB":
                        strSQL = "SELECT TRADE_AB_DESCRIPTION,TRADE_AB_ID FROM VW_INTERFACE_AB GROUP BY TRADE_AB_DESCRIPTION,TRADE_AB_ID ORDER BY TRADE_AB_DESCRIPTION";
                        break;
                    case "TABLET_PACK":
                        strSQL = String.Format("SELECT TABLET_PACK_DESCRIPTION,TABLET_PACK_ID FROM VW_INTERFACE_AB WHERE TRADE_AB_ID={0} AND TRADE_AB_ID IS NOT NULL", Int32.Parse(prm["TRADE_AB"]).ToString());
                        break;
                    default:
                        strSQL = "SELECT TRADE_AB_DESCRIPTION,TRADE_AB_ID FROM VW_INTERFACE_AB GROUP BY TRADE_AB_DESCRIPTION,TRADE_AB_ID ORDER BY TRADE_AB_DESCRIPTION";
                        break;
                }
                cmdValues = new SqlCommand(strSQL,cnnValues);
                rdValues = cmdValues.ExecuteReader();
                while (rdValues.Read())
                {
                    values.Add(new AjaxControlToolkit.CascadingDropDownNameValue((rdValues.GetString(0) == null) ? "-" : rdValues.GetString(0), rdValues.GetInt32(1).ToString()));
                }
                return values.ToArray();
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

        [WebMethod(EnableSession = true)]
        public AjaxControlToolkit.CascadingDropDownNameValue[] GetDropDownWard(string knownCategoryValues, string category)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                string strSQL = "";
                List<AjaxControlToolkit.CascadingDropDownNameValue> values = new List<AjaxControlToolkit.CascadingDropDownNameValue>();
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                cnnValues.Open();
                System.Collections.Specialized.StringDictionary prm = new System.Collections.Specialized.StringDictionary();
                prm = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
                Int32 intTradeABID;
                switch (category)
                {
                    case "CENTER":
                        strSQL = "SELECT CENTER_DESCRIPTION,CENTER_ID FROM VW_INTERFACE_WARD GROUP BY CENTER_DESCRIPTION,CENTER_ID ORDER BY CENTER_DESCRIPTION";
                        break;
                    case "WARD":
                        strSQL = String.Format("SELECT WARD_DESCRIPTION,WARD_ID FROM VW_INTERFACE_WARD WHERE CENTER_ID={0} GROUP BY WARD_DESCRIPTION,WARD_ID ORDER BY WARD_DESCRIPTION", Int32.TryParse(prm["CENTER"].ToString(), out intTradeABID));
                        break;
                    default:
                        strSQL = "SELECT CENTER_DESCRIPTION,CENTER_ID FROM VW_INTERFACE_WARD GROUP BY CENTER_DESCRIPTION,CENTER_ID ORDER BY CENTER_DESCRIPTION";
                        break;
                }
                cmdValues = new SqlCommand(strSQL,cnnValues);
                rdValues = cmdValues.ExecuteReader();
                while (rdValues.Read())
                {
                    values.Add(new AjaxControlToolkit.CascadingDropDownNameValue(rdValues.GetString(0), rdValues.GetInt32(1).ToString()));
                }
                return values.ToArray();
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

        [WebMethod(EnableSession = true)]
        public AjaxControlToolkit.CascadingDropDownNameValue[] GetDropDownTherapy(string knownCategoryValues, string category)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                int intTherapy_ReasonID;
                string strSQL = "";
                List<AjaxControlToolkit.CascadingDropDownNameValue> values = new List<AjaxControlToolkit.CascadingDropDownNameValue>();
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                cnnValues.Open();
                System.Collections.Specialized.StringDictionary prm = new System.Collections.Specialized.StringDictionary();
                prm = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
                switch (category)
                {
                    case "Therapy_Reason":
                        strSQL = "SELECT DESCRIPTION, Therapy_Reason_ID FROM dbo.Therapy_Reason ORDER BY DESCRIPTION";
                        break;
                    case "Crf_Diagnosis":
                        if ((Int32.TryParse(prm["Therapy_Reason"].ToString(), out intTherapy_ReasonID)) && (intTherapy_ReasonID == 3))
                        {
                            strSQL = String.Format("(SELECT CASE diagnosis.description WHEN N'Другой' THEN N'' ELSE diagnosis.description END + ISNULL(CASE diagnosis.description WHEN N'Другой' THEN N'' ELSE N' ' END + crf_diagnosis.diagnosis_text, N'') as diagnosis_text, Crf_Diagnosis_ID FROM Crf_Diagnosis inner join diagnosis on Crf_Diagnosis.diagnosis_id=diagnosis.diagnosis_id WHERE crf_id={0} AND diagnosis_type_id<>4) ORDER BY Crf_Diagnosis_ID", Int32.Parse(Session["Current_Crf_ID"].ToString()));
                        }
                        else
                        {
                            strSQL = String.Format("(SELECT CASE diagnosis.description WHEN N'Другой' THEN N'' ELSE diagnosis.description END + ISNULL(CASE diagnosis.description WHEN N'Другой' THEN N'' ELSE N' ' END + crf_diagnosis.diagnosis_text, N'') as diagnosis_text, Crf_Diagnosis_ID FROM Crf_Diagnosis inner join diagnosis on Crf_Diagnosis.diagnosis_id=diagnosis.diagnosis_id WHERE crf_id={0}) ORDER BY Crf_Diagnosis_ID", Int32.Parse(Session["Current_Crf_ID"].ToString()));
                        }
                        break;
                    case "Therapy_Type":
                        if ((Int32.TryParse(prm["Therapy_Reason"].ToString(), out intTherapy_ReasonID)) && (intTherapy_ReasonID == 2))
                        {
                            strSQL = String.Format("SELECT DESCRIPTION, Therapy_Type_ID FROM dbo.Therapy_Type WHERE therapy_type_id=2 ORDER BY DESCRIPTION");
                        }
                        else
                        {
                            strSQL = String.Format("SELECT DESCRIPTION, Therapy_Type_ID FROM dbo.Therapy_Type ORDER BY DESCRIPTION");
                        }
                        break;
                    default:
                        strSQL = "SELECT DESCRIPTION, Therapy_Reason_ID FROM dbo.Therapy_Reason ORDER BY DESCRIPTION";
                        break;
                }
                cmdValues = new SqlCommand(strSQL, cnnValues);
                rdValues = cmdValues.ExecuteReader();
                while (rdValues.Read())
                {
                    values.Add(new AjaxControlToolkit.CascadingDropDownNameValue((rdValues[0] is DBNull) ? "-" : rdValues.GetString(0), (rdValues[1] is DBNull) ? "" : rdValues.GetInt32(1).ToString()));
                }
                return values.ToArray();
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

        [WebMethod(EnableSession = true)]
        public AjaxControlToolkit.CascadingDropDownNameValue[] GetDropDownClinicalMaterial(string knownCategoryValues, string category)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                string strSQL = "";
                List<AjaxControlToolkit.CascadingDropDownNameValue> values = new List<AjaxControlToolkit.CascadingDropDownNameValue>();
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                cnnValues.Open();
                System.Collections.Specialized.StringDictionary prm = new System.Collections.Specialized.StringDictionary();
                prm = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
                switch (category)
                {
                    case "Nosocomial_Infection":
                        strSQL = "SELECT DESCRIPTION,Clinical_Material_Group_ID FROM Clinical_Material_Group ORDER BY DESCRIPTION";
                        break;
                    case "Clinical_Material_Group":
                        strSQL = "SELECT DESCRIPTION,Clinical_Material_Group_ID FROM Clinical_Material_Group ORDER BY DESCRIPTION";
                        break;
                    case "Clinical_Material":
                        strSQL = String.Format("SELECT DESCRIPTION,Clinical_Material_ID FROM Clinical_Material WHERE Clinical_Material_Group_ID={0} ORDER BY DESCRIPTION", Int32.Parse(prm["Clinical_Material_Group"].ToString()));
                        break;
                    default:
                        strSQL = "SELECT DESCRIPTION,Clinical_Material_Group_ID FROM Clinical_Material_Group ORDER BY DESCRIPTION";
                        break;
                }
                cmdValues = new SqlCommand(strSQL, cnnValues);
                rdValues = cmdValues.ExecuteReader();
                while (rdValues.Read())
                {
                    values.Add(new AjaxControlToolkit.CascadingDropDownNameValue(rdValues.GetString(0), rdValues.GetInt32(1).ToString()));
                }
                return values.ToArray();
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


        //[WebMethod(EnableSession = true)]
        //public AjaxControlToolkit.CascadingDropDownNameValue[] GetDropDownDiagnosisNosocomial(string knownCategoryValues, string category)
        //{
        //    SqlConnection cnnValues = null;
        //    SqlCommand cmdValues = null;
        //    SqlDataReader rdValues = null;
        //    try
        //    {
        //        string strSQL = "";
        //        List<AjaxControlToolkit.CascadingDropDownNameValue> values = new List<AjaxControlToolkit.CascadingDropDownNameValue>();
        //        cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
        //        cnnValues.Open();
        //        System.Collections.Specialized.StringDictionary prm = new System.Collections.Specialized.StringDictionary();
        //        prm = AjaxControlToolkit.CascadingDropDown.ParseKnownCategoryValuesString(knownCategoryValues);
        //        switch (category)
        //        {
        //            case "Diagnosis":
        //                strSQL = String.Format("SELECT diagnosis_text,crf_diagnosis_id FROM crf_diagnosis WHERE crf_id={0} AND diagnosis_type_id=3 ORDER BY diagnosis_text", Int32.Parse(Session["Current_Crf_ID"].ToString()));
        //                break;
        //            default:
        //                strSQL = String.Format("SELECT diagnosis_text,crf_diagnosis_id FROM crf_diagnosis WHERE crf_id={0} AND diagnosis_type_id=3 ORDER BY diagnosis_text", Int32.Parse(Session["Current_Crf_ID"].ToString()));
        //                break;
        //        }
        //        cmdValues = new SqlCommand(strSQL, cnnValues);
        //        rdValues = cmdValues.ExecuteReader();
        //        while (rdValues.Read())
        //        {
        //            values.Add(new AjaxControlToolkit.CascadingDropDownNameValue(rdValues.GetString(0), rdValues.GetInt32(1).ToString()));
        //        }
        //        return values.ToArray();
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


    }
}
