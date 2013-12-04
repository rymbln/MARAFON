using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Office.Interop.Excel;
using System.Web.Services;
using AjaxControlToolkit;
using System.Web.Services.Protocols;
using System.Data.SqlClient;
using System.Collections;
using System.Xml;
using System.Data;
using System.IO;
using System.Text;

namespace Marafon
{
    public partial class FormalReport : System.Web.UI.Page
    {
       private Microsoft.Office.Interop.Excel.Application CreateExcelObj()
       {
           object obj;
           obj = null;
           try
           {
               obj = Server.CreateObject("Excel.Application");
           }
           catch (Exception ex)
           {
               throw new Exception("Ошибка создания экземпляра MS Excel");
           }
           return (obj as Microsoft.Office.Interop.Excel.Application);
       }

       private Microsoft.Office.Interop.Excel.Workbook OpenExcelFile(string Path, Microsoft.Office.Interop.Excel.Application objExcel)
       {
           string ExcelFile=CopyFileToTmp(Path);
           Microsoft.Office.Interop.Excel.Workbook ExcelBook=null;
           try
           {
               System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");
               ExcelBook = objExcel.Workbooks.Open(ExcelFile);
           }
           catch (Exception ex)
           {
               throw ex;
           }
           return ExcelBook;
       }

        private string CopyFileToTmp(string Path)
        {
            FileInfo ExcelFile = new FileInfo(Path);
            string ExcelFileTmp = "";
            if (!ExcelFile.Exists)
            {
                throw new FileNotFoundException();
            }
            ExcelFileTmp = Server.MapPath("") + "\\App_Files\\source_report_" + UniqueFilePathSuffix.ToString() + ".xls"; // + DateTime.Now.ToString("yyyy'_'MM'_'dd'_'HH'_'mm'_'ss'_'ffff")
            File.Copy(Path, ExcelFileTmp, true);
            return ExcelFileTmp;
        }

        private void SendFileToUser(string Path, string FileName)
        {
            this.Response.HeaderEncoding = UnicodeEncoding.Default;
            this.Response.AddHeader("Content-Disposition", "attachment; filename=" + FileName);
            this.Response.ContentType = "application/octet-stream";
            this.Response.Clear();
            this.Response.Cache.SetCacheability(HttpCacheability.Public);
            this.Response.BufferOutput = false;
           try
           {
                this.Response.WriteFile(Path);
                File.Delete(Path);
           }
           catch (Exception ex)
           {
               throw ex;
           }
        }

        private void BuildExcelSheet(SqlDataSource dsrcDataSource, Microsoft.Office.Interop.Excel.Workbook ExcelBook, int intSheetNumber, int intChartNumber)
        {
            DataView dvwSource = (dsrcDataSource.Select(DataSourceSelectArguments.Empty) as DataView);
            if (dvwSource != null)
            {
                Microsoft.Office.Interop.Excel.Worksheet ExcelSheet = (ExcelBook.Sheets.Item[intSheetNumber] as Microsoft.Office.Interop.Excel.Worksheet);
                int intRows;
                int intColumns;
                int intRowsCount = 0;
                int intColumnsCount = 0;

                intRowsCount = dvwSource.Table.Rows.Count;
                intColumnsCount = dvwSource.Table.Columns.Count;

                Microsoft.Office.Interop.Excel.Range ExcelRange = ExcelSheet.Range[ExcelSheet.Cells[3, 1], ExcelSheet.Cells[intRowsCount + 3, intColumnsCount]];
                for (intColumns = 0; intColumns<intColumnsCount; intColumns++)
                {
                    ExcelRange.Cells[1, intColumns + 1] = dvwSource.Table.Columns[intColumns].Caption.ToString();
                }
                for (intRows = 0; intRows<intRowsCount; intRows++)
                {
                    for (intColumns = 0; intColumns<intColumnsCount; intColumns++)
                    {
                        ExcelRange.Cells[intRows + 2, intColumns + 1] = dvwSource.Table.Rows[intRows].ItemArray[intColumns];
                    }
                }
                Microsoft.Office.Interop.Excel.Chart ExcelDiagram = (ExcelBook.Charts[intChartNumber] as Microsoft.Office.Interop.Excel.Chart);
                ExcelDiagram.SetSourceData(ExcelRange);
                ExcelRange = null;
            }
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

        protected void dsrcFormalReport1_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            try
            {
                e.Command.CommandTimeout = 5000;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dsrcFormalReport2_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            try
            {
                e.Command.CommandTimeout = 5000;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }

        protected void dsrcFormalReport3_Selecting(object sender, SqlDataSourceSelectingEventArgs e)
        {
            try
            {
                e.Command.CommandTimeout = 5000;
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }

        }

        protected void btnGetFormalReport_Click(object sender, EventArgs e)
        {
            try
            {
                Microsoft.Office.Interop.Excel.Application ExcelObj  = CreateExcelObj();
                Microsoft.Office.Interop.Excel.Workbook ExcelBook = OpenExcelFile(Server.MapPath("") + "\\App_Files\\source_report.xls", ExcelObj);
                try
                {
                    BuildExcelSheet(dsrcFormalReport1, ExcelBook, 1, 1);
                    BuildExcelSheet(dsrcFormalReport2, ExcelBook, 3, 2);
                    BuildExcelSheet(dsrcFormalReport3, ExcelBook, 5, 3);

                    string ExcelFileTmp = ExcelBook.FullName;
                    ExcelBook.Save();
                    ExcelBook.Close();
                    ExcelObj.Quit();
                    ExcelBook = null;
                    ExcelObj = null;
                    SendFileToUser(ExcelFileTmp, "Report.xls");
                }
                finally
                {
                    if(!(ExcelBook==null))
                    {
                        ExcelBook.Save();
                        ExcelBook.Close(); //Закрываем книгу
                        ExcelBook = null; //Уничтожаем ссылку на экземпляр книги
                    }
                    if(!(ExcelObj==null))
                    {
                        ExcelObj.Quit(); //Выходим из приложения 
                        ExcelObj = null; //Уничтожаем ссылку на экземпляр Excel
                    }
                }
            }
            catch (Exception ex)
            {
                MarafonHelper.HandleError(this, ex);
            }
        }
    }
}