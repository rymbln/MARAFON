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
    /// Сводное описание для GetAutoComplete
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    // Чтобы разрешить вызывать веб-службу из скрипта с помощью ASP.NET AJAX, раскомментируйте следующую строку. 
    [System.Web.Script.Services.ScriptService]
    public class GetAutoComplete : System.Web.Services.WebService
    {

        [WebMethod(EnableSession = true)]
        public string[] GetCrf_Diagnosis_Main(string prefixText, int count)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                List<string> strValues = new List<string>();
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                cnnValues.Open();
                cmdValues = new SqlCommand(String.Format("select diagnosis_text from crf_diagnosis where diagnosis_type_id=2 and suser='{0}' and diagnosis_text like '%{1}%' group by diagnosis_text", Session["uid"], prefixText), cnnValues);
                rdValues = cmdValues.ExecuteReader();
                if (rdValues.HasRows)
                {
                    while (rdValues.Read())
                    {
                        strValues.Add(String.Format("{0}", rdValues[0]));
                    }
                }
                return strValues.ToArray();
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
        public string[] GetCrf_Diagnosis_Nosocomial(string prefixText, int count)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                List<string> strValues = new List<string>();
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                cnnValues.Open();
                cmdValues = new SqlCommand(String.Format("select diagnosis_text from crf_diagnosis where diagnosis_type_id=3 and suser='{0}' and diagnosis_text like '%{1}%' group by diagnosis_text", Session["uid"], prefixText), cnnValues);
                rdValues = cmdValues.ExecuteReader();
                if (rdValues.HasRows)
                {
                    while (rdValues.Read())
                    {
                        strValues.Add(String.Format("{0}", rdValues[0]));
                    }
                }
                return strValues.ToArray();
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
        public string[] GetCrf_Diagnosis_Operation(string prefixText, int count)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                List<string> strValues = new List<string>();
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                cnnValues.Open();
                cmdValues = new SqlCommand(String.Format("select diagnosis_text from crf_diagnosis where diagnosis_type_id=4 and suser='{0}' and diagnosis_text like '%{1}%' group by diagnosis_text", Session["uid"], prefixText), cnnValues);
                rdValues = cmdValues.ExecuteReader();
                if (rdValues.HasRows)
                {
                    while (rdValues.Read())
                    {
                        strValues.Add(String.Format("{0}", rdValues[0]));
                    }
                }
                return strValues.ToArray();
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
        public string[] GetCrf_Ward_Transfer(string prefixText, int count)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                List<string> strValues = new List<string>();
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                cnnValues.Open();
                cmdValues = new SqlCommand(String.Format("select ward_name from crf_ward_transfer where suser='{0}' and ward_name like '%{1}%' group by ward_name", Session["uid"], prefixText), cnnValues);
                rdValues = cmdValues.ExecuteReader();
                if (rdValues.HasRows)
                {
                    while (rdValues.Read())
                    {
                        strValues.Add(String.Format("{0}", rdValues[0]));
                    }
                }
                return strValues.ToArray();
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
        public string[] GetCrf_Previous_Hospitalization_City(string prefixText, int count)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                List<string> strValues = new List<string>();
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                cnnValues.Open();
                cmdValues = new SqlCommand(String.Format("select city_name from crf_previous_hospitalisation where suser='{0}' and city_name like '%{1}%' group by city_name", Session["uid"], prefixText), cnnValues);
                rdValues = cmdValues.ExecuteReader();
                if (rdValues.HasRows)
                {
                    while (rdValues.Read())
                    {
                        strValues.Add(String.Format("{0}", rdValues[0]));
                    }
                }
                return strValues.ToArray();
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
        public string[] GetCrf_Previous_Hospitalization_Stationar(string prefixText, int count)
        {
            SqlConnection cnnValues = null;
            SqlCommand cmdValues = null;
            SqlDataReader rdValues = null;
            try
            {
                List<string> strValues = new List<string>();
                cnnValues = new SqlConnection(ConfigurationManager.ConnectionStrings["MarafonConnection"].ConnectionString);
                cnnValues.Open();
                cmdValues = new SqlCommand(String.Format("select stationar_name from crf_previous_hospitalisation where suser='{0}' and stationar_name like '%{1}%' group by stationar_name", Session["uid"], prefixText), cnnValues);
                rdValues = cmdValues.ExecuteReader();
                if (rdValues.HasRows)
                {
                    while (rdValues.Read())
                    {
                        strValues.Add(String.Format("{0}", rdValues[0]));
                    }
                }
                return strValues.ToArray();
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
    
    
    }
}
