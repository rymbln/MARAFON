<%@ Page Title="Формализованный отчет" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="FormalReport.aspx.cs" Inherits="Marafon.FormalReport"
 EnableEventValidation="false" Theme="Marafon" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <div style="text-align:left">
    
                    <asp:SqlDataSource ID="dsrcFormalReport1" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:MarafonConnection %>" 
                        ProviderName="System.Data.SqlClient" SelectCommand="DBO.procGetStatisticsGrid" 
                        SelectCommandType="StoredProcedure" 
                        onselecting="dsrcFormalReport1_Selecting">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_ATC_CODE" Type="Int32" />
                            <asp:Parameter DefaultValue="3" Name="INT_ATC_CODE_DIGIT" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="IS_DID_100" Type="Int32" />
                            <%--<asp:Parameter DefaultValue="1" Name="IS_WARD" Type="Int32" />--%>
                            <asp:Parameter DefaultValue="0" Name="IS_DID_PERCENT" Type="Int32" />
                            <asp:Parameter DefaultValue="2" Name="IS_QUARTER" />
                            <asp:Parameter DefaultValue="1" Name="IS_REPORT" Type="Byte" />

                            <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                            <asp:ControlParameter ControlID="ddlSelectQuarter" Name="STR_QUARTER" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddlSelectYear" Name="STR_YEAR" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsrcFormalReport2" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:MarafonConnection %>" 
                        ProviderName="System.Data.SqlClient" SelectCommand="DBO.procGetStatisticsGrid" 
                        SelectCommandType="StoredProcedure" 
                        onselecting="dsrcFormalReport2_Selecting">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_ATC_CODE" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="INT_VARIANT_NUMBER" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="IS_DID_100" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="IS_DID_PERCENT" Type="Int32" />
                            <%--<asp:Parameter DefaultValue="1" Name="IS_WARD" Type="Int32" />--%>
                            <asp:Parameter DefaultValue="2" Name="IS_QUARTER" />
                            <asp:Parameter DefaultValue="1" Name="IS_REPORT" Type="Byte" />

                            <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                            <asp:ControlParameter ControlID="ddlSelectQuarter" Name="STR_QUARTER" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddlSelectYear" Name="STR_YEAR" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>
                    <asp:SqlDataSource ID="dsrcFormalReport3" runat="server" 
                        ConnectionString="<%$ ConnectionStrings:MarafonConnection %>" 
                        ProviderName="System.Data.SqlClient" SelectCommand="DBO.procGetStatisticsGrid" 
                        SelectCommandType="StoredProcedure" 
                        onselecting="dsrcFormalReport3_Selecting">
                        <SelectParameters>
                            <asp:Parameter DefaultValue="1" Name="IS_ATC_CODE" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="INT_VARIANT_NUMBER" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="IS_DID_100" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="IS_DID_PERCENT" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="IS_GENERIC_AB" Type="Int32" />
                            <asp:Parameter DefaultValue="1" Name="IS_ADMIN_ROUTE" Type="Int32" />
                            <%--<asp:Parameter DefaultValue="1" Name="IS_WARD" Type="Int32" />--%>
                            <asp:Parameter DefaultValue="2" Name="IS_QUARTER" />
                            <asp:Parameter DefaultValue="1" Name="IS_REPORT" Type="Byte" />

                            <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                            <asp:ControlParameter ControlID="ddlSelectQuarter" Name="STR_QUARTER" 
                                PropertyName="SelectedValue" />
                            <asp:ControlParameter ControlID="ddlSelectYear" Name="STR_YEAR" 
                                PropertyName="SelectedValue" />
                        </SelectParameters>
                    </asp:SqlDataSource>

        <div style="background-color:White; text-align:left">


                    <br /><b><i>Формализованный отчет состоит из следующих пунктов:
                    <br />
                    </i></b>
                    <br />
                    <b>1.</b> Общее потребление АМП (3 уровень ATC-DDD классификации) на уровне стационара в DID.
                    <br />
                    <b>2.</b> Структура потребления разных групп АМП (4-6 уровень ATC-DDD классификации) на уровне всего стационара, % от общего DID.
                    <br />
                    <b>3.</b> Структура потребления разных групп АМП (4-6 уровень ATC-DDD классификации) на уровне всего стационара
                    по МНН и пути введения, % от общего DID АМП в стационаре.
                    <br />
                    <br />
Нумерация вкладок в файле соответствует приведенным выше пунктам
                    <br />
                   <br />
        </div>
        <br />
        <table style="width: 100%;">
            <tr>
                <td style="width: 116px; text-align:right">
                    <asp:Label ID="lblSelectYear" runat="server" Text="Выберите год:"></asp:Label>
                </td>
                <td style="text-align:left">
                    <asp:DropDownList ID="ddlSelectYear" runat="server">
                    </asp:DropDownList>
                    <cc1:CascadingDropDown ID="ddlSelectYear_CascadingDropDown" runat="server" 
                        TargetControlID="ddlSelectYear" Category="YEAR" 
                        LoadingText="Загрузка..." PromptText="[Год]" 
                        ServiceMethod="GetYearAndQuarter" ServicePath="~/GetYearQuarter.asmx">
                    </cc1:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="rvYear" runat="server" 
                        ControlToValidate="ddlSelectYear" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
            <tr>
                <td style="width: 116px; text-align:right">
                    <asp:Label ID="lblSelectQuarter" runat="server" Text="Выберите квартал:"></asp:Label>
                </td>
                <td style="text-align:left">
                    <asp:DropDownList ID="ddlSelectQuarter" runat="server">
                    </asp:DropDownList>
                    <cc1:CascadingDropDown ID="ddlSelectQuarter_CascadingDropDown" runat="server" 
                        TargetControlID="ddlSelectQuarter" ParentControlID="ddlSelectYear" Category="QUARTER" 
                        LoadingText="Загрузка..." PromptText="[Квартал]" 
                        ServiceMethod="GetYearAndQuarter" ServicePath="~/GetYearQuarter.asmx">
                    </cc1:CascadingDropDown>
                    <asp:RequiredFieldValidator ID="rvQuarter" runat="server" 
                        ControlToValidate="ddlSelectQuarter" ErrorMessage="*"></asp:RequiredFieldValidator>
                </td>
            </tr>
        </table>
        <asp:Button ID="btnGetFormalReport" runat="server" 
            Text="Сохранить формализованный отчет в формате XLS" 
                        onclick="btnGetFormalReport_Click" />
        <br />
    </div>
</asp:Content>
