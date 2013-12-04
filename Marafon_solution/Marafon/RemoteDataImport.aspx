<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="RemoteDataImport.aspx.cs" Inherits="Marafon.RemoteDataImport" EnableEventValidation="false" Theme="Marafon" Title="Импорт данных" MaintainScrollPositionOnPostback="true" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <title>Импорт данных</title>
    <link href="Styles/aspStyles.css" rel="stylesheet" type="text/css" />
    <link href="Styles/StyleSheet.css" rel="stylesheet" type="text/css" />
</head>
<body>
    <form id="form1" runat="server">
    <div style="text-align:center">
                    
                    <asp:SqlDataSource ID="dsrcUser" runat="server" DataSourceMode="DataReader" 
                        ConnectionString="<%$ ConnectionStrings:MarafonConnection %>" 
                        
                        SelectCommand="SELECT SUSER FROM VW_INTERFACE_WARD_DESCRIPTION GROUP BY SUSER" 
                        ProviderName="<%$ ConnectionStrings:MarafonConnection.ProviderName %>" >
                    </asp:SqlDataSource>
                    
                    <asp:SqlDataSource ID="dsrcWard" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:MarafonConnection %>" 
                        
                        
                        SelectCommand="SELECT CENTER_DESCRIPTION, WARD_ID, WARD_DESCRIPTION, center_number FROM VW_INTERFACE_WARD" 
                        ProviderName="<%$ ConnectionStrings:MarafonConnection.ProviderName %>" >
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsrcTabletPack" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:MarafonConnection %>" 
                        
                        
                        SelectCommand="SELECT TABLET_PACK_ID, TABLET_PACK_DESCRIPTION FROM VW_INTERFACE_TABLET_PACK" 
                        ProviderName="<%$ ConnectionStrings:MarafonConnection.ProviderName %>" >
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsrcPackStore" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:MarafonConnection %>" 
                        
                        InsertCommand="INSERT INTO PACK_STORE(TABLET_PACK_ID,INPUT_NUMBER,WARD_ID,DATE_RECEIVE,PACK_QUANTITY,VALIDATION_SIGN,SUSER) VALUES(@TABLET_PACK_ID,1,@WARD_ID,@DATE_RECEIVE,@PACK_QUANTITY,1,@SUSER)" 
                        ProviderName="<%$ ConnectionStrings:MarafonConnection.ProviderName %>" >
                        <InsertParameters>
                            <asp:Parameter Name="TABLET_PACK_ID" Type="Int32" />
                            <asp:Parameter Name="WARD_ID" Type="Int32" />
                            <asp:Parameter Name="DATE_RECEIVE" Type="DateTime" />
                            <asp:Parameter Name="PACK_QUANTITY" Type="Decimal" />
                            <asp:Parameter Name="SUSER" Type="String" />
                        </InsertParameters>
                    </asp:SqlDataSource>
                    <asp:Table ID="tblSetup" runat="server" GridLines="Both">
                        <asp:TableRow ID="TableRow1" runat="server">
                            <asp:TableCell ID="TableCell1" runat="server">
                                <asp:Label ID="lblXLS" runat="server" Text="Файл для импорта: "></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell ID="TableCell2" runat="server">
                                <asp:FileUpload id="fulXLS" runat="server" />
                            </asp:TableCell>
                        </asp:TableRow>
                        <asp:TableRow ID="TableRow2" runat="server">
                            <asp:TableCell ID="TableCell3" runat="server">
                                <asp:Label ID="Label1" runat="server" Text="Пользователь: "></asp:Label>
                            </asp:TableCell>
                            <asp:TableCell ID="TableCell4" runat="server">
                                <asp:DropDownList ID="ddlUser" runat="server" 
                                DataSourceID="dsrcUser" DataTextField="SUSER" DataValueField="SUSER"></asp:DropDownList>                                </asp:TableCell>
                        </asp:TableRow>
                    </asp:Table>
    
                    
    
                            <asp:Label ID="lblErrors" runat="server" style="font-weight: 700; font-size: medium;" 
                                Text="Ошибки импорта"></asp:Label>
                            <asp:Table ID="tblErrors" runat="server" GridLines="Both" 
                                HorizontalAlign="Center">
                                <asp:TableRow ID="TableRow3" runat="server" TableSection="TableHeader" Font-Bold="True">
                                    <asp:TableCell ID="TableCell5" runat="server">Номер строки</asp:TableCell>
                                    <asp:TableCell ID="TableCell6" runat="server">Описание ошибки</asp:TableCell>
                                </asp:TableRow>
                            </asp:Table>
                            <asp:Label ID="lblImportResult" runat="server" 
                        style="font-weight: 700; color: #003399; font-size: medium"></asp:Label>
                    <br />
                            <asp:Button ID="btnXLS" runat="server" Text="Импорт" 
                        onclick="btnXLS_Click" />
                            <asp:Button ID="btnReturn" runat="server" 
                        Text="Вернуться к потреблению" PostBackUrl="~/PackStore.aspx" />
    </div>
    </form>
</body>
</html>
