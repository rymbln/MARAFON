<%@ Page Title="Потребление" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="PackStore.aspx.cs" Inherits="Marafon.PackStore"
    EnableEventValidation="false" Theme="Marafon" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <div style="text-align: left; vertical-align: top">
                <asp:Label ID="lblbInputNumber" runat="server" Text="Порядковый номер ввода"></asp:Label>
                <asp:DropDownList ID="ddlInputNumber" runat="server" AutoPostBack="True">
                    <asp:ListItem Value="1">Первый ввод</asp:ListItem>
                    <asp:ListItem Value="2">Второй ввод</asp:ListItem>
                </asp:DropDownList>
            </div>
            <asp:Panel ID="pnlFindPack_Store" runat="server" Style="display: none; text-align: right;
                vertical-align: middle" CssClass="modalPopup">
                <asp:Panel ID="pnlFindHeaderPack_Store" runat="server" Style="cursor: move; background-color: #DDDDDD;
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
                            <asp:Label ID="lblFindPack_StoreID" runat="server" Text="№: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindPack_StoreID" runat="server"></asp:TextBox>
                            <asp:CompareValidator ID="cvFindPack_StoreID" runat="server" ControlToValidate="tboxFindPack_StoreID"
                                CssClass="controls" Display="Dynamic" ErrorMessage="№ должен быть числом!" SetFocusOnError="false"
                                Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindTradeAB" runat="server" Text="Препарат или часть его названия: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindTradeAB" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindWard" runat="server" Text="Накладные: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindWard" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
<%--
                <br />
                <br />
                <br />--%>
                <br />
                <asp:Button ID="btnFindPack_Store" runat="server" Text="Поиск" OnClick="btnFindPack_Store_Click" />
                <asp:Button ID="btnCancelFindPack_Store" runat="server" Text="Отменить поиск" />
            </asp:Panel>
            <asp:SqlDataSource ID="dsrcWard" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                EnableViewState="False" SelectCommand="SELECT WARD_ID, WARD_DESCRIPTION FROM VW_INTERFACE_WARD_DESCRIPTION WHERE (SUSER=@SUSER) OR (@IS_ADMIN=1) GROUP BY WARD_ID, WARD_DESCRIPTION ORDER BY WARD_DESCRIPTION"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    <asp:SessionParameter Name="IS_ADMIN" SessionField="is_admin" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcPack_Store" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                SelectCommand="SELECT PACK_STORE_ID, TABLET_PACK_ID, DATE_RECEIVE, CAST(PACK_QUANTITY AS DECIMAL(10,2)) AS PACK_QUANTITY, WARD_ID, WARD_DESCRIPTION, QUARTER_ID, QUARTER_DESCRIPTION, TABLET_PACK_DESCRIPTION, TABLET_PACK_DESCRIPTION_VW, TRADE_AB_ID FROM VW_INTERFACE_PACK_STORE_DESCRIPTION WHERE (WARD_ID IN (SELECT WARD_ID FROM VW_WARD_USER WHERE (SUSER = @SUSER))) AND (INPUT_NUMBER = @INPUT_NUMBER) OR (IS_ADMIN = @IS_ADMIN) AND (INPUT_NUMBER = @INPUT_NUMBER)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    <asp:SessionParameter Name="IS_ADMIN" SessionField="is_admin" />
                    <asp:SessionParameter Name="INPUT_NUMBER" SessionField="input_number" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:Panel runat="server" ScrollBars="Horizontal">
                <asp:GridView ID="gvwPack_Store" runat="server" AllowPaging="True" AllowSorting="True"
                    AutoGenerateColumns="False" DataKeyNames="PACK_STORE_ID" DataSourceID="dsrcPack_Store"
                    CellPadding="4" ForeColor="#333333" GridLines="None" CssClass="controls" Width="98%"
                    OnRowCommand="gvwPack_Store_RowCommand" OnPageIndexChanging="gvwPack_Store_PageIndexChanging"
                    OnSelectedIndexChanged="gvwPack_Store_SelectedIndexChanged" SelectedIndex="0"
                    OnSelectedIndexChanging="gvwPack_Store_SelectedIndexChanging" EmptyDataText="Нет данных"
                    PageSize="7" OnRowCreated="gvwPack_Store_RowCreated">
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
                        <asp:BoundField DataField="PACK_STORE_ID" HeaderText="№" ReadOnly="True" SortExpression="PACK_STORE_ID" />
                        <asp:TemplateField HeaderText="Накладные" SortExpression="WARD_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblWard" runat="server" Text='<%# Eval("WARD_DESCRIPTION") %>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlWard" runat="server" DataSourceID="dsrcWard" DataTextField="WARD_DESCRIPTION"
                                    DataValueField="WARD_ID" SelectedValue='<%# Bind("WARD_ID") %>' >
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Кол-во упаковок" SortExpression="PACK_QUANTITY">
                            <ItemTemplate>
                                <asp:Label ID="lblPackQuantity" runat="server" Text='<%# Eval("PACK_QUANTITY") %>' Width="50px"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxPackQuantity" runat="server" Text='<%# Bind("PACK_QUANTITY") %>'
                                    Width="50px"></asp:TextBox>
                                <asp:CompareValidator ID="cvPackQuantity" runat="server" ControlToValidate="tboxPackQuantity"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Кол-во упаковок должно быть числом"
                                    SetFocusOnError="false" Type="double" Operator="DataTypeCheck"></asp:CompareValidator>
                                <asp:RequiredFieldValidator ID="rfvPackQuantity" runat="server" ControlToValidate="tboxPackQuantity"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Дата получения" SortExpression="DATE_RECEIVE">
                            <ItemTemplate>
                                <asp:Label ID="lblDateReceive" runat="server" Text='<%# Eval("DATE_RECEIVE", "{0:d}") %>' Width="70px"></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxDateReceive" runat="server" Text='<%# Bind("DATE_RECEIVE", "{0:d}") %>' Width="70px"></asp:TextBox>
                                <asp:ImageButton runat="Server" ID="ibDateReceive" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    AlternateText="Нажмите, чтобы показать календарь" />
                                <cc1:CalendarExtender ID="ceDateReceive" runat="server" TargetControlID="tboxDateReceive"
                                    PopupButtonID="ibDateReceive" Format="dd.MM.yyyy" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Препарат" SortExpression="TABLET_PACK_DESCRIPTION_VW">
                            <ItemTemplate>
                                <asp:Label ID="lblTabletPackDescriptionVW" runat="server" Text='<%# Eval("TABLET_PACK_DESCRIPTION_VW") %>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlTradeAB" runat="server" SelectedValue='<%# Bind("TRADE_AB_ID") %>' >
                                </asp:DropDownList>
                                <cc1:CascadingDropDown ID="cddTradeAB" runat="server" Category="TRADE_AB" LoadingText="Загрузка..."
                                    PromptText="[Торговое название АМП]" ServiceMethod="GetDropDownAB" ServicePath="~/GetABWard.asmx"
                                    TargetControlID="ddlTradeAB" UseContextKey="True">
                                </cc1:CascadingDropDown>
                                <asp:DropDownList ID="ddlTabletPack" runat="server" SelectedValue='<%# Bind("TABLET_PACK_ID") %>' >
                                </asp:DropDownList>
                                <cc1:CascadingDropDown ID="cddTabletPack" runat="server" Category="TABLET_PACK" LoadingText="Загрузка..."
                                    ParentControlID="ddlTradeAB" PromptText="[Форма выпуска]" ServiceMethod="GetDropDownAB"
                                    ServicePath="~/GetABWard.asmx" TargetControlID="ddlTabletPack">
                                </cc1:CascadingDropDown>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Препарат(доп.)" SortExpression="TABLET_PACK_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblTabletPackDescription" runat="server" Text='<%# Eval("TABLET_PACK_DESCRIPTION") %>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxTabletPackDescription" runat="server" Text='<%# Bind("TABLET_PACK_DESCRIPTION") %>'></asp:TextBox>
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
                <asp:Button ID="btnAddPack_Store" runat="server" Text="Добавить запись" OnClick="btnAddPack_Store_Click" />
                <asp:Button ID="btnRefreshPack_Store" runat="server" Text="Обновить данные" OnClick="btnRefreshPack_Store_Click" />
                <asp:Button ID="btnFindPopupPack_Store" runat="server" Text="Поиск" />
                <asp:Button ID="btnDoubleInput" runat="server" Text="Проверка двойного ввода" />

            </div>
            <cc1:ModalPopupExtender ID="mpeFindPack_Store" runat="server" TargetControlID="btnFindPopupPack_Store"
                PopupControlID="pnlFindPack_Store" BackgroundCssClass="modalBackground" CancelControlID="btnCancelFindPack_Store"
                DropShadow="true" PopupDragHandleControlID="pnlFindHeaderPack_Store">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="dvwPack_Store" EventName="ItemInserted" />
            <asp:AsyncPostBackTrigger ControlID="dvwPack_Store" EventName="ItemDeleted" />
            <asp:AsyncPostBackTrigger ControlID="dvwPack_Store" EventName="ItemUpdated" />
            <asp:AsyncPostBackTrigger ControlID="dvwPack_Store" EventName="ItemCommand" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlDetailsView" runat="server">
                <asp:SqlDataSource ID="dsrcPack_StoreDetails" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                    DeleteCommand="DELETE FROM PACK_STORE WHERE (PACK_STORE_ID = @PACK_STORE_ID) UPDATE PACK_STORE_archive SET SUSER = @SUSER WHERE PACK_STORE_ID = @PACK_STORE_ID AND ACTION_TYPE=1"
                    InsertCommand="INSERT INTO PACK_STORE(INPUT_NUMBER, SUSER) VALUES (@INPUT_NUMBER, @SUSER)"
                    SelectCommand="SELECT PACK_STORE_ID, WARD_ID, WARD_DESCRIPTION, TRADE_AB_ID, TABLET_PACK_TRADE_AB_DESCRIPTION, TABLET_PACK_ID, TABLET_PACK_FORM_DESCRIPTION, DATE_RECEIVE, CAST(PACK_QUANTITY AS INT) AS PACK_QUANTITY, TABLET_PACK_DESCRIPTION, TABLET_PACK_DESCRIPTION_VW, DATE_ADD, DATE_UPDATE, SUSER FROM VW_INTERFACE_PACK_STORE_DESCRIPTION WHERE (PACK_STORE_ID = @PACK_STORE_ID) AND (WARD_ID IN (SELECT WARD_ID FROM VW_WARD_USER WHERE (SUSER = @SUSER))) AND (INPUT_NUMBER = @INPUT_NUMBER) OR (PACK_STORE_ID = @PACK_STORE_ID) AND (INPUT_NUMBER = @INPUT_NUMBER) AND (IS_ADMIN = @IS_ADMIN)"
                    UpdateCommand="UPDATE PACK_STORE SET WARD_ID = @WARD_ID, PACK_QUANTITY = @PACK_QUANTITY, DATE_RECEIVE = @DATE_RECEIVE, TABLET_PACK_ID = @TABLET_PACK_ID, TABLET_PACK_DESCRIPTION = @TABLET_PACK_DESCRIPTION, SUSER=@SUSER WHERE (PACK_STORE_ID = @PACK_STORE_ID)"
                    ProviderName="System.Data.SqlClient">
                    <SelectParameters>
                        <asp:ControlParameter Name="PACK_STORE_ID" ControlID="gvwPack_Store" PropertyName="SelectedValue"
                            Type="int32" />
                        <asp:SessionParameter Name="SUSER" SessionField="uid" />
                        <asp:SessionParameter Name="IS_ADMIN" SessionField="is_admin" />
                        <asp:SessionParameter Name="INPUT_NUMBER" SessionField="input_number" />
                    </SelectParameters>
                    <DeleteParameters>
                        <asp:Parameter Name="PACK_STORE_ID" Type="Int32" />
                        <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    </DeleteParameters>
                    <UpdateParameters>
                        <asp:Parameter Name="WARD_ID" />
                        <asp:Parameter Name="PACK_QUANTITY" />
                        <asp:Parameter Name="DATE_RECEIVE" Type="DateTime" />
                        <asp:Parameter Name="TABLET_PACK_ID" />
                        <asp:Parameter Name="TABLET_PACK_DESCRIPTION" />
                        <asp:SessionParameter Name="SUSER" SessionField="uid" />
                        <asp:Parameter Name="PACK_STORE_ID" />
                    </UpdateParameters>
                    <InsertParameters>
                        <asp:ControlParameter ControlID="ddlWard" Name="WARD_ID" PropertyName="SelectedValue"
                            Type="int32" />
                        <asp:SessionParameter Name="INPUT_NUMBER" SessionField="input_number" />
                        <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    </InsertParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="dsrcTabletPackTradeAB" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                    ProviderName="<%$ ConnectionStrings:MarafonConnection.ProviderName %>" SelectCommand="SELECT TRADE_AB_ID, TABLET_PACK_TRADE_AB_DESCRIPTION FROM VW_INTERFACE_PACK_STORE_DESCRIPTION WHERE (PACK_STORE_ID=@PACK_STORE_ID) GROUP BY TRADE_AB_ID, TABLET_PACK_TRADE_AB_DESCRIPTION">
                    <SelectParameters>
                        <asp:ControlParameter Name="PACK_STORE_ID" ControlID="gvwPack_Store" PropertyName="SelectedValue"
                            Type="int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:SqlDataSource ID="dsrcTabletPackForm" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                    ProviderName="<%$ ConnectionStrings:MarafonConnection.ProviderName %>" SelectCommand="SELECT TABLET_PACK_ID, TABLET_PACK_FORM_DESCRIPTION FROM VW_INTERFACE_PACK_STORE_DESCRIPTION WHERE (PACK_STORE_ID=@PACK_STORE_ID) GROUP BY TABLET_PACK_ID, TABLET_PACK_FORM_DESCRIPTION">
                    <SelectParameters>
                        <asp:ControlParameter Name="PACK_STORE_ID" ControlID="gvwPack_Store" PropertyName="SelectedValue"
                            Type="int32" />
                    </SelectParameters>
                </asp:SqlDataSource>
                <asp:DetailsView ID="dvwPack_Store" runat="server" AutoGenerateRows="False" DataKeyNames="PACK_STORE_ID"
                    DataSourceID="dsrcPack_StoreDetails" EnableModelValidation="True"
                    OnItemCreated="dvwPack_Store_ItemCreated" OnItemUpdating="dvwPack_Store_ItemUpdating"
                    OnItemDeleted="dvwPack_Store_ItemDeleted" 
                    OnItemUpdated="dvwPack_Store_ItemUpdated" ondatabound="dvwPack_Store_DataBound">
                    <Fields>
                        <asp:BoundField DataField="PACK_STORE_ID" HeaderText="№" ReadOnly="True" SortExpression="PACK_STORE_ID" />
                        <asp:TemplateField HeaderText="Накладные" SortExpression="WARD_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblWard" runat="server" Text='<%# Eval("WARD_DESCRIPTION") %>' ></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblWardEdit" runat="server" Text='<%# Eval("WARD_DESCRIPTION") %>' ></asp:Label>
     <%--                           <asp:DropDownList ID="ddlWard" runat="server" DataSourceID="dsrcWard" DataTextField="WARD_DESCRIPTION"
                                    DataValueField="WARD_ID" SelectedValue='<%# Bind("WARD_ID") %>' >
                                </asp:DropDownList>--%>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Кол-во упаковок" SortExpression="PACK_QUANTITY">
                            <ItemTemplate>
                                <asp:Label ID="lblPackQuantity" runat="server" Text='<%# Eval("PACK_QUANTITY") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxPackQuantity" runat="server" Text='<%# Bind("PACK_QUANTITY") %>'
                                    Width="70px"></asp:TextBox>
                                <asp:RangeValidator ID="rvDateReceive" runat="server" ErrorMessage="Количество упаковок должно быть в диапазоне 1-100 000"
                                    Type="Double" MinimumValue="1" MaximumValue="100000" ControlToValidate="tboxPackQuantity"
                                    SetFocusOnError="false" Display="Dynamic"></asp:RangeValidator>

                                <asp:CompareValidator ID="cvPackQuantity" runat="server" ControlToValidate="tboxPackQuantity"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Кол-во упаковок должно быть числом"
                                    SetFocusOnError="false" Type="double" Operator="DataTypeCheck"></asp:CompareValidator>
                                <asp:RequiredFieldValidator ID="rfvPackQuantity" runat="server" ControlToValidate="tboxPackQuantity"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="tboxPackQuantityInsert" runat="server" Text='<%# Bind("PACK_QUANTITY") %>'
                                    Width="70px"></asp:TextBox>
                                <asp:CompareValidator ID="cvPackQuantityInsert" runat="server" ControlToValidate="tboxPackQuantityInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Кол-во упаковок должно быть числом"
                                    SetFocusOnError="false" Type="double" Operator="DataTypeCheck"></asp:CompareValidator>
                                <asp:RequiredFieldValidator ID="rfvPackQuantityInsert" runat="server" ControlToValidate="tboxPackQuantityInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Дата получения" SortExpression="DATE_RECEIVE">
                            <ItemTemplate>
                                <asp:Label ID="lblDateReceive" runat="server" Text='<%# Eval("DATE_RECEIVE", "{0:d}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxDateReceive" runat="server" Text='<%# Bind("DATE_RECEIVE", "{0:d}") %>'></asp:TextBox>
                                <asp:ImageButton runat="Server" ID="ibDateReceive" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    AlternateText="Нажмите, чтобы показать календарь" />
                                <cc1:CalendarExtender ID="ceDateReceive" runat="server" TargetControlID="tboxDateReceive"
                                    PopupButtonID="ibDateReceive" Format="dd.MM.yyyy" />
                                <cc1:MaskedEditExtender ID="meeDateReceive" runat="server" TargetControlID="tboxDateReceive"
                                    Mask="99/99/9999" 
                                    CultureName="ru-RU"
                                    MessageValidatorTip="false" 
                                    ClearMaskOnLostFocus="false" 
                                    ClearTextOnInvalid="false"
                                    MaskType="Date" />
                                <cc1:MaskedEditValidator ID="mevDateReceive" runat="server"
                                    ControlToValidate="tboxDateReceive" ControlExtender="meeDateReceive"
                                    Display="Dynamic" TooltipMessage="(дд.мм.гггг)"  
                                    IsValidEmpty="false" 
                                    EmptyValueMessage="*" 
                                    InvalidValueMessage="Дата вводится в формате (дд.мм.гггг)" 
                                    MaximumValueMessage="Дата получения не должна превышать текущую дату" 
                                    MinimumValueMessage="Дата получения не должна быть меньше 01/01/2000"
                                    MinimumValue="01.01.2000" 
                                    MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>'/>
<%--                                <asp:RequiredFieldValidator ID="rfvDateReceive" runat="server" ControlToValidate="tboxDateReceive"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvDateReceive" runat="server" ControlToValidate="tboxDateReceive"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Неверная дата  " SetFocusOnError="True"
                                    Type="Date" Operator="DataTypeCheck"></asp:CompareValidator>
                                <asp:RangeValidator ID="rvDateReceive" runat="server" ErrorMessage="Дата выходит за допустимые границы"
                                    Type="Date" MinimumValue="01.01.2009" MaximumValue="31.12.2010" ControlToValidate="tboxDateReceive"
                                    SetFocusOnError="True" Display="Dynamic"></asp:RangeValidator>
                                <cc1:MaskedEditExtender ID="meeDateReceive" runat="server"
                                    TargetControlID="tboxDateReceive" Mask="99\.99\.9999" MessageValidatorTip="true" ClearMaskOnLostFocus="false" ClearTextOnInvalid="true" /> --%>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="tboxDateReceiveInsert" runat="server" Text='<%# Bind("DATE_RECEIVE", "{0:d}") %>'></asp:TextBox>
                                <asp:ImageButton runat="Server" ID="ibDateReceiveInsert" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    AlternateText="Нажмите, чтобы показать календарь" />
                                <cc1:CalendarExtender ID="ceDateReceiveInsert" runat="server" TargetControlID="tboxDateReceiveInsert"
                                    PopupButtonID="ibDateReceiveInsert" Format="dd.MM.yyyy" />
                                <asp:RequiredFieldValidator ID="rfvDateReceiveInsert" runat="server" ControlToValidate="tboxDateReceiveInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvDateReceiveInsert" runat="server" ControlToValidate="tboxDateReceiveInsert"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Неверная дата" SetFocusOnError="false"
                                    Type="Date" Operator="DataTypeCheck"></asp:CompareValidator>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Торговое название АМП" SortExpression="TABLET_PACK_DESCRIPTION_VW">
                            <ItemTemplate>
                                <asp:Label ID="lblTabletPackTradeAB" runat="server" Text='<%# Eval("TABLET_PACK_TRADE_AB_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlTradeAB" runat="server" SelectedValue='<%# Eval("TRADE_AB_ID") %>'
                                    DataSourceID="dsrcTabletPackTradeAB" DataTextField="TABLET_PACK_TRADE_AB_DESCRIPTION"
                                    DataValueField="TRADE_AB_ID">
                                </asp:DropDownList>
                                <cc1:CascadingDropDown ID="cddTradeAB" runat="server" Category="TRADE_AB" LoadingText="Загрузка..."
                                    PromptText="[Торговое название АМП]" ServiceMethod="GetDropDownAB" ServicePath="~/GetABWard.asmx"
                                    TargetControlID="ddlTradeAB" UseContextKey="True">
                                </cc1:CascadingDropDown>
                                <asp:RequiredFieldValidator ID="rfvTradeAB" runat="server" ControlToValidate="ddlTradeAB"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="ddlTradeABInsert" runat="server" SelectedValue='<%# Eval("TRADE_AB_ID") %>'
                                    DataSourceID="dsrcTabletPackTradeAB" DataTextField="TABLET_PACK_TRADE_AB_DESCRIPTION"
                                    DataValueField="TRADE_AB_ID">
                                </asp:DropDownList>
                                <cc1:CascadingDropDown ID="cddTradeABInsert" runat="server" Category="TRADE_AB" LoadingText="Загрузка..."
                                    PromptText="[Торговое название АМП]" ServiceMethod="GetDropDownAB" ServicePath="~/GetABWard.asmx"
                                    TargetControlID="ddlTradeABInsert" UseContextKey="True">
                                </cc1:CascadingDropDown>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Форма выпуска" SortExpression="TABLET_PACK_DESCRIPTION_VW">
                            <ItemTemplate>
                                <asp:Label ID="lblTabletPackForm" runat="server" Text='<%# Eval("TABLET_PACK_FORM_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlTabletPack" runat="server" SelectedValue='<%# Bind("TABLET_PACK_ID") %>'
                                    DataSourceID="dsrcTabletPackForm" DataTextField="TABLET_PACK_FORM_DESCRIPTION"
                                    DataValueField="TABLET_PACK_ID">
                                </asp:DropDownList>
                                <cc1:CascadingDropDown ID="cddTabletPack" runat="server" Category="TABLET_PACK" LoadingText="Загрузка..."
                                    ParentControlID="ddlTradeAB" PromptText="[Форма выпуска]" ServiceMethod="GetDropDownAB"
                                    ServicePath="~/GetABWard.asmx" TargetControlID="ddlTabletPack">
                                </cc1:CascadingDropDown>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:DropDownList ID="ddlTabletPackInsert" runat="server" SelectedValue='<%# Bind("TABLET_PACK_ID") %>'
                                    DataSourceID="dsrcTabletPackForm" DataTextField="TABLET_PACK_FORM_DESCRIPTION"
                                    DataValueField="TABLET_PACK_ID">
                                </asp:DropDownList>
                                <cc1:CascadingDropDown ID="cddTabletPackInsert" runat="server" Category="TABLET_PACK"
                                    LoadingText="Загрузка..." ParentControlID="ddlTradeABInsert" PromptText="[Форма выпуска]"
                                    ServiceMethod="GetDropDownAB" ServicePath="~/GetABWard.asmx" TargetControlID="ddlTabletPackInsert">
                                </cc1:CascadingDropDown>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Препарат(доп.)" SortExpression="TABLET_PACK_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblTabletPackDescription" runat="server" Text='<%# Eval("TABLET_PACK_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxTabletPackDescription" runat="server" Text='<%# Bind("TABLET_PACK_DESCRIPTION") %>'></asp:TextBox>
                            </EditItemTemplate>
                            <InsertItemTemplate>
                                <asp:TextBox ID="tboxTabletPackDescriptionInsert" runat="server" Text='<%# Bind("TABLET_PACK_DESCRIPTION") %>'></asp:TextBox>
                            </InsertItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="DATE_ADD" DataFormatString="{0:d}" HeaderText="Дата добавления"
                            ReadOnly="True" SortExpression="DATE_ADD" />
                        <asp:BoundField DataField="DATE_UPDATE" DataFormatString="{0:d}" HeaderText="Дата последнего изменения"
                            ReadOnly="True" SortExpression="DATE_UPDATE" />
                        <asp:BoundField DataField="SUSER" HeaderText="Пользователь" ReadOnly="True" SortExpression="SUSER" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                    Text="Редактировать" OnClick="btnEdit_Click" ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать"/>
                                <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" Text="Удалить"
                                    OnClientClick="javascript:return confirm('Вы действительно хотите удалит эту запись?');"
                                    OnClick="btnDelete_Click" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить"/>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                    Text="Сохранить" OnClick="btnSave_Click" ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить"/>
                                <asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                    Text="Отмена" OnClick="btnCancel_Click" ImageUrl="~/images/clear.GIF" ToolTip="Отмена"/>
                                <asp:Label ID="lblError_Pack_Store" runat="server" Text="" SkinID="ErrorLabel" ForeColor="Red"></asp:Label>
                            </EditItemTemplate>
                            <ControlStyle CssClass="controls" />
                        </asp:TemplateField>
                    </Fields>
                </asp:DetailsView>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvwPack_Store" EventName="SelectedIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>
    <div style="text-align: left; vertical-align: middle;">
        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" ScrollBars="Both"
            Height="150px">
            <cc1:TabPanel runat="server" HeaderText="Различия между 1-м и 2-м вводом" ID="TabPanel1">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:SqlDataSource ID="dsrcInputCompare" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                EnableViewState="False" SelectCommand="dbo.procValidateDoubleInput" ProviderName="System.Data.SqlClient"
                                SelectCommandType="StoredProcedure">
                                <SelectParameters>
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                                    <asp:Parameter Direction="ReturnValue" Name="RETURN_VALUE" Type="Int32" />
                                </SelectParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvwInputCompare" runat="server" AllowSorting="True" AutoGenerateColumns="False"
                                DataSourceID="dsrcInputCompare" DataKeyNames="PACK_STORE_ID" EmptyDataText="Несовпадения отсутствуют!"
                                CssClass="controls" ForeColor="#333333" GridLines="None" EnableViewState="False"
                                CellPadding="4" Width="98%">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <Columns>
                                    <asp:BoundField DataField="PACK_STORE_ID" HeaderText="№" ReadOnly="True" SortExpression="PACK_STORE_ID" />
                                    <asp:BoundField DataField="INPUT_NUMBER" HeaderText="Номер ввода" ReadOnly="True"
                                        SortExpression="INPUT_NUMBER" />
                                    <asp:BoundField DataField="WARD_DESCRIPTION" HeaderText="Накладные" ReadOnly="True"
                                        SortExpression="WARD_DESCRIPTION" />
                                    <asp:BoundField DataField="PACK_QUANTITY" HeaderText="Количество упаковок" ReadOnly="True"
                                        SortExpression="PACK_QUANTITY" />
                                    <asp:BoundField DataField="DATE_RECEIVE" DataFormatString="{0:d}" HeaderText="Дата получения"
                                        ReadOnly="True" SortExpression="DATE_RECEIVE" />
                                    <asp:BoundField DataField="TABLET_PACK_DESCRIPTION_VW" HeaderText="Препарат" ReadOnly="True"
                                        SortExpression="TABLET_PACK_DESCRIPTION_VW" />
                                    <asp:BoundField DataField="TABLET_PACK_DESCRIPTION" HeaderText="Препарат(доп.)" SortExpression="TABLET_PACK_DESCRIPTION" />
                                </Columns>
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnDoubleInput" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="dvwPack_Store" EventName="ItemInserted" />
                            <asp:AsyncPostBackTrigger ControlID="dvwPack_Store" EventName="ItemUpdated" />
                            <asp:AsyncPostBackTrigger ControlID="dvwPack_Store" EventName="ItemDeleted" />
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>
        </cc1:TabContainer>
    </div>
</asp:Content>
