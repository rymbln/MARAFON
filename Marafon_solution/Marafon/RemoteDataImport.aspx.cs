using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using Microsoft.Office.Interop;
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
    public partial class RemoteDataImport : System.Web.UI.Page
    {
        private Microsoft.Office.Interop.Excel.Application GetExcelObj()
        {
            object obj;
            obj = null;
            try
            {
                obj = Server.CreateObject("Excel.Application");
            }
            catch (Exception ex)
            {
                //throw new Exception("Ошибка создания экземпляра MS Excel " + ex.Message + " | " + ex.InnerException);
                throw ex;
            }
            return (obj as Microsoft.Office.Interop.Excel.Application);
        }

        private Microsoft.Office.Interop.Excel.Workbook OpenExcelFile(string Path, Microsoft.Office.Interop.Excel.Application objExcel)
        {
            Microsoft.Office.Interop.Excel.Workbook ExcelBook=null;
            try
            {
                System.Threading.Thread.CurrentThread.CurrentCulture = new System.Globalization.CultureInfo("en-US");
                ExcelBook = objExcel.Workbooks.Open(Path);
            }
            catch (Exception ex)
            {
                ExcelBook = null;
                throw ex;
            }
            return ExcelBook;
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

        private TableRow GetErrorRow(int intRowNum, string strError)
        {
            TableRow trError;
            TableCell tcError;

            trError = new TableRow();
            tcError = new TableCell();
            tcError.Text = intRowNum.ToString();
            trError.Cells.Add(tcError);
            tcError = new TableCell();
            tcError.Text = strError;
            trError.Cells.Add(tcError);
            return trError;
        }

        protected void btnXLS_Click(object sender, EventArgs e)
        {
            Microsoft.Office.Interop.Excel.Application xlsImport = null;
            Microsoft.Office.Interop.Excel.Workbook wbkImport = null;
            try
            {
                string strSavedFilePath = Server.MapPath("App_Data") + "\\DataImport_" + DateTime.Now.ToString("dd_MM_yyyy_hh_mm_ss") + ".xls";
                if (fulXLS.PostedFile != null)
                {
                    if (fulXLS.PostedFile.ContentLength > 0)
                    {
                       // if(fulXLS.PostedFile.ContentType == "application/vnd.ms-excel")
                        if (fulXLS.PostedFile.FileName.Contains(".xls") == true)
                        {
                            fulXLS.PostedFile.SaveAs(strSavedFilePath);
                            xlsImport = GetExcelObj();
                            wbkImport = OpenExcelFile(strSavedFilePath, xlsImport);
                            DataView dvwTabletPack = (dsrcTabletPack.Select(DataSourceSelectArguments.Empty) as DataView);
                            dvwTabletPack.Sort = "TABLET_PACK_DESCRIPTION";
                            DataView  dvwWard = (dsrcWard.Select(DataSourceSelectArguments.Empty) as DataView);
                            dvwWard.Sort = "CENTER_DESCRIPTION,WARD_DESCRIPTION";

                            bool boolErrorSign = false;
                            int intTabletPackID = 0;
                            int intWardID = 0;
                            decimal decPackAmount;
                            DateTime dtDateReceive;
                            int intInsertResult;

                            int intRows;
                            Microsoft.Office.Interop.Excel.Worksheet shtImport = (wbkImport.Sheets.Item[1] as Microsoft.Office.Interop.Excel.Worksheet);
                            int maxRows = 1000;
                           // for (intRows = 2; intRows<=shtImport.Rows.Count; intRows++) - так было у Романа
                            for (intRows = 2; intRows <= maxRows; intRows++) // Так будет у меня
                            {
                                if ((shtImport.Cells[intRows, 1] as Microsoft.Office.Interop.Excel.Range).Value != null)
                                {
                                    boolErrorSign = false;
                                    dvwWard.RowFilter = String.Format("CENTER_NUMBER={0}", (shtImport.Cells[intRows, 1] as Microsoft.Office.Interop.Excel.Range).Value);
                                    if (dvwWard.Count > 0)
                                    {
                                        intWardID = int.Parse(dvwWard[0].Row.ItemArray[1].ToString());
                                    }
                                    else
                                    {
                                        boolErrorSign = true;
                                        tblErrors.Rows.Add(GetErrorRow(intRows, "Не найден центр/отделение"));
                                    }

                                    dvwTabletPack.RowFilter = String.Format("TABLET_PACK_DESCRIPTION='{0}'", (shtImport.Cells[intRows, 4] as Microsoft.Office.Interop.Excel.Range).Value);
                                    if (dvwTabletPack.Count > 0)
                                    {
                                        intTabletPackID = int.Parse(dvwTabletPack[0].Row.ItemArray[0].ToString());
                                    }
                                    else
                                    {
                                        boolErrorSign = true;
                                        tblErrors.Rows.Add(GetErrorRow(intRows, "Не найден препарат"));
                                    }

                                    if (!decimal.TryParse((shtImport.Cells[intRows, 3] as Microsoft.Office.Interop.Excel.Range).Value.ToString(), out decPackAmount))
                                    {
                                        boolErrorSign = true;
                                        tblErrors.Rows.Add(GetErrorRow(intRows, "Количество упаковок не является числом"));
                                    }
                                    if (!DateTime.TryParse((shtImport.Cells[intRows, 2] as Microsoft.Office.Interop.Excel.Range).Value.ToString(), out dtDateReceive))
                                    {
                                        boolErrorSign = true;
                                        tblErrors.Rows.Add(GetErrorRow(intRows, "Дата получения не является датой"));
                                    }

                                    if (!boolErrorSign)
                                    {
                                        dsrcPackStore.InsertParameters["WARD_ID"].DefaultValue = intWardID.ToString();
                                        dsrcPackStore.InsertParameters["TABLET_PACK_ID"].DefaultValue = intTabletPackID.ToString();
                                        dsrcPackStore.InsertParameters["PACK_QUANTITY"].DefaultValue = decPackAmount.ToString();
                                        dsrcPackStore.InsertParameters["DATE_RECEIVE"].DefaultValue = dtDateReceive.ToString();
                                        dsrcPackStore.InsertParameters["SUSER"].DefaultValue = ddlUser.SelectedValue.ToString();
                                        intInsertResult = dsrcPackStore.Insert();
                                    }
                                }
                            }

                            wbkImport.Close(); //Закрываем книгу
                            xlsImport.Quit(); //Выходим из приложения 
                            wbkImport = null; //Уничтожаем ссылку на экземпляр книги
                            xlsImport = null; //Уничтожаем ссылку на экземпляр Excel

                            lblImportResult.Text = "Импорт завершен";
                        }
                        else
                        {
                            lblImportResult.Text = "Файл не является файлом Excel";
                        }
                    }
                    else
                    {
                        lblImportResult.Text = "Файл не содержит данных";
                    }
                }
                else
                {
                    lblImportResult.Text = "Файл не выбран";
                }
            }
            catch (Exception ex)
            {
                if (wbkImport != null)
                {
                    wbkImport.Close(); //Закрываем книгу
                    wbkImport = null; //Уничтожаем ссылку на экземпляр книги
                }
                if (xlsImport != null)
                {
                    xlsImport.Quit(); //Выходим из приложения 
                    xlsImport = null; //Уничтожаем ссылку на экземпляр Excel
                }
                MarafonHelper.HandleError(this, ex);
            }
        }

        




    }
}