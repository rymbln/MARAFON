<%@ Page Title="МНН и торговые названия" Language="C#" MasterPageFile="~/Site.Master"
    AutoEventWireup="true" CodeBehind="GenericAB.aspx.cs" Inherits="Marafon.GenericAB"
    Theme="Marafon" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlFindGeneric_AB" runat="server" Style="display: none; text-align: right;
                vertical-align: middle" CssClass="modalPopup">
                <asp:Panel ID="pnlFindHeader" runat="server" Style="cursor: move; background-color: #DDDDDD;
                    border: solid 1px Gray; color: Black; text-align: center;">
                    <div>
                        <p>
                            Поиск</p>
                    </div>
                </asp:Panel>
                <br />

                <asp:Table ID="tblFind" runat="server">
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindGeneric_AB" runat="server" Text="Название МНН или его часть: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindGeneric_AB" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindTrade_AB" runat="server" Text="Торговое название или его часть: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindTrade_AB" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
<%--
                <br />
                <br />--%>
                <br />
                <asp:Button ID="btnFindGeneric_AB" runat="server" Text="Найти" OnClick="btnFindGeneric_AB_Click" />
                <asp:Button ID="btnCancelFindGeneric_AB" runat="server" Text="Отменить поиск" />
            </asp:Panel>
            <asp:SqlDataSource ID="dsrcAB_Group" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT AB_Group_ID, DESCRIPTION FROM dbo.AB_Group ORDER BY DESCRIPTION">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcGeneric_AB" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Generic_AB WHERE (Generic_AB_ID = @Generic_AB_ID)"
                InsertCommand="INSERT INTO Generic_AB (SUSER) VALUES(@SUSER)" 
                SelectCommand="SELECT dbo.Generic_AB.Generic_AB_ID, dbo.Generic_AB.AB_Group_ID, dbo.AB_Group.description AS AB_Group_DESCRIPTION, dbo.Generic_AB.DESCRIPTION, dbo.Generic_AB.ATC_CODE, dbo.Generic_AB.suser FROM dbo.Generic_AB INNER JOIN dbo.AB_Group ON dbo.Generic_AB.AB_Group_ID = dbo.AB_Group.AB_Group_id"
                UpdateCommand="UPDATE Generic_AB SET AB_Group_ID = @AB_Group_ID, DESCRIPTION = @DESCRIPTION, ATC_CODE=@ATC_CODE, SUSER = @SUSER WHERE Generic_AB_ID=@Generic_AB_ID"
                ProviderName="System.Data.SqlClient">
                <DeleteParameters>
                    <asp:Parameter Name="Generic_AB_ID" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="AB_Group_ID" />
                    <asp:Parameter Name="DESCRIPTION" />
                    <asp:Parameter Name="ATC_CODE" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    <asp:Parameter Name="Generic_AB_ID" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gvwGeneric_AB" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Generic_AB_ID"
                DataSourceID="dsrcGeneric_AB" ForeColor="#333333" GridLines="None" SelectedIndex="0"
                OnRowEditing="gvwGeneric_AB_RowEditing" OnRowCancelingEdit="gvwGeneric_AB_RowCancelingEdit"
                OnRowUpdated="gvwGeneric_AB_RowUpdated"
                Caption="МНН и торговые названия" OnPageIndexChanging="gvwGeneric_AB_PageIndexChanging"
                OnRowCreated="gvwGeneric_AB_RowCreated" 
                ondatabound="gvwGeneric_AB_DataBound">
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select"
                                ImageUrl="~/images/16_publish.gif" ToolTip="Выбрать" Text="Выбрать" />
                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать" OnClick="btnEdit_Click" />
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
                    <asp:TemplateField HeaderText="Группа АБ" SortExpression="AB_Group_DESCRIPTION">
                        <ItemTemplate>
                            <asp:Label ID="lblAB_Group" runat="server" Text='<%# Bind("AB_Group_DESCRIPTION") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlAB_Group" runat="server" DataSourceID="dsrcAB_Group" DataTextField="DESCRIPTION"
                                DataValueField="AB_Group_ID" SelectedValue='<%# Bind("AB_Group_ID") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvAB_Group" runat="server" ControlToValidate="ddlAB_Group"
                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True">
                            </asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Название" SortExpression="DESCRIPTION">
                        <ItemTemplate>
                            <asp:Label ID="Label3" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="TextBox3" runat="server" Text='<%# Bind("DESCRIPTION") %>' Width="500px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="TextBox3"
                                CssClass="controls" Display="Dynamic" ErrorMessage="Введите название" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Код ATC" SortExpression="ATC_CODE">
                        <ItemTemplate>
                            <asp:Label ID="lblATC_CODE" runat="server" Text='<%# Bind("ATC_CODE") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tboxATC_CODE" runat="server" Text='<%# Bind("ATC_CODE") %>' Width="200px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvATC_CODE" runat="server" ControlToValidate="tboxATC_CODE"
                                CssClass="controls" Display="Dynamic" ErrorMessage="Введите код ATC" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                OnClick="btnDelete_Click" />
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
                <asp:Button ID="btnAddGeneric_AB" runat="server" Text="Добавить запись" OnClick="btnAddGeneric_AB_Click" />
                <asp:Button ID="btnRefreshGeneric_AB" runat="server" Text="Обновить данные" OnClick="btnRefreshGeneric_AB_Click" />
                <asp:Button ID="btnFindPopup" runat="server" Text="Поиск" />
            </div>
            <cc1:ModalPopupExtender ID="mpeFind" runat="server" TargetControlID="btnFindPopup"
                PopupControlID="pnlFindGeneric_AB" BackgroundCssClass="modalBackground" CancelControlID="btnCancelFindGeneric_AB"
                DropShadow="true" PopupDragHandleControlID="pnlFindHeader">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnAddGeneric_AB" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnFindGeneric_AB" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnRefreshGeneric_AB" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="DataBound" />
            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="RowCommand" />
        </Triggers>
    </asp:UpdatePanel>
    <br />
    <div style="text-align: left; vertical-align: middle;">
        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
            <cc1:TabPanel runat="server" HeaderText="Торговые названия" ID="TabPanel1">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:SqlDataSource ID="dsrcTrade_AB" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                DeleteCommand="DELETE FROM dbo.Trade_AB WHERE (Trade_AB_ID = @Trade_AB_ID)" InsertCommand="INSERT INTO Trade_AB(Generic_AB_ID,SUSER) VALUES(@Generic_AB_ID,@SUSER)"
                                SelectCommand="SELECT Trade_AB.Trade_AB_ID, Trade_AB.DESCRIPTION, Trade_AB.SUSER FROM Trade_AB WHERE (Trade_AB.Generic_AB_ID = @Generic_AB_ID) order by Trade_AB.DESCRIPTION"
                                UpdateCommand="UPDATE Trade_AB SET Generic_AB_ID=@Generic_AB_ID, DESCRIPTION = @DESCRIPTION, SUSER = @SUSER WHERE (Trade_AB_ID = @Trade_AB_ID)"
                                ProviderName="System.Data.SqlClient">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvwGeneric_AB" Name="Generic_AB_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="Trade_AB_ID" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="gvwGeneric_AB" Name="Generic_AB_ID" PropertyName="SelectedValue" />
                                    <asp:Parameter Name="DESCRIPTION" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                    <asp:Parameter Name="Trade_AB_ID" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="gvwGeneric_AB" Name="Generic_AB_ID" PropertyName="SelectedValue" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvwTrade_AB" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Trade_AB_ID"
                                DataSourceID="dsrcTrade_AB" ForeColor="#333333" GridLines="None" PageSize="15"
                                SelectedIndex="0" OnRowEditing="gvwTrade_AB_RowEditing" OnRowCancelingEdit="gvwTrade_AB_RowCancelingEdit"
                                OnRowUpdated="gvwTrade_AB_RowUpdated"
                                OnPageIndexChanging="gvwTrade_AB_PageIndexChanging" 
                                onrowcreated="gvwTrade_AB_RowCreated">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать" OnClick="btnEdit_Click" />
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
                                    <asp:TemplateField HeaderText="Название" SortExpression="DESCRIPTION">
                                        <ItemTemplate>
                                            <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="tboxDescription" runat="server" Text='<%# Bind("DESCRIPTION") %>'
                                                Width="400px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvDescription" runat="server" ControlToValidate="tboxDescription"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Введите название" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                                CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                                OnClick="btnDeleteTrade_AB_Click" />
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
                                <asp:Button ID="btnAddTrade_AB" runat="server" Text="Добавить запись" OnClick="btnAddTrade_AB_Click" />
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAddGeneric_AB" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnFindGeneric_AB" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnRefreshGeneric_AB" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="RowCancelingEdit" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="RowEditing" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="DataBound" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="RowCommand" />
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>
            <cc1:TabPanel runat="server" HeaderText="Коэффициенты DDD" ID="TabPanel2">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:SqlDataSource ID="dsrcAdminRoute" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT ADMIN_ROUTE_ID, DESCRIPTION FROM dbo.ADMIN_ROUTE ORDER BY DESCRIPTION">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsrcPatientGroup" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT patient_group_ID, DESCRIPTION FROM dbo.patient_group ORDER BY patient_group_id">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsrcDDD_Coeff" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                DeleteCommand="DELETE FROM dbo.DDD_Coeff WHERE (DDD_Coeff_ID = @DDD_Coeff_ID)"
                                InsertCommand="INSERT INTO DDD_Coeff(Generic_AB_ID,SUSER) VALUES(@Generic_AB_ID,@SUSER)"
                                SelectCommand="SELECT DDD_Coeff.DDD_Coeff_ID, DDD_Coeff.ADMIN_ROUTE_ID, Admin_Route.Description as Admin_Route_Description, DDD_Coeff.patient_group_id, patient_group.DESCRIPTION as patient_group_description, DDD_Coeff.UPDATE_YEAR, DDD_Coeff.COEFF_VALUE, DDD_Coeff.SUSER FROM DDD_Coeff inner join admin_route on ddd_coeff.admin_route_id=admin_route.admin_route_id inner join patient_group on ddd_coeff.patient_group_id=patient_group.patient_group_id WHERE (DDD_Coeff.Generic_AB_ID = @Generic_AB_ID)"
                                UpdateCommand="UPDATE DDD_Coeff SET Generic_AB_ID=@Generic_AB_ID, ADMIN_ROUTE_ID = @ADMIN_ROUTE_ID, patient_group_id=@patient_group_id, UPDATE_YEAR=@UPDATE_YEAR, COEFF_VALUE=@COEFF_VALUE, SUSER = @SUSER WHERE (DDD_Coeff_ID = @DDD_Coeff_ID)"
                                ProviderName="System.Data.SqlClient">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvwGeneric_AB" Name="Generic_AB_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="DDD_Coeff_ID" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="gvwGeneric_AB" Name="Generic_AB_ID" PropertyName="SelectedValue" />
                                    <asp:Parameter Name="ADMIN_ROUTE_ID" Type="Int32" />
                                    <asp:Parameter Name="patient_group_ID" Type="Int32" />
                                    <asp:Parameter Name="UPDATE_YEAR" Type="Int32" />
                                    <asp:Parameter Name="COEFF_VALUE" Type="Decimal" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                                    <asp:Parameter Name="DDD_Coeff_ID" Type="Int32" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="gvwGeneric_AB" Name="Generic_AB_ID" PropertyName="SelectedValue" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvwDDD_Coeff" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="DDD_Coeff_ID"
                                DataSourceID="dsrcDDD_Coeff" ForeColor="#333333" GridLines="None" PageSize="15"
                                SelectedIndex="0" 
                                OnRowEditing="gvwDDD_Coeff_RowEditing" 
                                OnRowCreated="gvwDDD_Coeff_RowCreated"
                                OnRowCancelingEdit="gvwDDD_Coeff_RowCancelingEdit" 
                                OnRowUpdated="gvwDDD_Coeff_RowUpdated"
                                onpageindexchanging="gvwDDD_Coeff_PageIndexChanging">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать" OnClick="btnEdit_Click" />
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
                                    <asp:TemplateField HeaderText="Путь введения" SortExpression="ADMIN_ROUTE_DESCRIPTION">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAdminRoute" runat="server" Text='<%# Bind("ADMIN_ROUTE_DESCRIPTION") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlAdminRoute" runat="server" DataSourceID="dsrcAdminRoute"
                                                DataTextField="DESCRIPTION" DataValueField="ADMIN_ROUTE_ID" SelectedValue='<%# Bind("ADMIN_ROUTE_ID") %>'>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvAdminRoute" runat="server" ControlToValidate="ddlAdminRoute"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Группа пациентов" SortExpression="patient_group_DESCRIPTION">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPatientGroup" runat="server" Text='<%# Bind("patient_group_DESCRIPTION") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlPatientGroup" runat="server" DataSourceID="dsrcPatientGroup"
                                                DataTextField="DESCRIPTION" DataValueField="patient_group_ID" SelectedValue='<%# Bind("patient_group_ID") %>'>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvPatientGroup" runat="server" ControlToValidate="ddlPatientGroup"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Год обновления" SortExpression="UPDATE_YEAR">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUpdate_Year" runat="server" Text='<%# Bind("UPDATE_YEAR") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="tboxUpdate_Year" runat="server" Text='<%# Bind("UPDATE_YEAR") %>'
                                                Width="50px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvUpdate_Year" runat="server" ControlToValidate="tboxUpdate_Year"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:RangeValidator ID="rvUpdate_Year" runat="server" Display="Dynamic" ControlToValidate="tboxUpdate_Year"
                                                ErrorMessage="Год выходит за возможный диапазон" MaximumValue="2010" MinimumValue="1980"
                                                Type="Integer">
                                            </asp:RangeValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Коэффициент" SortExpression="COEFF_VALUE">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCoeff_Value" runat="server" Text='<%# Bind("COEFF_VALUE") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="tboxCoeff_Value" runat="server" Text='<%# Bind("COEFF_VALUE") %>'
                                                Width="50px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvCoeff_Value" runat="server" ControlToValidate="tboxCoeff_Value"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cvCoeff_Value" runat="server" ControlToValidate="tboxCoeff_Value"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Коэффициент должен быть числом!"
                                                SetFocusOnError="false" Type="Double" Operator="DataTypeCheck"></asp:CompareValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                                CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                                OnClick="btnDeleteDDD_Coeff_Click" />
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
                                <asp:Button ID="btnAddDDD_Coeff" runat="server" Text="Добавить запись" OnClick="btnAddDDD_Coeff_Click" />
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAddGeneric_AB" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnFindGeneric_AB" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnRefreshGeneric_AB" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="RowCancelingEdit" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="RowEditing" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="DataBound" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="RowCommand" />
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>
            <cc1:TabPanel runat="server" HeaderText="Коэффициенты пересчёта" ID="TabPanel3">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:SqlDataSource ID="dsrcMeasure_Item" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT MEASURE_ITEM_ID, DESCRIPTION FROM dbo.MEASURE_ITEM ORDER BY DESCRIPTION">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsrcGeneric_AB_Coeff" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                DeleteCommand="DELETE FROM dbo.Generic_AB_Coeff WHERE (Generic_AB_Coeff_ID = @Generic_AB_Coeff_ID)"
                                InsertCommand="INSERT INTO Generic_AB_Coeff(Generic_AB_ID,SUSER) VALUES(@Generic_AB_ID,@SUSER)"
                                SelectCommand="SELECT Generic_AB_Coeff.Generic_AB_Coeff_ID, Generic_AB_Coeff.MEASURE_ITEM_ID, MEASURE_ITEM.Description as MEASURE_ITEM_Description, Generic_AB_Coeff.UNITS_COEFF, Generic_AB_Coeff.SUSER FROM Generic_AB_Coeff inner join MEASURE_ITEM on Generic_AB_Coeff.MEASURE_ITEM_id=MEASURE_ITEM.MEASURE_ITEM_id WHERE (Generic_AB_Coeff.Generic_AB_ID = @Generic_AB_ID)"
                                UpdateCommand="UPDATE Generic_AB_Coeff SET Generic_AB_ID=@Generic_AB_ID, MEASURE_ITEM_ID = @MEASURE_ITEM_ID, UNITS_COEFF=@UNITS_COEFF, SUSER = @SUSER WHERE (Generic_AB_Coeff_ID = @Generic_AB_Coeff_ID)"
                                ProviderName="System.Data.SqlClient">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvwGeneric_AB" Name="Generic_AB_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="Generic_AB_Coeff_ID" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="gvwGeneric_AB" Name="Generic_AB_ID" PropertyName="SelectedValue" />
                                    <asp:Parameter Name="MEASURE_ITEM_ID" Type="Int32" />
                                    <asp:Parameter Name="UNITS_COEFF" Type="Decimal" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                                    <asp:Parameter Name="Generic_AB_Coeff_ID" Type="Int32" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="gvwGeneric_AB" Name="Generic_AB_ID" PropertyName="SelectedValue" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvwGeneric_AB_Coeff" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Generic_AB_Coeff_ID"
                                DataSourceID="dsrcGeneric_AB_Coeff" ForeColor="#333333" GridLines="None" PageSize="15"
                                SelectedIndex="0" 
                                OnRowEditing="gvwGeneric_AB_Coeff_RowEditing" 
                                OnRowCreated="gvwGeneric_AB_Coeff_RowCreated"
                                OnRowCancelingEdit="gvwGeneric_AB_Coeff_RowCancelingEdit" 
                                OnRowUpdated="gvwGeneric_AB_Coeff_RowUpdated"
                                onpageindexchanging="gvwGeneric_AB_Coeff_PageIndexChanging">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать" OnClick="btnEdit_Click" />
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
                                    <asp:TemplateField HeaderText="Ед. изм." SortExpression="MEASURE_ITEM_DESCRIPTION">
                                        <ItemTemplate>
                                            <asp:Label ID="lblMeasure_Item" runat="server" Text='<%# Bind("MEASURE_ITEM_DESCRIPTION") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlMeasure_Item" runat="server" DataSourceID="dsrcMeasure_Item"
                                                DataTextField="DESCRIPTION" DataValueField="MEASURE_ITEM_ID" SelectedValue='<%# Bind("MEASURE_ITEM_ID") %>'>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvMeasure_Item" runat="server" ControlToValidate="ddlMeasure_Item"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True">
                                            </asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Коэффициент" SortExpression="UNITS_COEFF">
                                        <ItemTemplate>
                                            <asp:Label ID="lblUNITS_COEFF" runat="server" Text='<%# Bind("UNITS_COEFF") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="tboxUNITS_COEFF" runat="server" Text='<%# Bind("UNITS_COEFF") %>'
                                                Width="50px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvUNITS_COEFF" runat="server" ControlToValidate="tboxUNITS_COEFF"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cvUNITS_COEFF" runat="server" ControlToValidate="tboxUNITS_COEFF"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Коэффициент должен быть числом!"
                                                SetFocusOnError="false" Type="Double" Operator="DataTypeCheck"></asp:CompareValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                                CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                                OnClick="btnDeleteGeneric_AB_Coeff_Click" />
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
                                <asp:Button ID="btnAddGeneric_AB_Coeff" runat="server" Text="Добавить запись" OnClick="btnAddGeneric_AB_Coeff_Click" />
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAddGeneric_AB" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnFindGeneric_AB" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnRefreshGeneric_AB" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="RowCancelingEdit" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="RowEditing" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="DataBound" />
                            <asp:AsyncPostBackTrigger ControlID="gvwGeneric_AB" EventName="RowCommand" />
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>
        </cc1:TabContainer>
    </div>
</asp:Content>
