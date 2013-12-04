<%@ Page Title="Центры в проекте" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Center.aspx.cs" Inherits="Marafon.Center" Theme="Marafon" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlFindCenter" runat="server" Style="display: none; text-align: right;
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
                            <asp:Label ID="lblFindCenterNumber" runat="server" Text="Номер центра: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindCenterNumber" runat="server"></asp:TextBox>
                            <asp:CompareValidator ID="cvFindCenterNumber" runat="server" ControlToValidate="tboxFindCenterNumber"
                                CssClass="controls" Display="Dynamic" ErrorMessage="Номер центра должен быть числом!"
                                SetFocusOnError="false" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindRegion" runat="server" Text="Название региона или его часть: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindRegion" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindCity" runat="server" Text="Название города или его часть: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindCity" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindCenter" runat="server" Text="Название центра или его часть: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindCenter" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>

<%--
                <br />
                <br />
                <br />
                <br />--%>
                <br />
                <asp:Button ID="btnFindCenter" runat="server" Text="Найти" OnClick="btnFindCenter_Click" />
                <asp:Button ID="btnCancelFindCenter" runat="server" Text="Отменить поиск" />
            </asp:Panel>
            <asp:SqlDataSource ID="dsrcRegion" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT REGION_ID, DESCRIPTION FROM dbo.REGION ORDER BY DESCRIPTION">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcLogic" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT logic_id, DESCRIPTION FROM dbo.logic where logic_id>=2 and logic_id<=3 ORDER BY logic_id">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcCenter" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Center WHERE (Center_ID = @Center_ID)" 
                InsertCommand="INSERT INTO Center (SUSER) VALUES(@SUSER)"
                SelectCommand="SELECT c.Center_ID, c.Center_number, c.region_id, r.description as region_description, c.city_name, c.DESCRIPTION, c.is_pediatric, l.DESCRIPTION as is_pediatric_description, c.SUSER FROM Center c inner join region r on c.region_id=r.region_id inner join logic l on c.is_pediatric=l.logic_id"
                UpdateCommand="UPDATE Center SET Center_number=@Center_number, region_id=@region_id, city_name=@city_name, DESCRIPTION = @DESCRIPTION, is_pediatric = @is_pediatric, SUSER = @SUSER WHERE Center_ID=@Center_ID"
                ProviderName="System.Data.SqlClient">
                <DeleteParameters>
                    <asp:Parameter Name="Center_ID" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Center_number" />
                    <asp:Parameter Name="region_id" />
                    <asp:Parameter Name="city_name" />
                    <asp:Parameter Name="DESCRIPTION" />
                    <asp:Parameter Name="is_pediatric" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    <asp:Parameter Name="Center_ID" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gvwCenter" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Center_ID"
                DataSourceID="dsrcCenter" ForeColor="#333333" GridLines="None" PageSize="5" SelectedIndex="0"
                OnRowEditing="gvwCenter_RowEditing" OnRowCancelingEdit="gvwCenter_RowCancelingEdit"
                OnRowUpdated="gvwCenter_RowUpdated" Caption="Центры в проекте" OnPageIndexChanging="gvwCenter_PageIndexChanging"
                OnRowCreated="gvwCenter_RowCreated" OnDataBound="gvwCenter_DataBound">
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select"
                                ImageUrl="~/images/16_publish.gif" ToolTip="Выбрать" Text="Выбрать" />
                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                OnClick="btnEdit_Click" />
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
                    <asp:TemplateField HeaderText="Номер центра" SortExpression="Center_number">
                        <ItemTemplate>
                            <asp:Label ID="lblCenterNumber" runat="server" Text='<%# Bind("Center_number") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tboxCenterNumber" runat="server" Text='<%# Bind("Center_number") %>'
                                Width="50px"></asp:TextBox>
                            <asp:CompareValidator ID="CompareValidator1" runat="server" ControlToValidate="tboxCenterNumber"
                                CssClass="controls" Display="Dynamic" ErrorMessage="Неверное число" SetFocusOnError="True"
                                Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                            <asp:RequiredFieldValidator ID="rfvCenterNumber" runat="server" ControlToValidate="tboxCenterNumber"
                                CssClass="controls" Display="Dynamic" ErrorMessage="Введите номер центра" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Регион" SortExpression="REGION_DESCRIPTION">
                        <ItemTemplate>
                            <asp:Label ID="lblRegion" runat="server" Text='<%# Eval("REGION_DESCRIPTION") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlRegion" runat="server" DataSourceID="dsrcRegion" DataTextField="DESCRIPTION"
                                DataValueField="REGION_ID" SelectedValue='<%# Bind("REGION_ID") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvRegion" runat="server" ControlToValidate="ddlRegion"
                                CssClass="controls" Display="Dynamic" ErrorMessage="Выберите регион" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Город" SortExpression="city_name">
                        <ItemTemplate>
                            <asp:Label ID="lblCityName" runat="server" Text='<%# Bind("city_name") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tboxCityName" runat="server" Text='<%# Bind("city_name") %>' Width="200px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvCityName" runat="server" ControlToValidate="tboxCityName"
                                CssClass="controls" Display="Dynamic" ErrorMessage="Введите название города"
                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
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
                    <asp:TemplateField HeaderText="Детский стационар" SortExpression="is_pediatric_description">
                        <ItemTemplate>
                            <asp:Label ID="lblIsPediatric" runat="server" Text='<%# Eval("Is_Pediatric_description") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlIsPediatric" runat="server" DataSourceID="dsrcLogic" DataTextField="DESCRIPTION"
                                DataValueField="logic_ID" SelectedValue='<%# Bind("Is_Pediatric") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvIsPediatric" runat="server" ControlToValidate="ddlIsPediatric"
                                CssClass="controls" Display="Dynamic" ErrorMessage="Укажите, является ли стационар детским" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                OnClick="btnDelete_Click" />
                        </ItemTemplate>
                        <EditItemTemplate>
                        </EditItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <div style="text-align: left; vertical-align: middle">
                <asp:Button ID="btnAddCenter" runat="server" Text="Добавить запись" OnClick="btnAddCenter_Click" />
                <asp:Button ID="btnRefreshCenter" runat="server" Text="Обновить данные" OnClick="btnRefreshCenter_Click" />
                <asp:Button ID="btnFindPopup" runat="server" Text="Поиск" />
            </div>
            <cc1:ModalPopupExtender ID="mpeFindCenter" runat="server" TargetControlID="btnFindPopup"
                PopupControlID="pnlFindCenter" BackgroundCssClass="modalBackground" CancelControlID="btnCancelFindCenter"
                DropShadow="true" PopupDragHandleControlID="pnlFindHeader">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnAddCenter" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnFindCenter" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnRefreshCenter" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="gvwCenter" EventName="DataBound" />
            <asp:AsyncPostBackTrigger ControlID="gvwCenter" EventName="RowCommand" />
        </Triggers>
    </asp:UpdatePanel>
    <br />
    <div style="text-align: left; vertical-align: middle;">
        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
            <cc1:TabPanel runat="server" HeaderText="Отделения" ID="TabPanel1">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:SqlDataSource ID="dsrcWardType" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT WARD_TYPE_ID, DESCRIPTION FROM dbo.WARD_TYPE ORDER BY DESCRIPTION">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsrcWard" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                DeleteCommand="DELETE FROM dbo.WARD WHERE (WARD_ID = @WARD_ID)" InsertCommand="INSERT INTO WARD(CENTER_ID,SUSER) VALUES(@CENTER_ID,@SUSER)"
                                SelectCommand="SELECT WARD.WARD_ID, WARD.WARD_NUMBER, WARD.DESCRIPTION, WARD.SUSER FROM WARD WHERE (WARD.CENTER_ID = @CENTER_ID)"
                                UpdateCommand="UPDATE WARD SET CENTER_ID=@CENTER_ID,WARD_NUMBER=@WARD_NUMBER,DESCRIPTION = @DESCRIPTION,SUSER = @SUSER WHERE (WARD_ID = @WARD_ID)"
                                ProviderName="System.Data.SqlClient">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvwCenter" Name="CENTER_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="WARD_ID" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="gvwCenter" Name="CENTER_ID" PropertyName="SelectedValue" />
                                    <asp:Parameter Name="WARD_NUMBER" />
                                    <asp:Parameter Name="DESCRIPTION" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                    <asp:Parameter Name="WARD_ID" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="gvwCenter" Name="CENTER_ID" PropertyName="SelectedValue" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvwWard" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Ward_ID"
                                DataSourceID="dsrcWard" ForeColor="#333333" GridLines="None" PageSize="15" SelectedIndex="0"
                                OnRowEditing="gvwWard_RowEditing" OnRowCancelingEdit="gvwWard_RowCancelingEdit"
                                OnRowUpdated="gvwWard_RowUpdated" OnRowCreated="gvwWard_RowCreated" OnPageIndexChanging="gvwWard_PageIndexChanging">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                                OnClick="btnEdit_Click" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                                ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSave_Click" />
                                            <asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                ImageUrl="~/images/clear.GIF" ToolTip="Отмена" Text="Отмена" OnClick="btnCancel_Click" />
                                        </EditItemTemplate>
                                        <ControlStyle CssClass="controls" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:TemplateField>
                                    <asp:TemplateField HeaderText="Номер" SortExpression="WARD_NUMBER">
                                        <ItemTemplate>
                                            <asp:Label ID="lblWardNumber" runat="server" Text='<%# Bind("WARD_NUMBER") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="tboxWardNumber" runat="server" Text='<%# Bind("WARD_NUMBER") %>'
                                                Width="50px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvWardNumber" runat="server" ControlToValidate="tboxWardNumber"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Введите номер"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cvWardNumber" runat="server" ControlToValidate="tboxWardNumber"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Номер должен быть числом!"
                                                SetFocusOnError="false" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                                        </EditItemTemplate>
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
                                                OnClick="btnDeleteWard_Click" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                            <div style="text-align: left; vertical-align: middle">
                                <asp:Button ID="btnAddWard" runat="server" Text="Добавить запись" OnClick="btnAddWard_Click" />
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAddCenter" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnFindCenter" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnRefreshCenter" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="gvwCenter" EventName="RowCancelingEdit" />
                            <asp:AsyncPostBackTrigger ControlID="gvwCenter" EventName="RowEditing" />
                            <asp:AsyncPostBackTrigger ControlID="gvwCenter" EventName="RowUpdated" />
                            <asp:AsyncPostBackTrigger ControlID="gvwCenter" EventName="RowCommand" />
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>





            <cc1:TabPanel runat="server" HeaderText="Группы пациентов" ID="TabPanel2">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:SqlDataSource ID="dsrcQuarter" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT quarter_ID, DESCRIPTION FROM dbo.quarter where quarter_number>0 ORDER BY DESCRIPTION">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsrcPatientGroup" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT patient_group_id, DESCRIPTION FROM dbo.patient_group where patient_group_id>1 ORDER BY DESCRIPTION">
                            </asp:SqlDataSource>
                            <asp:SqlDataSource ID="dsrcWardPatientGroupAmount" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                DeleteCommand="DELETE FROM dbo.ward_patient_group_amount WHERE (ward_patient_group_amount_id = @ward_patient_group_amount_id)" 
                                InsertCommand="INSERT INTO ward_patient_group_amount(WARD_ID,SUSER) VALUES(@CENTER_ID,@SUSER)"
                                SelectCommand="SELECT m.ward_patient_group_amount_id,m.WARD_ID, w.description as ward_description, m.patient_group_id, pg.description as patient_group_description, m.calculation_year,m.quarter_id,q.description as quarter_description,m.patient_amount from dbo.ward_patient_group_amount m inner join ward w on m.ward_id=w.ward_id inner join patient_group pg on m.patient_group_id=pg.patient_group_id inner join quarter q on m.quarter_id=q.quarter_id where (W.CENTER_ID = @CENTER_ID)"
                                UpdateCommand="UPDATE ward_patient_group_amount SET WARD_ID=(select top 1 ward_id from ward where center_id=@CENTER_ID),patient_group_id=@patient_group_id,calculation_year = @calculation_year,quarter_id=@quarter_id,patient_amount=@patient_amount,SUSER = @SUSER WHERE (ward_patient_group_amount_ID = @ward_patient_group_amount_ID)"
                                ProviderName="System.Data.SqlClient">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvwCenter" Name="CENTER_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="ward_patient_group_amount_id" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="gvwCenter" Name="CENTER_ID" PropertyName="SelectedValue" />
                                    <asp:Parameter Name="patient_group_id" Type="Int32" />
                                    <asp:Parameter Name="calculation_year" Type="Int32" />
                                    <asp:Parameter Name="quarter_id" Type="Int32" />
                                    <asp:Parameter Name="patient_amount" Type="Int32" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                    <asp:Parameter Name="ward_patient_group_amount_id" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="gvwCenter" Name="CENTER_ID" PropertyName="SelectedValue" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvwWardPatientGroupAmount" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="ward_patient_group_amount_id"
                                DataSourceID="dsrcWardPatientGroupAmount" ForeColor="#333333" GridLines="None" PageSize="15" SelectedIndex="0"
                                OnRowEditing="gvwWardPatientGroupAmount_RowEditing" OnRowCancelingEdit="gvwWardPatientGroupAmount_RowCancelingEdit"
                                OnRowUpdated="gvwWardPatientGroupAmount_RowUpdated" OnRowCreated="gvwWardPatientGroupAmount_RowCreated" OnPageIndexChanging="gvwWardPatientGroupAmount_PageIndexChanging">
                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                                OnClick="btnEdit_Click" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                                ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSave_Click" />
                                            <asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                                ImageUrl="~/images/clear.GIF" ToolTip="Отмена" Text="Отмена" OnClick="btnCancel_Click" />
                                        </EditItemTemplate>
                                        <ControlStyle CssClass="controls" />
                                        <ItemStyle HorizontalAlign="Left" />
                                    </asp:TemplateField>



                                    <asp:TemplateField HeaderText="Возраст детей" SortExpression="patient_group_description">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPatientGroup" runat="server" Text='<%# Eval("Patient_Group_DESCRIPTION") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlPatientGroup" runat="server" DataSourceID="dsrcPatientGroup" DataTextField="DESCRIPTION"
                                                DataValueField="Patient_Group_ID" SelectedValue='<%# Bind("Patient_Group_ID") %>'>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvPatientGroup" runat="server" ControlToValidate="ddlPatientGroup"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Год" SortExpression="calculation_year">
                                        <ItemTemplate>
                                            <asp:Label ID="lblCalculationYear" runat="server" Text='<%# Bind("calculation_year") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="tboxCalculationYear" runat="server" Text='<%# Bind("calculation_year") %>'
                                                Width="50px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvCalculationYear" runat="server" ControlToValidate="tboxCalculationYear"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Введите год"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cvCalculationYear" runat="server" ControlToValidate="tboxCalculationYear"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Год должен быть числом!"
                                                SetFocusOnError="false" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Квартал" SortExpression="quarter_DESCRIPTION">
                                        <ItemTemplate>
                                            <asp:Label ID="lblQuarter" runat="server" Text='<%# Eval("Quarter_DESCRIPTION") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:DropDownList ID="ddlQuarter" runat="server" DataSourceID="dsrcQuarter" DataTextField="DESCRIPTION"
                                                DataValueField="Quarter_ID" SelectedValue='<%# Bind("Quarter_ID") %>'>
                                            </asp:DropDownList>
                                            <asp:RequiredFieldValidator ID="rfvQuarter" runat="server" ControlToValidate="ddlQuarter"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Выберите квартал" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Количество" SortExpression="patient_amount">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPatientAmount" runat="server" Text='<%# Bind("patient_amount") %>'></asp:Label>
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                            <asp:TextBox ID="tboxPatientAmount" runat="server" Text='<%# Bind("patient_amount") %>'
                                                Width="50px"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="rfvPatientAmount" runat="server" ControlToValidate="tboxPatientAmount"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Введите количество детей"
                                                SetFocusOnError="True"></asp:RequiredFieldValidator>
                                            <asp:CompareValidator ID="cvPatientAmount" runat="server" ControlToValidate="tboxPatientAmount"
                                                CssClass="controls" Display="Dynamic" ErrorMessage="Количество должно быть числом!"
                                                SetFocusOnError="false" Type="Integer" Operator="DataTypeCheck"></asp:CompareValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>

                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                                CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                                OnClick="btnDeleteWard_Click" />
                                        </ItemTemplate>
                                        <EditItemTemplate>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                </Columns>
                                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <EditRowStyle BackColor="#2461BF" />
                                <AlternatingRowStyle BackColor="White" />
                            </asp:GridView>
                            <div style="text-align: left; vertical-align: middle">
                                <asp:Button ID="btnAddWardPatientGroupAmount" runat="server" Text="Добавить запись" OnClick="btnAddWardPatientGroupAmount_Click" />
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAddCenter" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnFindCenter" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnRefreshCenter" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="gvwCenter" EventName="RowCancelingEdit" />
                            <asp:AsyncPostBackTrigger ControlID="gvwCenter" EventName="RowEditing" />
                            <asp:AsyncPostBackTrigger ControlID="gvwCenter" EventName="RowUpdated" />
                            <asp:AsyncPostBackTrigger ControlID="gvwCenter" EventName="RowCommand" />
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>






        </cc1:TabContainer>
    </div>
    <%--            </asp:Panel>
        <cc1:CollapsiblePanelExtender ID="pnlWardBody_CollapsiblePanelExtender" 
            runat="server" Enabled="True" TargetControlID="pnlWardBody" ExpandControlID="pnlWardHeader" CollapseControlID="pnlWardHeader"
                Collapsed="True" ImageControlID="btnWardHeader" ExpandedImage="~/Images/collapse_blue.jpg"
                CollapsedImage="~/Images/expand_blue.jpg" SuppressPostBack="true">
        </cc1:CollapsiblePanelExtender> --%>
</asp:Content>
