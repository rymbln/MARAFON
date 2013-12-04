<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="TabletPack.aspx.cs" Inherits="Marafon.TabletPack" EnableEventValidation="false"
    Theme="Marafon" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlFindTablet_Pack" runat="server" Style="display: none; text-align: right;
                vertical-align: middle" CssClass="modalPopup">
                <asp:Panel ID="pnlFindHeaderTablet_Pack" runat="server" Style="cursor: move; background-color: #DDDDDD;
                    border: solid 1px Gray; color: Black; text-align: center;">
                    <div>
                        <p>
                            Поиск
                        </p>
                    </div>
                </asp:Panel>
                <br />
                <asp:Table ID="tblFind" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindTrade_AB" runat="server" Text="Название препарата или часть его названия: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindTrade_AB" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindMedical_Form" runat="server" Text="Форма выпуска или часть её названия: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindMedical_Form" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindCompany" runat="server" Text="Компания-производитель или часть её названия: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindCompany" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
<%--
                <br />
                <br />--%>
                <br />
                <asp:Button ID="btnFindTablet_Pack" runat="server" Text="Поиск" OnClick="btnFindTablet_Pack_Click" />
                <asp:Button ID="btnCancelFindTablet_Pack" runat="server" Text="Отменить поиск" />
            </asp:Panel>
            <asp:SqlDataSource ID="dsrcTrade_AB" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                EnableViewState="False" SelectCommand="SELECT TRADE_AB_ID, DESCRIPTION FROM TRADE_AB ORDER BY DESCRIPTION"
                ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcCompany" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                EnableViewState="False" SelectCommand="SELECT COMPANY_ID,DESCRIPTION FROM COMPANY ORDER BY DESCRIPTION"
                ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcMedical_Form" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                EnableViewState="False" SelectCommand="SELECT MEDICAL_FORM_ID, DESCRIPTION FROM MEDICAL_FORM ORDER BY DESCRIPTION"
                ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcMeasure_Item" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                EnableViewState="False" SelectCommand="SELECT MEASURE_ITEM_ID, MEASURE_ITEM_CODE FROM MEASURE_ITEM ORDER BY MEASURE_ITEM_CODE"
                ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcTablet_Pack" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                SelectCommand="SELECT TABLET_PACK_ID, TRADE_AB_ID, TRADE_AB_DESCRIPTION, COMPANY_ID, COMPANY_DESCRIPTION, MEDICAL_FORM_ID, MEDICAL_FORM_DESCRIPTION, AB_IN_DOSE, AB_IN_DOSE_DESCRIPTION, DOSES_IN_PACK, TABLET_PACK_PERCENT, TABLET_PACK_STR, AB_IN_DOSE, MEASURE_ITEM_ID, TABLET_PACK_COEFFICIENT FROM VW_INTERFACE_TABLET_PACK_DICTIONARY"
                ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
            <asp:Panel ID="Panel1" runat="server" ScrollBars="Both">
                <asp:GridView ID="gvwTablet_Pack" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="Tablet_Pack_ID" DataSourceID="dsrcTablet_Pack"
                    CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="controls" Width="98%"
                    OnRowCommand="gvwTablet_Pack_RowCommand" OnPageIndexChanging="gvwTablet_Pack_PageIndexChanging"
                    OnSelectedIndexChanged="gvwTablet_Pack_SelectedIndexChanged" SelectedIndex="0"
                    OnSelectedIndexChanging="gvwTablet_Pack_SelectedIndexChanging" 
                    onrowcreated="gvwTablet_Pack_RowCreated">
                    <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <RowStyle BackColor="#EFF3FB" />
                    <Columns>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select"
                                    ImageUrl="~/images/16_publish.gif" ToolTip="Выбрать" Text="Выбрать" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                    ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" />
                                &nbsp;<asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                    ImageUrl="~/images/clear.GIF" ToolTip="Отмена" Text="Отмена" />
                            </EditItemTemplate>
                            <ControlStyle CssClass="controls" />
                            <ItemStyle HorizontalAlign="Left" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Торговое название АМП" SortExpression="TRADE_AB_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblTrade_AB" runat="server" Text='<%# Eval("TRADE_AB_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlTrade_AB" runat="server" DataSourceID="dsrcTrade_AB" DataTextField="DESCRIPTION"
                                    DataValueField="TRADE_AB_ID" SelectedValue='<%# Bind("TRADE_AB_ID") %>'>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvTrade_AB" runat="server" ControlToValidate="ddlTrade_AB"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Компания-производитель" SortExpression="COMPANY_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("COMPANY_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlCompany" runat="server" DataSourceID="dsrcCompany" DataTextField="DESCRIPTION"
                                    DataValueField="COMPANY_ID" SelectedValue='<%# Bind("COMPANY_ID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Форма выпуска" SortExpression="MEDICAL_FORM_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblMedical_Form" runat="server" Text='<%# Eval("MEDICAL_FORM_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlMedical_Form" runat="server" DataSourceID="dsrcMedical_Form"
                                    DataTextField="DESCRIPTION" DataValueField="MEDICAL_FORM_ID" SelectedValue='<%# Bind("MEDICAL_FORM_ID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Кол-во препарата в дозе" SortExpression="AB_IN_DOSE_DESCRIPTION">
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxAB_In_Dose" runat="server" Text='<%# Bind("AB_IN_DOSE") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvAB_In_Dose" runat="server" ControlToValidate="tboxAB_In_Dose"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAB_In_Dose" runat="server" Text='<%# Bind("AB_IN_DOSE_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="DOSES_IN_PACK" HeaderText="Кол-во доз в упаковке" ReadOnly="True"
                            SortExpression="DOSES_IN_PACK" />
                        <asp:BoundField DataField="TABLET_PACK_PERCENT" HeaderText="% (для жидкостей)" ReadOnly="True"
                            SortExpression="TABLET_PACK_PERCENT" />
                        <asp:TemplateField HeaderText="Расфасовка" SortExpression="TABLET_PACK_STR">
                            <ItemTemplate>
                                <asp:Label ID="lblTablet_Pack_Str" runat="server" Text='<%# Eval("TABLET_PACK_STR") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxTablet_Pack_Str" runat="server" Text='<%# Bind("TABLET_PACK_STR") %>' Width="200px"></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                    <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                    <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                    <EditRowStyle BackColor="#2461BF" />
                    <AlternatingRowStyle BackColor="White" />
                </asp:GridView>
                <br />
            </asp:Panel>
            <div style="text-align: left; vertical-align: middle">
                <asp:Button ID="btnAddTablet_Pack" runat="server" Text="Добавить запись" OnClick="btnAddTablet_Pack_Click" />
                <asp:Button ID="btnRefreshTablet_Pack" runat="server" Text="Обновить данные" OnClick="btnRefreshTablet_Pack_Click" />
                <asp:Button ID="btnFindPopupTablet_Pack" runat="server" Text="Поиск" />
            </div>
            <cc1:ModalPopupExtender ID="mpeFindTablet_Pack" runat="server" TargetControlID="btnFindPopupTablet_Pack"
                PopupControlID="pnlFindTablet_Pack" BackgroundCssClass="modalBackground" CancelControlID="btnCancelFindTablet_Pack"
                DropShadow="true" PopupDragHandleControlID="pnlFindHeaderTablet_Pack">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="dvwTablet_Pack" EventName="ItemInserted" />
            <asp:AsyncPostBackTrigger ControlID="dvwTablet_Pack" EventName="ItemDeleted" />
            <asp:AsyncPostBackTrigger ControlID="dvwTablet_Pack" EventName="ItemUpdated" />
            <asp:AsyncPostBackTrigger ControlID="dvwTablet_Pack" EventName="ItemCommand" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlDetailsView" runat="server">
                <asp:SqlDataSource ID="dsrcTablet_PackDetails" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                    DeleteCommand="DELETE FROM TABLET_PACK WHERE (TABLET_PACK_ID = @TABLET_PACK_ID)"
                    InsertCommand="INSERT INTO TABLET_PACK(SUSER) VALUES (@SUSER)" 
                    SelectCommand="SELECT TABLET_PACK_ID, TRADE_AB_ID, TRADE_AB_DESCRIPTION, COMPANY_ID, COMPANY_DESCRIPTION, MEDICAL_FORM_ID, MEDICAL_FORM_DESCRIPTION, AB_IN_DOSE, AB_IN_DOSE_DESCRIPTION, DOSES_IN_PACK, TABLET_PACK_PERCENT AS TABLET_PACK_COEFFICIENT, TABLET_PACK_STR, AB_IN_DOSE, MEASURE_ITEM_ID, MEASURE_ITEM_CODE FROM VW_INTERFACE_TABLET_PACK_DICTIONARY WHERE TABLET_PACK_ID=@TABLET_PACK_ID"
                    UpdateCommand="UPDATE TABLET_PACK SET TRADE_AB_ID = @TRADE_AB_ID, COMPANY_ID = @COMPANY_ID, MEDICAL_FORM_ID = @MEDICAL_FORM_ID, AB_IN_DOSE = @AB_IN_DOSE, DOSES_IN_PACK = @DOSES_IN_PACK, MEASURE_ITEM_ID = @MEASURE_ITEM_ID, TABLET_PACK_COEFFICIENT = @TABLET_PACK_COEFFICIENT, TABLET_PACK_STR = @TABLET_PACK_STR, SUSER = @SUSER WHERE (TABLET_PACK_ID = @TABLET_PACK_ID)"
                    ProviderName="System.Data.SqlClient">
                    <SelectParameters>
                        <asp:ControlParameter ControlID="gvwTablet_Pack" Name="TABLET_PACK_ID" PropertyName="SelectedValue"
                            Type="Int32" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="TABLET_PACK_ID" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="TRADE_AB_ID" Type="Int32" />
                        <asp:Parameter Name="COMPANY_ID" Type="Int32" />
                        <asp:Parameter Name="MEDICAL_FORM_ID" Type="Int32" />
                        <asp:Parameter Name="AB_IN_DOSE" Type="Decimal" />
                        <asp:Parameter Name="DOSES_IN_PACK" Type="Decimal" />
                        <asp:Parameter Name="MEASURE_ITEM_ID" Type="Int32" />
                        <asp:Parameter Name="TABLET_PACK_COEFFICIENT" Type="Double" />
                        <asp:Parameter Name="TABLET_PACK_STR" Type="String" />
                        <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                        <asp:ControlParameter ControlID="gvwTablet_Pack" Name="TABLET_PACK_ID" PropertyName="SelectedValue"
                            Type="Int32" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:DetailsView ID="dvwTablet_Pack" runat="server" AutoGenerateRows="False" DataKeyNames="Tablet_Pack_ID"
                    DataSourceID="dsrcTablet_PackDetails" EnableModelValidation="True" HeaderText="Подробные данные"
                    OnItemUpdating="dvwTablet_Pack_ItemUpdating" OnItemDeleted="dvwTablet_Pack_ItemDeleted"
                    OnItemUpdated="dvwTablet_Pack_ItemUpdated" 
                    ondatabound="dvwTablet_Pack_DataBound">
                    <Fields>
                        <asp:TemplateField HeaderText="Торговое название АМП" SortExpression="TRADE_AB_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblTrade_AB" runat="server" Text='<%# Eval("TRADE_AB_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlTrade_AB" runat="server" DataSourceID="dsrcTrade_AB" DataTextField="DESCRIPTION"
                                    DataValueField="TRADE_AB_ID" SelectedValue='<%# Bind("TRADE_AB_ID") %>'>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="rfvTrade_AB" runat="server" ControlToValidate="ddlTrade_AB"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="ddlTrade_ABInsert" runat="server" DataSourceID="dsrcTrade_AB"
                                    DataTextField="DESCRIPTION" DataValueField="TRADE_AB_ID" SelectedValue='<%# Bind("TRADE_AB_ID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Компания-производитель" SortExpression="COMPANY_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblCompany" runat="server" Text='<%# Eval("COMPANY_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlCompany" runat="server" DataSourceID="dsrcCompany" DataTextField="DESCRIPTION"
                                    DataValueField="COMPANY_ID" SelectedValue='<%# Bind("COMPANY_ID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="ddlCompanyInsert" runat="server" DataSourceID="dsrcCompany"
                                    DataTextField="DESCRIPTION" DataValueField="COMPANY_ID" SelectedValue='<%# Bind("COMPANY_ID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Форма выпуска" SortExpression="MEDICAL_FORM_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblMedical_Form" runat="server" Text='<%# Eval("MEDICAL_FORM_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlMedical_Form" runat="server" DataSourceID="dsrcMedical_Form"
                                    DataTextField="DESCRIPTION" DataValueField="MEDICAL_FORM_ID" SelectedValue='<%# Bind("MEDICAL_FORM_ID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="ddlMedical_FormInsert" runat="server" DataSourceID="dsrcMedical_FormInsert"
                                    DataTextField="DESCRIPTION" DataValueField="MEDICAL_FORM_ID" SelectedValue='<%# Bind("MEDICAL_FORM_ID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Кол-во препарата в дозе" SortExpression="AB_IN_DOSE_DESCRIPTION">
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxAB_In_Dose" runat="server" Text='<%# Bind("AB_IN_DOSE") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvAB_In_Dose" runat="server" ControlToValidate="tboxAB_In_Dose"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvAB_In_Dose" runat="server" ControlToValidate="tboxAB_In_Dose"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Кол-во препарата должно быть числом"
                                    SetFocusOnError="True" Type="double" Operator="DataTypeCheck"></asp:CompareValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="tboxAB_In_DoseInsert" runat="server" Text='<%# Bind("AB_IN_DOSE") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvAB_In_DoseInsert" runat="server" ControlToValidate="tboxAB_In_DoseInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvAB_In_DoseInsert" runat="server" ControlToValidate="tboxAB_In_DoseInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Кол-во препарата должно быть числом"
                                    SetFocusOnError="True" Type="double" Operator="DataTypeCheck"></asp:CompareValidator>
                            </InsertItemTemplate>
                            <ItemTemplate>
                                <asp:Label ID="lblAB_In_Dose" runat="server" Text='<%# Bind("AB_IN_DOSE_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Единицы измерения" SortExpression="MEASURE_ITEM_CODE">
                            <ItemTemplate>
                                <asp:Label ID="lblMEASURE_ITEM" runat="server" Text='<%# Eval("MEASURE_ITEM_CODE") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlMEASURE_ITEM" runat="server" DataSourceID="dsrcMEASURE_ITEM" DataTextField="MEASURE_ITEM_CODE"
                                    DataValueField="MEASURE_ITEM_ID" SelectedValue='<%# Bind("MEASURE_ITEM_ID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="ddlMEASURE_ITEMInsert" runat="server" DataSourceID="dsrcMEASURE_ITEM"
                                    DataTextField="MEASURE_ITEM_CODE" DataValueField="MEASURE_ITEM_ID" SelectedValue='<%# Bind("MEASURE_ITEM_ID") %>'>
                                </asp:DropDownList>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Кол-во доз в упаковке" 
                            SortExpression="DOSES_IN_PACK">
                            <ItemTemplate>
                                <asp:Label ID="lblDoses_In_Pack" runat="server" Text='<%# Bind("DOSES_IN_PACK") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxDoses_In_Pack" runat="server" Text='<%# Bind("DOSES_IN_PACK") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDoses_In_Pack" runat="server" ControlToValidate="tboxDoses_In_Pack"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvDoses_In_Pack" runat="server" ControlToValidate="tboxDoses_In_Pack"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Кол-во доз в упаковке должно быть числом"
                                    SetFocusOnError="True" Type="Double" Operator="DataTypeCheck"></asp:CompareValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="tboxDoses_In_PackInsert" runat="server" Text='<%# Bind("DOSES_IN_PACK") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvDoses_In_PackInsert" runat="server" ControlToValidate="tboxDoses_In_PackInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvDoses_In_PackInsert" runat="server" ControlToValidate="tboxDoses_In_PackInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Кол-во доз в упаковке должно быть числом"
                                    SetFocusOnError="True" Type="Double" Operator="DataTypeCheck"></asp:CompareValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="% (для жидкостей)" 
                            SortExpression="TABLET_PACK_PERCENT">
                            <ItemTemplate>
                                <asp:Label ID="lblTablet_Pack_Percent" runat="server" Text='<%# Bind("TABLET_PACK_COEFFICIENT") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxTablet_Pack_Percent" runat="server" Text='<%# Bind("TABLET_PACK_COEFFICIENT") %>'></asp:TextBox>
<%--                                <asp:RequiredFieldValidator ID="rfvTablet_Pack_Percent" runat="server" ControlToValidate="tboxTablet_Pack_Percent"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
--%>                                <asp:CompareValidator ID="cvTablet_Pack_Percent" runat="server" ControlToValidate="tboxTablet_Pack_Percent"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Кол-во доз в упаковке должно быть числом"
                                    SetFocusOnError="True" Type="Double" Operator="DataTypeCheck"></asp:CompareValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="tboxTablet_Pack_PercentInsert" runat="server" Text='<%# Bind("Tablet_Pack_COEFFICIENT") %>'></asp:TextBox>
<%--                                <asp:RequiredFieldValidator ID="rfvTablet_Pack_PercentInsert" runat="server" ControlToValidate="tboxTablet_Pack_PercentInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
--%>                                <asp:CompareValidator ID="cvTablet_Pack_PercentInsert" runat="server" ControlToValidate="tboxTablet_Pack_PercentInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Кол-во доз в упаковке должно быть числом"
                                    SetFocusOnError="True" Type="Double" Operator="DataTypeCheck"></asp:CompareValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Расфасовка" SortExpression="TABLET_PACK_STR">
                            <ItemTemplate>
                                <asp:Label ID="lblTablet_Pack_Str" runat="server" Text='<%# Eval("TABLET_PACK_STR") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxTablet_Pack_Str" runat="server" Text='<%# Bind("TABLET_PACK_STR") %>'
                                    Width="200px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvTablet_Pack_Str" runat="server" ControlToValidate="tboxTablet_Pack_Str"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="tboxTablet_Pack_StrInsert" runat="server" Text='<%# Bind("TABLET_PACK_STR") %>'
                                    Width="200px"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvTablet_Pack_StrInsert" runat="server" ControlToValidate="tboxTablet_Pack_StrInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                    Text="Редактировать" onclick="btnEdit_Click" ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать"/>
                                <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" Text="Удалить"
                                    OnClientClick="javascript:return confirm('Вы действительно хотите удалит эту запись?');"
                                    OnClick="btnDelete_Click" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить"/>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                    Text="Сохранить" OnClick="btnSave_Click" ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить"/>
                                <asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                    Text="Отмена" OnClick="btnCancel_Click" ImageUrl="~/images/clear.GIF" ToolTip="Отмена"/>
                            </EditItemTemplate>
                            <ControlStyle CssClass="controls" />
                        </asp:TemplateField>
                    </Fields>
                </asp:DetailsView>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvwTablet_Pack" EventName="SelectedIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
