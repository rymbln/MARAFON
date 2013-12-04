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
    /// Сводное описание для GetYearAndQuarter
    /// </summary>
    [WebService(Namespace = "http://tempuri.org/")]
    [WebServiceBinding(ConformsTo = WsiProfiles.BasicProfile1_1)]
    [System.ComponentModel.ToolboxItem(false)]
    [System.Web.Script.Services.ScriptService]
    public class GetYearQuarter : System.Web.Services.WebService
    {

        [WebMethod(EnableSession = true)]
        public AjaxControlToolkit.CascadingDropDownNameValue[] GetYearAndQuarter(string knownCategoryValues, string category)
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
                    case "YEAR":
                        strSQL = String.Format("SELECT CAST(PACK_STORE_YEAR AS NVARCHAR(10)) AS YEAR_DESCRIPTION,CAST(PACK_STORE_YEAR AS NVARCHAR(10)) AS YEAR_ID FROM VW_INTERFACE_YEAR_QUARTER_USER WHERE UserName=N'{0}' GROUP BY PACK_STORE_YEAR ORDER BY PACK_STORE_YEAR", Session["uid"]);
                        break;
                    case "QUARTER":
                        strSQL = String.Format("SELECT Q.DESCRIPTION,CAST(PSQ.PACK_STORE_QUARTER AS NVARCHAR(10)) AS PACK_STORE_QUARTER FROM VW_INTERFACE_YEAR_QUARTER_USER PSQ INNER JOIN QUARTER Q ON PSQ.PACK_STORE_QUARTER=Q.QUARTER_ID WHERE PSQ.UserName=N'{0}' AND PSQ.PACK_STORE_YEAR={1} GROUP BY PSQ.PACK_STORE_QUARTER,Q.DESCRIPTION ORDER BY PSQ.PACK_STORE_QUARTER,Q.DESCRIPTION", Session["uid"], Int32.Parse(prm["YEAR"]).ToString());
                        break;
                    default:
                        strSQL = String.Format("SELECT CAST(PACK_STORE_YEAR AS NVARCHAR(10)) AS YEAR_DESCRIPTION,CAST(PACK_STORE_YEAR AS NVARCHAR(10)) AS YEAR_ID FROM VW_INTERFACE_YEAR_QUARTER_USER WHERE UserName=N'{0}' GROUP BY PACK_STORE_YEAR ORDER BY PACK_STORE_YEAR", Session["uid"]);
                        break;
                }
                cmdValues = new SqlCommand(strSQL, cnnValues);
                rdValues = cmdValues.ExecuteReader();
                while (rdValues.Read())
                {
                    values.Add(new AjaxControlToolkit.CascadingDropDownNameValue(rdValues.GetString(0), rdValues.GetString(1)));
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
    }
}
