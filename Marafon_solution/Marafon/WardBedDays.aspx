<%@ Page Title="Койко-дни по стационару" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="WardBedDays.aspx.cs" Inherits="Marafon.WardBedDays"
    Theme="Marafon" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlFindWard" runat="server" Style="display: none; text-align: right;
                vertical-align: middle" CssClass="modalPopup">
                <asp:Panel ID="pnlFindHeader" runat="server" Style="cursor: move; background-color: #DDDDDD;
                    border: solid 1px Gray; color: Black; text-align: center;">
                    <div>
                        <p>
                            Поиск</p>
                    </div>
                </asp:Panel>
                <br />
                <asp:Label ID="lblFindWard" runat="server" Text="Название или его часть: "></asp:Label>
                <asp:TextBox ID="tboxFindWard" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btnFindWard" runat="server" Text="Найти" OnClick="btnFindWard_Click" />
                <asp:Button ID="btnCancelFindWard" runat="server" Text="Отменить поиск" />
            </asp:Panel>
            <asp:SqlDataSource ID="dsrcWard" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                SelectCommand="SELECT WARD.WARD_ID, CAST(CENTER.CENTER_NUMBER AS NVARCHAR(10)) + N' - ' + CAST(WARD.WARD_NUMBER AS NVARCHAR(10)) + N' ' + WARD.DESCRIPTION AS DESCRIPTION, WARD.SUSER, 1 AS IS_ADMIN FROM WARD INNER JOIN WARD_TYPE ON WARD.WARD_TYPE_ID = WARD_TYPE.WARD_TYPE_ID INNER JOIN CENTER ON WARD.CENTER_ID = CENTER.CENTER_ID WHERE (WARD.WARD_ID IN (SELECT WARD_ID FROM VW_WARD_USER WHERE (SUSER = @SUSER))) OR (1 = @IS_ADMIN)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    <asp:SessionParameter Name="IS_ADMIN" SessionField="is_admin" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gvwWard" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Ward_ID"
                DataSourceID="dsrcWard" ForeColor="#333333" GridLines="None" PageSize="15" SelectedIndex="0"
                Caption="Тип накладных"
                OnPageIndexChanging="gvwWard_PageIndexChanging" 
                onrowcreated="gvwWard_RowCreated" ondatabound="gvwWard_DataBound">
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select"
                                ImageUrl="~/images/16_publish.gif" ToolTip="Выбрать" Text="Выбрать" />
                        </ItemTemplate>
                        <ControlStyle CssClass="controls" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Название" SortExpression="DESCRIPTION">
                        <ItemTemplate>
                            <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="center" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <div style="text-align: left; vertical-align: middle">
                <asp:Button ID="btnRefreshWard" runat="server" Text="Обновить данные" OnClick="btnRefreshWard_Click" />
                <asp:Button ID="btnFindPopup" runat="server" Text="Поиск" />
            </div>
            <cc1:ModalPopupExtender ID="mpeFindWard" runat="server" TargetControlID="btnFindPopup"
                PopupControlID="pnlFindWard" BackgroundCssClass="modalBackground" CancelControlID="btnCancelFindWard"
                DropShadow="true" PopupDragHandleControlID="pnlFindHeader">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnFindWard" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnRefreshWard" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="gvwWard" EventName="DataBound" />
            <asp:AsyncPostBackTrigger ControlID="gvwWard" EventName="RowCommand" />
        </Triggers>
    </asp:UpdatePanel>
    <br />
    <div style="text-align: left; vertical-align: middle;">
        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
            <cc1:TabPanel runat="server" HeaderText="Койко-дни" ID="TabPanel1">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:SqlDataSource ID="dsrcQuarter" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT QUARTER_ID, DESCRIPTION FROM dbo.QUARTER ORDER BY DESCRIPTION">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsrcWard_Bed_Days" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                DeleteCommand="DELETE FROM dbo.Ward_Bed_Days WHERE (Ward_Bed_Days_ID = @Ward_Bed_Days_ID)"
                                InsertCommand="INSERT INTO Ward_Bed_Days(Ward_ID,SUSER) VALUES(@Ward_ID,@SUSER)"
                                SelectCommand="SELECT Ward_Bed_Days.Ward_Bed_Days_ID,Ward_Bed_Days.BED_DAYS_YEAR, Ward_Bed_Days.QUARTER_ID, Quarter.Description as quarter_description, Ward_Bed_Days.BED_DAYS, Ward_Bed_Days.SUSER FROM Ward_Bed_Days inner join quarter on ward_bed_days.quarter_id=quarter.quarter_id WHERE (Ward_Bed_Days.Ward_ID = @Ward_ID)"
                                UpdateCommand="UPDATE Ward_Bed_Days SET Ward_ID=@Ward_ID, BED_DAYS_YEAR = @BED_DAYS_YEAR, QUARTER_ID=@QUARTER_ID, BED_DAYS=@BED_DAYS, SUSER = @SUSER WHERE (Ward_Bed_Days_ID = @Ward_Bed_Days_ID)"
                                ProviderName="System.Data.SqlClient">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvwWard" Name="Ward_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="Ward_Bed_Days_ID" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="gvwWard" Name="Ward_ID" PropertyName="SelectedValue" />
                                    <asp:Parameter Name="BED_DAYS_YEAR" />
                                    <asp:Parameter Name="QUARTER_ID" />
                                    <asp:Parameter Name="BED_DAYS" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                    <asp:Parameter Name="Ward_Bed_Days_ID" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="gvwWard" Name="Ward_ID" PropertyName="SelectedValue" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvwWard_Bed_Days" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Ward_Bed_Days_ID"
                                DataSourceID="dsrcWard_Bed_Days" ForeColor="#333333" GridLines="None" PageSize="15"
                                SelectedIndex="0" OnRowEditing="gvwWard_Bed_Days_RowEditing" 
                                OnRowCancelingEdit="gvwWard_Bed_Days_RowCancelingEdit"
                                OnRowUpdated="gvwWard_Bed_Days_RowUpdated"
                                onrowcreated="gvwWard_Bed_Days_RowCreated" 
                                onpageindexchanging="gvwWard_Bed_Days_PageIndexChanging">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать" OnClick="btnEdit_Click" />
                                            &nbsp;
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                                ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSave_Click" />
                                            &nbsp;<asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                ImageUrl="~/images/clear.GIF" ToolTip="Отмена" Text="Отмена" OnClick="btnCancel_Click" />
                                        </EditItemTemplate>
                                        <ControlStyle CssClass="controls" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Год" SortExpression="BED_DAYS_YEAR">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBedDaysYear" runat="server" Text='<%# Bind("BED_DAYS_YEAR") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="tboxBedDaysYear" runat="server" Text='<%# Bind("BED_DAYS_YEAR") %>'
                                                Width="50px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvBedDaysYear" runat="server" ControlToValidate="tboxBedDaysYear"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cvBedDaysYear" runat="server" ControlToValidate="tboxBedDaysYear"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Год должен быть числом!"
                                                SetFocusOnError="false" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Квартал" SortExpression="quarter_description">
                                        <ItemTemplate>
                                            <asp:Label ID="lblQuarter" runat="server" Text='<%# Bind("quarter_description") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlQuarter" runat="server" DataSourceID="dsrcQuarter" DataTextField="DESCRIPTION"
                                                DataValueField="Quarter_ID" SelectedValue='<%# Bind("Quarter_ID") %>'>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvQuarter" runat="server" ControlToValidate="ddlQuarter"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Кол-во койко-дней" SortExpression="BED_DAYS">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBedDays" runat="server" Text='<%# Bind("BED_DAYS") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="tboxBedDays" runat="server" Text='<%# Bind("BED_DAYS") %>' Width="400px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvBedDays" runat="server" ControlToValidate="tboxBedDays"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cvBedDays" runat="server" ControlToValidate="tboxBedDays"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Кол-во койко-дней должно быть числом!"
                                                SetFocusOnError="false" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                                CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                                OnClick="btnDeleteWard_Bed_Days_Click" />
                                        </ItemTemplate>
                        <EditItemTemplate>
                        </EditItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="center" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                            <div style="text-align: left; vertical-align: middle">
                                <asp:Button ID="btnAddWard_Bed_Days" runat="server" Text="Добавить запись" OnClick="btnAddWard_Bed_Days_Click" />
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnFindWard" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnRefreshWard" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="gvwWard" EventName="RowCancelingEdit" />
                            <asp:AsyncPostBackTrigger ControlID="gvwWard" EventName="RowEditing" />
                            <asp:AsyncPostBackTrigger ControlID="gvwWard" EventName="RowUpdated" />
                            <asp:AsyncPostBackTrigger ControlID="gvwWard" EventName="RowCommand" />
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>
        </cc1:TabContainer>
    </div>
</asp:Content>
