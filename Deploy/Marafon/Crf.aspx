<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Crf.aspx.cs" Inherits="Marafon.Crf" EnableEventValidation="false"
    Theme="Marafon"  %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server" >
    <%--<script src="Scripts/Validators.js" type="text/javascript"></script>--%>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlFindCrf" runat="server" Style="display: none; text-align: right;
                vertical-align: middle" CssClass="modalPopup">
                <asp:Panel ID="pnlFindHeaderCrf" runat="server" Style="cursor: move; background-color: #DDDDDD;
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
                            <asp:Label ID="lblCenterNumber" runat="server" Text="№ Центра: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tbxCenterNumber" runat="server"></asp:TextBox>
                           
                        </asp:TableCell>
                    </asp:TableRow>
                    
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindCRF_Number" runat="server" Text="№ ИРК: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindCRF_Number" runat="server"></asp:TextBox>
                            <asp:CompareValidator ID="cvFindCRF_Number" runat="server" ControlToValidate="tboxFindCRF_Number"
                                CssClass="controls" Display="Dynamic" ErrorMessage="№ ИРК должен быть числом"
                                SetFocusOnError="True" Type="double" Operator="DataTypeCheck"></asp:CompareValidator>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindCase_History" runat="server" Text="№ истории болезни: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindCase_History" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindFIO" runat="server" Text="Инициалы: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindFIO" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                    <asp:TableRow>
                        <asp:TableCell>
                            <asp:Label ID="lblFindLaboratory_Number" runat="server" Text="Лабораторный №: "></asp:Label>
                        </asp:TableCell>
                        <asp:TableCell>
                            <asp:TextBox ID="tboxFindLaboratory_Number" runat="server"></asp:TextBox>
                        </asp:TableCell>
                    </asp:TableRow>
                </asp:Table>
<%-- 
                <br />
                <br />
                <br />
                <br />--%>
                <br />
                <asp:Button ID="btnFindCrf" runat="server" Text="Поиск" OnClick="btnFindCrf_Click" />
                <asp:Button ID="btnCancelFindCrf" runat="server" Text="Отменить поиск" />
            </asp:Panel>


            <asp:Panel ID="Panel1" runat="server" ScrollBars="Horizontal" >
                <asp:GridView ID="gvwCrf" runat="server" AllowPaging="True" AllowSorting="True" Caption="ИРК"
                    AutoGenerateColumns="False" DataKeyNames="Crf_ID" DataSourceID="dsrcCrf" CellPadding="4"
                    ForeColor="#333333" GridLines="None" Width="98%" OnPageIndexChanging="gvwCrf_PageIndexChanging"
                    SelectedIndex="0" OnSelectedIndexChanging="gvwCrf_SelectedIndexChanging" 
                    OnRowCreated="gvwCrf_RowCreated" ondatabound="gvwCrf_DataBound" 
                    EmptyDataText="Нет данных" EnableModelValidation="True" 
                    onselectedindexchanged="gvwCrf_SelectedIndexChanged" 
                    onpageindexchanged="gvwCrf_PageIndexChanged" PageSize="5">
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
                        <asp:BoundField DataField="center_number" HeaderText="№ центра" ReadOnly="True" SortExpression="center_number" />
                        <asp:BoundField DataField="crf_number" HeaderText="ИРК" ReadOnly="True" SortExpression="crf_number" />
                        <asp:BoundField DataField="case_history" HeaderText="№ истории болезни" ReadOnly="True"
                            SortExpression="case_history" />
                        <asp:BoundField DataField="fio" HeaderText="ФИО пациента" ReadOnly="True" SortExpression="fio" />
                        <asp:BoundField DataField="birth_date" HeaderText="Дата рождения" ReadOnly="True"
                            SortExpression="birth_date" DataFormatString="{0:dd.MM.yyyy}" />
                        <asp:BoundField DataField="sex_description" HeaderText="Пол" ReadOnly="True" SortExpression="sex_description" />
                        <asp:BoundField DataField="hospitalization_date_time" DataFormatString="{0:dd.MM.yyyy HH:mm}"
                            HeaderText="Дата и время госпитализации" ReadOnly="True" SortExpression="hospitalization_date_time" />
                        <asp:BoundField DataField="release_death_date" HeaderText="Дата выписки/смерти" 
                            SortExpression="release_death_date" DataFormatString="{0:dd.MM.yyyy}" />
                        <asp:BoundField DataField="therapy_result_description" HeaderText="Исход лечения"
                            ReadOnly="True" SortExpression="therapy_result_description" />
                        <asp:BoundField DataField="death_reason_text" HeaderText="Причина смерти" ReadOnly="True"
                            SortExpression="death_reason_text" />
                        <asp:BoundField DataField="is_previous_hospitalisation_description" HeaderText="Предшествующие госпитализации (в течение 6 мес.)" ReadOnly="True"
                            SortExpression="is_previous_hospitalisation_description" />
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
                <asp:Button ID="btnAddCrf" runat="server" Text="Добавить ИРК" OnClick="btnAddCrf_Click" />
                <asp:Button ID="btnRefreshCrf" runat="server" Text="Обновить данные" OnClick="btnRefreshCrf_Click" />
                <asp:Button ID="btnFindPopupCrf" runat="server" Text="Поиск" />
            </div>
            <cc1:ModalPopupExtender ID="mpeFindCrf" runat="server" TargetControlID="btnFindPopupCrf"
                PopupControlID="pnlFindCrf" BackgroundCssClass="modalBackground" CancelControlID="btnCancelFindCrf"
                DropShadow="true" PopupDragHandleControlID="pnlFindHeaderCrf">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemInserted" />
            <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemDeleted" />
            <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemUpdated" />
            <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemCommand" />
        </Triggers>
    </asp:UpdatePanel>
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:Panel ID="pnlDetailsView" runat="server">
                <asp:DetailsView ID="dvwCrf" runat="server" AutoGenerateRows="False" DataKeyNames="Crf_ID"
                    DataSourceID="dsrcCrfDetails" EnableModelValidation="True"
                    OnItemDeleted="dvwCrf_ItemDeleted" OnItemUpdated="dvwCrf_ItemUpdated" OnItemUpdating="dvwCrf_ItemUpdating"
                    OnItemCreated="dvwCrf_ItemCreated" ondatabound="dvwCrf_DataBound">
                    <Fields>
                        <asp:TemplateField HeaderText="№ центра" SortExpression="center_number">
                            <ItemTemplate>
                                <asp:Label ID="lblCenter_NumberSelect" runat="server" Text='<%# Eval("Center_Number") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:Label ID="lblCenter_NumberEdit" runat="server" Text='<%# Eval("Center_Number") %>'></asp:Label>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ИРК" SortExpression="Crf_Number">
                            <ItemTemplate>
                                <asp:Label ID="lblCrf_Number" runat="server" Text='<%# Eval("Crf_Number") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxCrf_Number" runat="server" Text='<%# Bind("Crf_Number") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCrf_Number" runat="server" ControlToValidate="tboxCrf_Number"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True">
                                </asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="cvCrf_Number" runat="server" ControlToValidate="tboxCrf_Number"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="№ ИРК должен быть числом"
                                    SetFocusOnError="True" Type="Integer" Operator="DataTypeCheck">
                                </asp:CompareValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="№ истории болезни" SortExpression="Case_History">
                            <ItemTemplate>
                                <asp:Label ID="lblCase_History" runat="server" Text='<%# Eval("Case_History") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxCase_History" runat="server" Text='<%# Bind("Case_History") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvCase_History" runat="server" ControlToValidate="tboxCase_History"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="ФИО пациента" SortExpression="Fio">
                            <ItemTemplate>
                                <asp:Label ID="lblFio" runat="server" Text='<%# Eval("Fio") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxFio" runat="server" Text='<%# Bind("Fio") %>'></asp:TextBox>
                                <asp:RequiredFieldValidator ID="rfvFio" runat="server" ControlToValidate="tboxFio"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator ID="revFio" runat="server" ControlToValidate="tboxFio"
                                    CssClass="controls" Display="Dynamic" ErrorMessage="Только русские буквы" SetFocusOnError="True"
                                    ValidationExpression="([а-яА-Я])+"></asp:RegularExpressionValidator>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Дата рождения" SortExpression="Birth_Date">
                            <ItemTemplate>
                                <asp:Label ID="lblBirth_Date" runat="server" Text='<%# Eval("Birth_Date", "{0:dd.MM.yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxBirth_Date" runat="server" Text='<%# Bind("Birth_Date", "{0:d}") %>'></asp:TextBox>
                                <asp:ImageButton runat="Server" ID="ibBirth_Date" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    AlternateText="Нажмите, чтобы показать календарь" />
                                <cc1:CalendarExtender ID="ceBirth_Date" runat="server" TargetControlID="tboxBirth_Date"
                                    PopupButtonID="ibBirth_Date" Format="dd.MM.yyyy"  />
                                <cc1:MaskedEditExtender ID="meeBirth_Date" runat="server" TargetControlID="tboxBirth_Date"
                                    Mask="99/99/9999" 
                                    CultureName="ru-RU"
                                    MessageValidatorTip="true" 
                                    ClearMaskOnLostFocus="true" 
                                    ClearTextOnInvalid="false"
                                    MaskType="Date" />
                                <cc1:MaskedEditValidator SetFocusOnError="false" ID="mevBirth_Date" runat="server"
                                    ControlToValidate="tboxBirth_Date" ControlExtender="meeBirth_Date"
                                    Display="Dynamic" TooltipMessage="(дд.мм.гггг)"  
                                    IsValidEmpty="false" 
                                    EmptyValueMessage="*" 
                                    InvalidValueMessage="Дата рождения вводится в формате (дд.мм.гггг)" 
                                    MaximumValueMessage="Дата рождения не должна превышать текущую дату" 
                                    MinimumValueMessage="Дата рождения не должна быть меньше 01.01.1900"
                                    MinimumValue="01.01.1900" 
                                    MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>'/>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Пол" SortExpression="Sex_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblSex" runat="server" Text='<%# Eval("Sex_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlSex" runat="server" DataSourceID="dsrcSex" DataTextField="DESCRIPTION"
                                    DataValueField="Sex_ID" SelectedValue='<%# Bind("Sex_ID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Дата и время госпитализации" SortExpression="Hospitalization_Date_Time">
                            <ItemTemplate>
                                <asp:Label ID="lblHospitalization_Date_Time" runat="server" Text='<%# Eval("Hospitalization_Date_Time", "{0:dd.MM.yyyy HH:mm}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxHospitalization_Date_Time" runat="server" Text='<%# Bind("Hospitalization_Date_Time", "{0:dd.MM.yyyy HH:mm}") %>'></asp:TextBox>
<%--                                <asp:ImageButton runat="Server" ID="ibHospitalization_Date_Time" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    AlternateText="Нажмите, чтобы показать календарь" />
                                <cc1:CalendarExtender ID="ceHospitalization_Date_Time" runat="server" TargetControlID="tboxHospitalization_Date_Time"
                                    PopupButtonID="ibHospitalization_Date_Time" Format="dd.MM.yyyy"  />
                                <asp:RangeValidator ID="rvHospitalization_Date_Time" runat="server" ErrorMessage="---"
                                    Type="Date" MinimumValue="01.01.1900" MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>' ControlToValidate="tboxHospitalization_Date_Time"
                                    SetFocusOnError="False" Display="Dynamic"></asp:RangeValidator>--%>
                                <asp:CustomValidator ID="cvHospitalization_Date_TimeMin" runat="server" ErrorMessage="Дата госпитализации не должна быть меньше даты рождения"
                                    controltovalidate="tboxHospitalization_Date_Time" OnServerValidate="fnValidateBirthDate" Display="Dynamic">
                                </asp:CustomValidator>
                                <asp:CustomValidator ID="cvHospitalization_Date_TimeMax" runat="server" ClientValidationFunction="fnValidateMaxNow" ErrorMessage="Дата госпитализации не должна превышать текущую дату"
                                    controltovalidate="tboxHospitalization_Date_Time" Display="Dynamic">
                                </asp:CustomValidator>
                                <cc1:MaskedEditExtender ID="meeHospitalization_Date_Time" runat="server" TargetControlID="tboxHospitalization_Date_Time"
                                    Mask="99/99/9999 99:99" 
                                    MessageValidatorTip="true" 
                                    ClearMaskOnLostFocus="true" 
                                    ClearTextOnInvalid="false"
                                    MaskType="DateTime" AutoComplete="true" />
                                <cc1:MaskedEditValidator SetFocusOnError="false" ID="mevHospitalization_Date_Time" runat="server"
                                    ControlToValidate="tboxHospitalization_Date_Time" ControlExtender="meeHospitalization_Date_Time"
                                    Display="Dynamic" TooltipMessage="(дд.мм.гггг чч:мм)"  
                                    IsValidEmpty="false" 
                                    EmptyValueMessage="*" 
                                    InvalidValueMessage="Дата госпитализации вводится в формате (дд.мм.гггг чч:мм)" 
                                    MaximumValueMessage="Дата госпитализации не должна превышать текущую дату" 
                                    MinimumValueMessage="Дата госпитализации не должна быть меньше 01.01.2010 00:00" />
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Дата выписки/смерти" SortExpression="Release_Death_Date">
                            <ItemTemplate>
                                <asp:Label ID="lblRelease_Death_Date" runat="server" Text='<%# Eval("Release_Death_Date", "{0:d}") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxRelease_Death_Date" runat="server" Text='<%# Bind("Release_Death_Date", "{0:d}") %>'></asp:TextBox>
                                <asp:ImageButton runat="Server" ID="ibRelease_Death_Date" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    AlternateText="Нажмите, чтобы показать календарь" />
                                <cc1:CalendarExtender ID="ceRelease_Death_Date" runat="server" TargetControlID="tboxRelease_Death_Date"
                                    PopupButtonID="ibRelease_Death_Date" Format="dd.MM.yyyy" />
                                <cc1:MaskedEditExtender ID="meeRelease_Death_Date" runat="server" TargetControlID="tboxRelease_Death_Date"
                                    Mask="99/99/9999" 
                                    CultureName="ru-RU"
                                    MessageValidatorTip="true" 
                                    ClearMaskOnLostFocus="true" 
                                    ClearTextOnInvalid="false"
                                    MaskType="Date" />
                                <cc1:MaskedEditValidator SetFocusOnError="false" ID="mevRelease_Death_Date" runat="server"
                                    ControlToValidate="tboxRelease_Death_Date" ControlExtender="meeRelease_Death_Date"
                                    Display="Dynamic" TooltipMessage="(дд.мм.гггг)"  
                                    IsValidEmpty="true"
                                    EmptyValueMessage="*" 
                                    InvalidValueMessage="Дата выписки/смерти вводится в формате (дд.мм.гггг)" 
                                    MaximumValueMessage="Дата выписки/смерти не должна превышать текущую дату" 
                                    MinimumValueMessage="Дата выписки/смерти не должна быть меньше 01.01.2010"
                                    MinimumValue="01.01.2010" 
                                    MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>'/>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Исход лечения" SortExpression="Therapy_Result_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblTherapy_Result" runat="server" Text='<%# Eval("Therapy_Result_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlTherapy_Result" runat="server" DataSourceID="dsrcTherapy_Result"
                                    DataTextField="DESCRIPTION" DataValueField="Therapy_Result_ID" SelectedValue='<%# Bind("Therapy_Result_ID") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Причина смерти" SortExpression="Death_Reason_Text">
                            <ItemTemplate>
                                <asp:Label ID="lblDeath_Reason_Text" runat="server" Text='<%# Eval("Death_Reason_Text") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:TextBox ID="tboxDeath_Reason_Text" runat="server" Text='<%# Bind("Death_Reason_Text") %>'></asp:TextBox>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Предшествующие госпитализации (в течение 6 мес.)" SortExpression="is_previous_hospitalisation_DESCRIPTION">
                            <ItemTemplate>
                                <asp:Label ID="lblIs_Previous_Hospitalisation" runat="server" Text='<%# Eval("is_previous_hospitalisation_DESCRIPTION") %>'></asp:Label>
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:DropDownList ID="ddlIs_Previous_Hospitalisation" runat="server" DataSourceID="dsrcLogic"
                                    DataTextField="DESCRIPTION" DataValueField="logic_ID" SelectedValue='<%# Bind("Is_Previous_Hospitalisation") %>'>
                                </asp:DropDownList>
                            </EditItemTemplate>
                        </asp:TemplateField>
                        <asp:BoundField DataField="date_add" DataFormatString="{0:dd.MM.yyyy HH:mm}" HeaderText="Дата добавления"
                            ReadOnly="True" SortExpression="date_add" />
                        <asp:BoundField DataField="date_update" DataFormatString="{0:dd.MM.yyyy HH:mm}" HeaderText="Дата последнего изменения"
                            ReadOnly="True" SortExpression="date_update" />
                        <asp:BoundField DataField="suser" HeaderText="Пользователь" ReadOnly="True" SortExpression="suser" />
                        <asp:TemplateField ShowHeader="False">
                            <ItemTemplate>
                                <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                    ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                    OnClick="btnEditCrf_Click" />
                                <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" ImageUrl="~/images/16_L_remove.gif"
                                    ToolTip="Удалить" Text="Удалить" OnClientClick="javascript:return confirm('Вы действительно хотите удалит эту запись?');"
                                    OnClick="btnDeleteCrf_Click" />
                            </ItemTemplate>
                            <EditItemTemplate>
                                <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                    ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSaveCrf_Click" />
                                <asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                    ImageUrl="~/images/clear.GIF" ToolTip="Отмена" Text="Отмена" OnClick="btnCancelCrf_Click" />
                            </EditItemTemplate>
                            <ControlStyle CssClass="controls" />
                        </asp:TemplateField>
                    </Fields>
                </asp:DetailsView>
                <asp:Label ID="lblError_Crf" runat="server" Text="" SkinID="ErrorLabel"></asp:Label>
            </asp:Panel>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="SelectedIndexChanged" />
            <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="PageIndexChanged" />
        </Triggers>
    </asp:UpdatePanel>



    <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0" 
        ScrollBars="Both">







        <cc1:TabPanel runat="server" HeaderText="Клин. диагнозы" ID="TabPanel1">
            <ContentTemplate>
                <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="text-align: left; vertical-align: middle">
                        <asp:GridView ID="gvwCrf_Diagnosis_Main" runat="server" AllowPaging="True" AllowSorting="True"
                            AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Crf_Diagnosis_ID"
                            DataSourceID="dsrcCrf_Diagnosis_Main" ForeColor="#333333" GridLines="None" PageSize="15"
                            OnRowEditing="gvwCrf_Diagnosis_Main_RowEditing" OnRowCancelingEdit="gvwCrf_Diagnosis_Main_RowCancelingEdit"
                            OnRowUpdated="gvwCrf_Diagnosis_Main_RowUpdated" OnRowCreated="gvwCrf_Diagnosis_Main_RowCreated"
                            OnPageIndexChanging="gvwCrf_Diagnosis_Main_PageIndexChanging" 
                            EnableModelValidation="True" OnRowUpdating="gvwCrf_Diagnosis_Main_RowUpdating" OnRowDeleting="gvwCrf_Diagnosis_Main_RowDeleting">
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                            OnClick="btnEditCrf_Diagnosis_Main_Click" /></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSaveCrf_Diagnosis_Main_Click" />&#160;<asp:ImageButton
                                                ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/images/clear.GIF"
                                                ToolTip="Отмена" Text="Отмена" OnClick="btnCancelCrf_Diagnosis_Main_Click" /></EditItemTemplate>
                                    <ControlStyle CssClass="controls" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="crf_number" HeaderText="ИРК" ReadOnly="True" SortExpression="crf_number" />
                                <asp:TemplateField HeaderText="Диагноз" SortExpression="diagnosis_text">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiagnosis_Text" runat="server" Text='<%# Eval("diagnosis_text") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <cc1:AutoCompleteExtender 
                                            ID="aceDiagnosis_Text_Main"
                                            BehaviorID="aceDiagnosis_Text_Main_Ex" 
                                            runat="server" 
                                            TargetControlID="tboxDiagnosis_Text" 
                                            ServiceMethod="GetCrf_Diagnosis_Main" 
                                            ServicePath="~/GetAutoComplete.asmx"
                                            MinimumPrefixLength="3" EnableCaching="true"
                                            CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                        <asp:TextBox ID="tboxDiagnosis_Text" runat="server" Text='<%# Bind("diagnosis_text") %>'
                                            Width="400px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDiagnosis_Text" runat="server"
                                            ControlToValidate="tboxDiagnosis_Text" CssClass="controls" Display="Dynamic"
                                            ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                    </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата" SortExpression="start_date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStart_Date" runat="server" Text='<%# Eval("start_date", "{0:d}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxStart_Date" runat="server" Text='<%# Bind("start_date", "{0:d}") %>'></asp:TextBox>
                                <asp:ImageButton runat="Server" ID="ibStart_Date" ImageUrl="~/images/Calendar_scheduleHS.png"
                                    AlternateText="Нажмите, чтобы показать календарь" />
                                <cc1:CalendarExtender ID="ceStart_Date" runat="server" TargetControlID="tboxStart_Date"
                                    PopupButtonID="ibStart_Date" Format="dd.MM.yyyy" />
                                <cc1:MaskedEditExtender ID="meeStart_Date" runat="server" TargetControlID="tboxStart_Date"
                                    Mask="99/99/9999" 
                                    CultureName="ru-RU"
                                    MessageValidatorTip="true" 
                                    ClearMaskOnLostFocus="true" 
                                    ClearTextOnInvalid="false"
                                    MaskType="Date" />
                                <cc1:MaskedEditValidator SetFocusOnError="false" ID="mevStart_Date" runat="server"
                                    ControlToValidate="tboxStart_Date" ControlExtender="meeStart_Date"
                                    Display="Dynamic" TooltipMessage="(дд.мм.гггг)"  
                                    IsValidEmpty="false" 
                                    EmptyValueMessage="*" 
                                    InvalidValueMessage="Дата вводится в формате (дд.мм.гггг)" 
                                    MaximumValueMessage="Дата не должна превышать текущую дату" 
                                    MinimumValueMessage="Дата не должна быть меньше даты рождения"
                                    MinimumValue='<%# GetCrfDate("Birth_Date").ToString("dd.MM.yyyy")%>' 
                                    MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>'/>
                                    <asp:Label ID="lblStart_DateError" runat="server" Text="" SkinID="ErrorLabel" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                            CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                            OnClick="btnDeleteCrf_Diagnosis_Main_Click" /></ItemTemplate>
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
                            <asp:Button ID="btnAddCrf_Diagnosis_Main" runat="server" Text="Добавить клинический диагноз" OnClick="btnAddCrf_Diagnosis_Main_Click" />
                            <asp:Label ID="lblError_Diagnosis_Main" runat="server" Text="" SkinID="ErrorLabel"></asp:Label>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAddCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnFindCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnRefreshCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="PageIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemCommand" />
                    </Triggers>
                </asp:UpdatePanel>
            
</ContentTemplate>
        

</cc1:TabPanel>




        <cc1:TabPanel runat="server" HeaderText="Нозокомиальные инф-и" ID="TabPanel2">
            <ContentTemplate>
                <asp:UpdatePanel ID="UpdatePanel4" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="text-align: left; vertical-align: middle">
                        <asp:GridView ID="gvwCrf_Diagnosis_Nosocomial" runat="server" AllowPaging="True"
                            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" CssClass="controls"
                            DataKeyNames="Crf_Diagnosis_ID" DataSourceID="dsrcCrf_Diagnosis_Nosocomial" ForeColor="#333333"
                            GridLines="None" PageSize="15" OnRowEditing="gvwCrf_Diagnosis_Nosocomial_RowEditing"
                            OnRowCancelingEdit="gvwCrf_Diagnosis_Nosocomial_RowCancelingEdit" OnRowUpdated="gvwCrf_Diagnosis_Nosocomial_RowUpdated"
                            OnRowCreated="gvwCrf_Diagnosis_Nosocomial_RowCreated" OnPageIndexChanging="gvwCrf_Diagnosis_Nosocomial_PageIndexChanging"
                            EnableModelValidation="True" OnRowUpdating="gvwCrf_Diagnosis_Nosocomial_RowUpdating" OnRowDeleting="gvwCrf_Diagnosis_Nosocomial_RowDeleting">
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                            OnClick="btnEditCrf_Diagnosis_Nosocomial_Click" /></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSaveCrf_Diagnosis_Nosocomial_Click" />&#160;<asp:ImageButton
                                                ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/images/clear.GIF"
                                                ToolTip="Отмена" Text="Отмена" OnClick="btnCancelCrf_Diagnosis_Nosocomial_Click" /></EditItemTemplate>
                                    <ControlStyle CssClass="controls" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="crf_number" HeaderText="ИРК" ReadOnly="True" SortExpression="crf_number" />
                                <asp:TemplateField HeaderText="Диагноз" SortExpression="Diagnosis_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiagnosis" runat="server" Text='<%# Eval("Diagnosis_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlDiagnosis" runat="server" DataSourceID="dsrcDiagnosis"
                                            DataTextField="DESCRIPTION" DataValueField="Diagnosis_ID" SelectedValue='<%# Bind("Diagnosis_ID") %>'>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvDiagnosis" runat="server" ControlToValidate="ddlDiagnosis"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Диагноз(доп.)" SortExpression="diagnosis_text">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiagnosis_Text" runat="server" Text='<%# Eval("diagnosis_text") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <cc1:AutoCompleteExtender ID="aceDiagnosis_Text_Nosocomial" BehaviorID="aceDiagnosis_Text_Nosocomial_Ex"
                                            runat="server" TargetControlID="tboxDiagnosis_Text" ServiceMethod="GetCrf_Diagnosis_Nosocomial"
                                            ServicePath="~/GetAutoComplete.asmx" MinimumPrefixLength="3" EnableCaching="true"
                                            CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                        <asp:TextBox ID="tboxDiagnosis_Text" runat="server" Text='<%# Bind("diagnosis_text") %>'
                                            Width="400px"></asp:TextBox>
<%--                                        <asp:RequiredFieldValidator ID="rfvDiagnosis_Text" runat="server" ControlToValidate="tboxDiagnosis_Text"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
--%>                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Локализация" SortExpression="Clinical_Material_Group_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblClinical_Material_Group" runat="server" Text='<%# Eval("Clinical_Material_Group_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlClinical_Material_Group" runat="server" DataSourceID="dsrcClinical_Material_Group"
                                            DataTextField="DESCRIPTION" DataValueField="Clinical_Material_Group_ID" SelectedValue='<%# Bind("Clinical_Material_Group_ID") %>'>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvClinical_Material_Group" runat="server" ControlToValidate="ddlClinical_Material_Group"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата начала" SortExpression="start_date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStart_Date_Nosocomial" runat="server" Text='<%# Eval("start_date", "{0:d}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxStart_Date_Nosocomial" runat="server" Text='<%# Bind("start_date", "{0:d}") %>'></asp:TextBox>
                                        <asp:ImageButton runat="Server" ID="ibStart_Date_Nosocomial" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            AlternateText="Нажмите, чтобы показать календарь" />
                                        <cc1:CalendarExtender ID="ceStart_Date_Nosocomial" runat="server" TargetControlID="tboxStart_Date_Nosocomial"
                                            PopupButtonID="ibStart_Date_Nosocomial" Format="dd.MM.yyyy" />
                                        <cc1:MaskedEditExtender 
                                            ID="meeStart_Date_Nosocomial" 
                                            runat="server" 
                                            TargetControlID="tboxStart_Date_Nosocomial"
                                            Mask="99/99/9999" 
                                            CultureName="ru-RU"
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true" 
                                            ClearTextOnInvalid="false" 
                                            MaskType="Date" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" 
                                            ID="mevStart_Date_Nosocomial" 
                                            runat="server" 
                                            ControlToValidate="tboxStart_Date_Nosocomial"
                                            ControlExtender="meeStart_Date_Nosocomial" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг)"
                                            IsValidEmpty="false" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата начала вводится в формате (дд.мм.гггг)"
                                            MaximumValueMessage="Дата начала не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата начала не должна быть меньше даты рождения"
                                            MinimumValue='<%# GetCrfDate("Birth_Date").ToString("dd.MM.yyyy")%>' 
                                            MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>' />
                                        <asp:Label ID="lblStart_DateError" runat="server" Text="" SkinID="ErrorLabel" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата окончания" SortExpression="End_date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEnd_Date_Nosocomial" runat="server" Text='<%# Eval("end_date", "{0:d}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxEnd_Date_Nosocomial" runat="server" Text='<%# Bind("end_date", "{0:d}") %>'></asp:TextBox>
                                        <asp:ImageButton runat="Server" ID="ibEnd_Date_Nosocomial" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            AlternateText="Нажмите, чтобы показать календарь" />
                                        <cc1:CalendarExtender ID="ceEnd_Date_Nosocomial" runat="server" TargetControlID="tboxEnd_Date_Nosocomial"
                                            PopupButtonID="ibEnd_Date_Nosocomial" Format="dd.MM.yyyy" />
                                        <cc1:MaskedEditExtender 
                                            ID="meeEnd_Date_Nosocomial" 
                                            runat="server" 
                                            TargetControlID="tboxEnd_Date_Nosocomial"
                                            Mask="99/99/9999" 
                                            CultureName="ru-RU" 
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true" 
                                            ClearTextOnInvalid="false" 
                                            MaskType="Date" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" 
                                            ID="mevEnd_Date_Nosocomial" 
                                            runat="server" 
                                            ControlToValidate="tboxEnd_Date_Nosocomial"
                                            ControlExtender="meeEnd_Date_Nosocomial" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг)"
                                            IsValidEmpty="true" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата окончания вводится в формате (дд.мм.гггг)"
                                            MaximumValueMessage="Дата окончания не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата окончания не должна быть меньше даты рождения"
                                            MinimumValue='<%# GetCrfDate("Birth_Date").ToString("dd.MM.yyyy")%>' 
                                            MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>' />
                                        <asp:Label ID="lblEnd_DateError" runat="server" Text="" SkinID="ErrorLabel" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата окончания неизвестна" SortExpression="is_end_date_unknown_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIs_End_Date_Unknown" runat="server" Text='<%# Eval("Is_End_Date_Unknown_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlIs_End_Date_Unknown" runat="server" DataSourceID="dsrcLogic"
                                            DataTextField="DESCRIPTION" DataValueField="logic_id" SelectedValue='<%# Bind("Is_End_Date_Unknown") %>'>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvIs_End_Date_Unknown" runat="server" ControlToValidate="ddlIs_End_Date_Unknown"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Исход лечения" SortExpression="Diagnosis_Result_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiagnosis_Result" runat="server" Text='<%# Eval("Diagnosis_Result_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlDiagnosis_Result" runat="server" DataSourceID="dsrcDiagnosis_Result"
                                            DataTextField="DESCRIPTION" DataValueField="Diagnosis_Result_ID" SelectedValue='<%# Bind("Diagnosis_Result_ID") %>'>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvDiagnosis_Result" runat="server" ControlToValidate="ddlDiagnosis_Result"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                            CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                            OnClick="btnDeleteCrf_Diagnosis_Nosocomial_Click" /></ItemTemplate>
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
                            <asp:Button ID="btnAddCrf_Diagnosis_Nosocomial" runat="server" Text="Добавить нозокомиальную инфекцию"
                                OnClick="btnAddCrf_Diagnosis_Nosocomial_Click" />
                            <asp:Label ID="lblError_Nosocomial" runat="server" Text="" SkinID="ErrorLabel"></asp:Label>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAddCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnFindCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnRefreshCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="PageIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemCommand" />
                        <%--<asp:AsyncPostBackTrigger ControlID="TabContainer1" EventName="ActiveTabChanged" />--%>
                    </Triggers>
                </asp:UpdatePanel>
            
</ContentTemplate>
        

</cc1:TabPanel>






        <cc1:TabPanel runat="server" HeaderText="Операции" ID="TabPanel3" >
            <ContentTemplate>
                <asp:UpdatePanel ID="UpdatePanel5" runat="server" UpdateMode="Conditional" >
                    <ContentTemplate>
                        <div style="text-align: left; vertical-align: middle">
                        <asp:GridView ID="gvwCrf_Diagnosis_Operation" runat="server" AllowPaging="True"
                            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" CssClass="controls"
                            DataKeyNames="Crf_Diagnosis_ID" DataSourceID="dsrcCrf_Diagnosis_Operation" ForeColor="#333333"
                            GridLines="None" PageSize="10" OnRowEditing="gvwCrf_Diagnosis_Operation_RowEditing"
                            OnRowCancelingEdit="gvwCrf_Diagnosis_Operation_RowCancelingEdit" OnRowUpdated="gvwCrf_Diagnosis_Operation_RowUpdated"
                            OnRowCreated="gvwCrf_Diagnosis_Operation_RowCreated" OnPageIndexChanging="gvwCrf_Diagnosis_Operation_PageIndexChanging"
                            OnRowUpdating="gvwCrf_Diagnosis_Operation_RowUpdating" OnRowDeleting="gvwCrf_Diagnosis_Operation_RowDeleting">
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                            OnClick="btnEditCrf_Diagnosis_Operation_Click" /></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSaveCrf_Diagnosis_Operation_Click" />&#160;<asp:ImageButton
                                                ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/images/clear.GIF"
                                                ToolTip="Отмена" Text="Отмена" OnClick="btnCancelCrf_Diagnosis_Operation_Click" /></EditItemTemplate>
                                    <ControlStyle CssClass="controls" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="crf_number" HeaderText="ИРК" ReadOnly="True" SortExpression="crf_number" />
                                <asp:TemplateField HeaderText="Вид оперативного вмешательства" SortExpression="diagnosis_text">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiagnosis_Text" runat="server" Text='<%# Eval("diagnosis_text") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <cc1:AutoCompleteExtender ID="aceDiagnosis_Text_Operation" BehaviorID="aceDiagnosis_Text_Operation_Ex"
                                            runat="server" TargetControlID="tboxDiagnosis_Text" ServiceMethod="GetCrf_Diagnosis_Operation"
                                            ServicePath="~/GetAutoComplete.asmx" MinimumPrefixLength="3" EnableCaching="true"
                                            CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                        <asp:TextBox ID="tboxDiagnosis_Text" runat="server" Text='<%# Bind("diagnosis_text") %>'
                                            Width="400px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvDiagnosis_Text" runat="server" ControlToValidate="tboxDiagnosis_Text"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата начала" SortExpression="start_date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStart_Date_Operation" runat="server" Text='<%# Eval("start_date", "{0:dd.MM.yyyy HH:mm}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxStart_Date_Operation" runat="server" Text='<%# Bind("start_date", "{0:dd.MM.yyyy HH:mm}") %>'></asp:TextBox>
                                        <asp:CustomValidator ID="cvStart_Date_OperationMin" runat="server" ErrorMessage="Дата начала не должна быть меньше даты рождения"
                                            controltovalidate="tboxStart_Date_Operation" OnServerValidate="fnValidateBirthDate" Display="Dynamic">
                                        </asp:CustomValidator>
                                        <asp:CustomValidator ID="cvStart_Date_OperationMax" runat="server" ErrorMessage="Дата начала не должна превышать текущую дату"
                                            controltovalidate="tboxStart_Date_Operation" ClientValidationFunction="fnValidateMaxNow" Display="Dynamic">
                                        </asp:CustomValidator>
                                        

                                        <cc1:MaskedEditExtender 
                                            ID="meeStart_Date_Operation" 
                                            runat="server" 
                                            TargetControlID="tboxStart_Date_Operation"
                                            Mask="99/99/9999 99:99" 
                                            CultureName="ru-RU" 
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true" 
                                            ClearTextOnInvalid="false" 
                                            MaskType="DateTime" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false"
                                            ID="mevStart_Date_Operation" 
                                            runat="server" 
                                            ControlToValidate="tboxStart_Date_Operation"
                                            ControlExtender="meeStart_Date_Operation" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг чч:мм)"
                                            IsValidEmpty="false" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата начала вводится в формате (дд.мм.гггг чч:мм)"
                                            MaximumValueMessage="Дата начала не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата начала не должна быть меньше даты рождения" />

                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата окончания" SortExpression="End_date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEnd_Date_Operation" runat="server" Text='<%# Eval("end_date", "{0:dd.MM.yyyy HH:mm}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxEnd_Date_Operation" runat="server" Text='<%# Bind("end_date", "{0:dd.MM.yyyy HH:mm}") %>'></asp:TextBox>
                                        <asp:CustomValidator ID="cvEnd_Date_OperationMin" runat="server" ErrorMessage="Дата окончания не должна быть меньше даты рождения"
                                            controltovalidate="tboxEnd_Date_Operation" OnServerValidate="fnValidateBirthDate" Display="Dynamic">
                                        </asp:CustomValidator>
                                        <asp:CustomValidator ID="cvEnd_Date_OperationMax" runat="server" ErrorMessage="Дата окончания не должна превышать текущую дату"
                                            controltovalidate="tboxEnd_Date_Operation" ClientValidationFunction="fnValidateMaxNow" Display="Dynamic">
                                        </asp:CustomValidator>
                                        <cc1:MaskedEditExtender 
                                            ID="meeEnd_Date_Operation" 
                                            runat="server" 
                                            TargetControlID="tboxEnd_Date_Operation"
                                            Mask="99/99/9999 99:99" 
                                            CultureName="ru-RU" 
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true" 
                                            ClearTextOnInvalid="false" 
                                            MaskType="DateTime" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false"
                                            ID="mevEnd_Date_Operation" 
                                            runat="server" 
                                            ControlToValidate="tboxEnd_Date_Operation"
                                            ControlExtender="meeEnd_Date_Operation" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг чч:мм)"
                                            IsValidEmpty="false" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата окончания вводится в формате (дд.мм.гггг чч:мм)"
                                            MaximumValueMessage="Дата окончания не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата окончания не должна быть меньше даты рождения" />

                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                            CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                            OnClick="btnDeleteCrf_Diagnosis_Operation_Click" /></ItemTemplate>
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
                        <asp:Button ID="btnAddCrf_Diagnosis_Operation" runat="server" Text="Добавить операцию"
                            OnClick="btnAddCrf_Diagnosis_Operation_Click" />
                        <asp:Label ID="lblError_Operation" runat="server" Text="" SkinID="ErrorLabel"></asp:Label>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAddCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnFindCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnRefreshCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="PageIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemCommand" />
                    </Triggers>
                </asp:UpdatePanel>
            
</ContentTemplate>
        

</cc1:TabPanel>




        <cc1:TabPanel runat="server" HeaderText="Факторы риска" ID="TabPanel4">
            <ContentTemplate>
                <asp:UpdatePanel ID="UpdatePanel6" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="text-align: left; vertical-align: middle">
                        <asp:GridView ID="gvwCrf_Risk_Factor" runat="server" AllowPaging="True"
                            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" CssClass="controls"
                            DataKeyNames="Crf_Risk_Factor_ID" DataSourceID="dsrcCrf_Risk_Factor" ForeColor="#333333"
                            GridLines="None" PageSize="15" OnRowEditing="gvwCrf_Risk_Factor_RowEditing"
                            OnRowCancelingEdit="gvwCrf_Risk_Factor_RowCancelingEdit" OnRowUpdated="gvwCrf_Risk_Factor_RowUpdated"
                            OnRowCreated="gvwCrf_Risk_Factor_RowCreated" OnPageIndexChanging="gvwCrf_Risk_Factor_PageIndexChanging"
                            EnableModelValidation="True" OnRowUpdating="gvwCrf_Risk_Factor_RowUpdating">
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                            OnClick="btnEditCrf_Risk_Factor_Click" /></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSaveCrf_Risk_Factor_Click" />&#160;<asp:ImageButton
                                                ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/images/clear.GIF"
                                                ToolTip="Отмена" Text="Отмена" OnClick="btnCancelCrf_Risk_Factor_Click" /></EditItemTemplate>
                                    <ControlStyle CssClass="controls" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="crf_number" HeaderText="ИРК" ReadOnly="True" SortExpression="crf_number" />
                                <asp:TemplateField HeaderText="Фактор риска" SortExpression="Risk_Factor_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRisk_Factor" runat="server" Text='<%# Eval("Risk_Factor_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlRisk_Factor" runat="server" DataSourceID="dsrcRisk_Factor"
                                            DataTextField="DESCRIPTION" DataValueField="Risk_Factor_ID" SelectedValue='<%# Bind("Risk_Factor_ID") %>'>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvRisk_Factor" runat="server" ControlToValidate="ddlRisk_Factor"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" setfocusonerror="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Фактор риска (доп.)" SortExpression="Risk_Factor_text">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRisk_Factor_Text" runat="server" Text='<%# Eval("Risk_Factor_text") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxRisk_Factor_Text" runat="server" Text='<%# Bind("Risk_Factor_text") %>'
                                            Width="300px"></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата начала" SortExpression="start_date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStart_Date_Risk_Factor" runat="server" Text='<%# Eval("start_date", "{0:d}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxStart_Date_Risk_Factor" runat="server" Text='<%# Bind("start_date", "{0:d}") %>'></asp:TextBox>
                                        <asp:ImageButton runat="Server" ID="ibStart_Date_Risk_Factor" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            AlternateText="Нажмите, чтобы показать календарь" />
                                        <cc1:CalendarExtender ID="ceStart_Date_Risk_Factor" runat="server" TargetControlID="tboxStart_Date_Risk_Factor"
                                            PopupButtonID="ibStart_Date_Risk_Factor" Format="dd.MM.yyyy" />
                                        <cc1:MaskedEditExtender 
                                            ID="meeStart_Date_Risk_Factor" 
                                            runat="server" 
                                            TargetControlID="tboxStart_Date_Risk_Factor"
                                            Mask="99/99/9999" 
                                            CultureName="ru-RU" 
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true" 
                                            ClearTextOnInvalid="false" 
                                            MaskType="Date" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" 
                                            ID="mevStart_Date_Risk_Factor" 
                                            runat="server" 
                                            ControlToValidate="tboxStart_Date_Risk_Factor"
                                            ControlExtender="meeStart_Date_Risk_Factor" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг)"
                                            IsValidEmpty="false" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата начала вводится в формате (дд.мм.гггг)"
                                            MaximumValueMessage="Дата начала не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата начала не должна быть меньше даты рождения"
                                            MinimumValue='<%# GetCrfDate("Birth_Date").ToString("dd.MM.yyyy")%>' 
                                            MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>' />
                                        <asp:Label ID="lblStart_DateError" runat="server" Text="" SkinID="ErrorLabel" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата окончания" SortExpression="End_date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEnd_Date_Risk_Factor" runat="server" Text='<%# Eval("end_date", "{0:d}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxEnd_Date_Risk_Factor" runat="server" Text='<%# Bind("end_date", "{0:d}") %>'></asp:TextBox>
                                        <asp:ImageButton runat="Server" ID="ibEnd_Date_Risk_Factor" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            AlternateText="Нажмите, чтобы показать календарь" />
                                        <cc1:CalendarExtender ID="ceEnd_Date_Risk_Factor" runat="server" TargetControlID="tboxEnd_Date_Risk_Factor"
                                            PopupButtonID="ibEnd_Date_Risk_Factor" Format="dd.MM.yyyy" />
                                        <cc1:MaskedEditExtender 
                                            ID="meeEnd_Date_Risk_Factor" 
                                            runat="server" 
                                            TargetControlID="tboxEnd_Date_Risk_Factor"
                                            Mask="99/99/9999" 
                                            CultureName="ru-RU" 
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true"
                                            ClearTextOnInvalid="false" 
                                            MaskType="Date" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" 
                                            ID="mevEnd_Date_Risk_Factor" 
                                            runat="server" 
                                            ControlToValidate="tboxEnd_Date_Risk_Factor"
                                            ControlExtender="meeEnd_Date_Risk_Factor" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг)"
                                            IsValidEmpty="true" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата окончания вводится в формате (дд.мм.гггг)"
                                            MaximumValueMessage="Дата окончания не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата окончания не должна быть меньше даты рождения"
                                            MinimumValue='<%# GetCrfDate("Birth_Date").ToString("dd.MM.yyyy")%>' 
                                            MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>' />
                                        <asp:Label ID="lblEnd_DateError" runat="server" Text="" SkinID="ErrorLabel" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Продолжается" SortExpression="Is_Continue_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIs_Continue" runat="server" Text='<%# Eval("Is_Continue_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlIs_Continue" runat="server" DataSourceID="dsrcLogic"
                                            DataTextField="DESCRIPTION" DataValueField="logic_id" SelectedValue='<%# Bind("Is_Continue") %>'>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvIs_Continue" runat="server" ControlToValidate="ddlIs_Continue"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" setfocusonerror="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                            CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                            OnClick="btnDeleteCrf_Risk_Factor_Click" /></ItemTemplate>
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
                            <asp:Button ID="btnAddCrf_Risk_Factor" runat="server" Text="Добавить фактор риска"
                                OnClick="btnAddCrf_Risk_Factor_Click" />
                            <asp:Label ID="lblError_Risk_Factor" runat="server" Text="" SkinID="ErrorLabel"></asp:Label>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAddCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnFindCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnRefreshCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="PageIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemCommand" />
                        <%--<asp:AsyncPostBackTrigger ControlID="TabContainer1" EventName="ActiveTabChanged" />--%>
                    </Triggers>
                </asp:UpdatePanel>
            
</ContentTemplate>
        

</cc1:TabPanel>




        <cc1:TabPanel runat="server" HeaderText="Предшеств. госпитализации" ID="TabPanel6">
            <ContentTemplate>
                <asp:UpdatePanel ID="UpdatePanel8" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="text-align: left; vertical-align: middle">
                        <asp:GridView ID="gvwCrf_Previous_Hospitalisation" runat="server" AllowPaging="True"
                            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" CssClass="controls"
                            DataKeyNames="Crf_Previous_Hospitalisation_ID" DataSourceID="dsrcCrf_Previous_Hospitalisation" ForeColor="#333333"
                            GridLines="None" PageSize="15" OnRowEditing="gvwCrf_Previous_Hospitalisation_RowEditing"
                            OnRowCancelingEdit="gvwCrf_Previous_Hospitalisation_RowCancelingEdit" OnRowUpdated="gvwCrf_Previous_Hospitalisation_RowUpdated"
                            OnRowCreated="gvwCrf_Previous_Hospitalisation_RowCreated" OnPageIndexChanging="gvwCrf_Previous_Hospitalisation_PageIndexChanging"
                            EnableModelValidation="True" OnRowUpdating="gvwCrf_Previous_Hospitalisation_RowUpdating">
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                            OnClick="btnEditCrf_Previous_Hospitalisation_Click" /></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSaveCrf_Previous_Hospitalisation_Click" />&#160;<asp:ImageButton
                                                ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/images/clear.GIF"
                                                ToolTip="Отмена" Text="Отмена" OnClick="btnCancelCrf_Previous_Hospitalisation_Click" /></EditItemTemplate>
                                    <ControlStyle CssClass="controls" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="crf_number" HeaderText="ИРК" ReadOnly="True" SortExpression="crf_number" />
                                <asp:TemplateField HeaderText="Город" SortExpression="City_Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCity_Name" runat="server" Text='<%# Eval("City_Name") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <cc1:AutoCompleteExtender ID="aceCity_Name" BehaviorID="aceCity_NameEx"
                                            runat="server" TargetControlID="tboxCity_Name" ServiceMethod="GetCrf_Previous_Hospitalization_City"
                                            ServicePath="~/GetAutoComplete.asmx" MinimumPrefixLength="2" EnableCaching="true"
                                            CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                        <asp:TextBox ID="tboxCity_Name" runat="server" Text='<%# Bind("City_Name") %>'
                                            Width="300px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvCity_Name" runat="server" ControlToValidate="tboxCity_Name"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" setfocusonerror="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Стационар" SortExpression="Stationar_Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblStationar_Name" runat="server" Text='<%# Eval("Stationar_Name") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <cc1:AutoCompleteExtender ID="aceStationar_Name" BehaviorID="aceStationar_NameEx"
                                            runat="server" TargetControlID="tboxStationar_Name" ServiceMethod="GetCrf_Previous_Hospitalization_Stationar"
                                            ServicePath="~/GetAutoComplete.asmx" MinimumPrefixLength="2" EnableCaching="true"
                                            CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                        <asp:TextBox ID="tboxStationar_Name" runat="server" Text='<%# Bind("Stationar_Name") %>'
                                            Width="300px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvStationar_Name" runat="server" ControlToValidate="tboxStationar_Name"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" setfocusonerror="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата госпитализации" SortExpression="Hospitalisation_Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblHospitalisation_Date_Ward_Transfer" runat="server" Text='<%# Eval("Hospitalisation_Date", "{0:d}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxHospitalisation_Date_Ward_Transfer" runat="server" Text='<%# Bind("Hospitalisation_Date", "{0:d}") %>'></asp:TextBox>
                                        <asp:ImageButton runat="Server" ID="ibHospitalisation_Date_Ward_Transfer" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            AlternateText="Нажмите, чтобы показать календарь" />
                                        <cc1:CalendarExtender ID="ceHospitalisation_Date_Ward_Transfer" runat="server" TargetControlID="tboxHospitalisation_Date_Ward_Transfer"
                                            PopupButtonID="ibHospitalisation_Date_Ward_Transfer" Format="dd.MM.yyyy" />
                                        <cc1:MaskedEditExtender 
                                            ID="meeHospitalisation_Date_Ward_Transfer" 
                                            runat="server" 
                                            TargetControlID="tboxHospitalisation_Date_Ward_Transfer"
                                            Mask="99/99/9999" 
                                            CultureName="ru-RU" 
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true"
                                            ClearTextOnInvalid="false" 
                                            MaskType="Date" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" 
                                            ID="mevHospitalisation_Date_Ward_Transfer" 
                                            runat="server" 
                                            ControlToValidate="tboxHospitalisation_Date_Ward_Transfer"
                                            ControlExtender="meeHospitalisation_Date_Ward_Transfer" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг)"
                                            IsValidEmpty="false" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата госпитализации вводится в формате (дд.мм.гггг)"
                                            MaximumValueMessage="Дата госпитализации не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата госпитализации не должна быть меньше 6 месяцев со дня госпитализации"
                                            MinimumValue='<%# GetCrfDate("Hospitalization_Date_Time").AddMonths(-6).ToString("dd.MM.yyyy")%>' 
                                            MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>' />
                                        <asp:Label ID="lblHospitalisation_DateError" runat="server" Text="" SkinID="ErrorLabel" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата выписки/перевода" SortExpression="Release_Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRelease_Date_Ward_Transfer" runat="server" Text='<%# Eval("Release_Date", "{0:d}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxRelease_Date_Ward_Transfer" runat="server" Text='<%# Bind("Release_Date", "{0:d}") %>'></asp:TextBox>
                                        <asp:ImageButton runat="Server" ID="ibRelease_Date_Ward_Transfer" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            AlternateText="Нажмите, чтобы показать календарь" />
                                        <cc1:CalendarExtender ID="ceRelease_Date_Ward_Transfer" runat="server" TargetControlID="tboxRelease_Date_Ward_Transfer"
                                            PopupButtonID="ibRelease_Date_Ward_Transfer" Format="dd.MM.yyyy" />
                                        <cc1:MaskedEditExtender 
                                            ID="meeRelease_Date_Ward_Transfer" 
                                            runat="server" 
                                            TargetControlID="tboxRelease_Date_Ward_Transfer"
                                            Mask="99/99/9999" 
                                            CultureName="ru-RU" 
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true"
                                            ClearTextOnInvalid="false" 
                                            MaskType="Date" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" 
                                            ID="mevRelease_Date_Ward_Transfer" 
                                            runat="server" 
                                            ControlToValidate="tboxRelease_Date_Ward_Transfer"
                                            ControlExtender="meeRelease_Date_Ward_Transfer" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг)"
                                            IsValidEmpty="true" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата выписки/перевода вводится в формате (дд.мм.гггг)"
                                            MaximumValueMessage="Дата выписки/перевода не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата выписки/перевода не должна быть меньше 6 месяцев со дня госпитализации"
                                            MinimumValue='<%# GetCrfDate("Hospitalization_Date_Time").AddMonths(-8).ToString("dd.MM.yyyy")%>' 
                                            MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>' />
                                        <asp:Label ID="lblRelease_DateError" runat="server" Text="" SkinID="ErrorLabel" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                            CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                            OnClick="btnDeleteCrf_Previous_Hospitalisation_Click" /></ItemTemplate>
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
                            <asp:Button ID="btnAddCrf_Previous_Hospitalisation" runat="server" Text="Добавить госпитализацию"
                                OnClick="btnAddCrf_Previous_Hospitalisation_Click" />
                            <asp:Label ID="lblError_Previous_Hospitalisation" runat="server" Text="" SkinID="ErrorLabel"></asp:Label>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAddCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnFindCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnRefreshCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="PageIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemCommand" />
                    </Triggers>
                </asp:UpdatePanel>
            
</ContentTemplate>
        

</cc1:TabPanel>





        <cc1:TabPanel runat="server" HeaderText="Пребывание в отделениях " ID="TabPanel5">
            <ContentTemplate>
                <asp:UpdatePanel ID="UpdatePanel7" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>
                        <div style="text-align: left; vertical-align: middle">
                        <asp:GridView ID="gvwCrf_Ward_Transfer" runat="server" AllowPaging="True"
                            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" CssClass="controls"
                            DataKeyNames="Crf_Ward_Transfer_ID" DataSourceID="dsrcCrf_Ward_Transfer" ForeColor="#333333"
                            GridLines="None" PageSize="15" OnRowEditing="gvwCrf_Ward_Transfer_RowEditing"
                            OnRowCancelingEdit="gvwCrf_Ward_Transfer_RowCancelingEdit" OnRowUpdated="gvwCrf_Ward_Transfer_RowUpdated"
                            OnRowCreated="gvwCrf_Ward_Transfer_RowCreated" OnPageIndexChanging="gvwCrf_Ward_Transfer_PageIndexChanging"
                            EnableModelValidation="True" OnRowUpdating="gvwCrf_Ward_Transfer_RowUpdating">
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                            OnClick="btnEditCrf_Ward_Transfer_Click" /></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSaveCrf_Ward_Transfer_Click" />&#160;<asp:ImageButton
                                                ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/images/clear.GIF"
                                                ToolTip="Отмена" Text="Отмена" OnClick="btnCancelCrf_Ward_Transfer_Click" /></EditItemTemplate>
                                    <ControlStyle CssClass="controls" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="crf_number" HeaderText="ИРК" ReadOnly="True" SortExpression="crf_number" />
                                <asp:TemplateField HeaderText="Отделение" SortExpression="Ward_Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWard_Name" runat="server" Text='<%# Eval("Ward_Name") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <cc1:AutoCompleteExtender ID="aceWard_Name" BehaviorID="aceWard_NameEx"
                                            runat="server" TargetControlID="tboxWard_Name" ServiceMethod="GetCrf_Ward_Transfer"
                                            ServicePath="~/GetAutoComplete.asmx" MinimumPrefixLength="3" EnableCaching="true"
                                            CompletionInterval="100">
                                        </cc1:AutoCompleteExtender>
                                        <asp:TextBox ID="tboxWard_Name" runat="server" Text='<%# Bind("Ward_Name") %>'
                                            Width="400px"></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvWard_Name" runat="server" ControlToValidate="tboxWard_Name"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" setfocusonerror="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Тип отделения" SortExpression="Ward_Type_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWard_Type" runat="server" Text='<%# Eval("Ward_Type_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlWard_Type" runat="server" DataSourceID="dsrcWard_Type"
                                            DataTextField="DESCRIPTION" DataValueField="Ward_Type_ID" SelectedValue='<%# Bind("Ward_Type_ID") %>'>
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="rfvWard_Type" runat="server" ControlToValidate="ddlWard_Type"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" setfocusonerror="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата поступления" SortExpression="Entering_Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblEntering_Date_Ward_Transfer" runat="server" Text='<%# Eval("Entering_Date", "{0:d}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxEntering_Date_Ward_Transfer" runat="server" Text='<%# Bind("Entering_Date", "{0:d}") %>'></asp:TextBox>
                                        <asp:ImageButton runat="Server" ID="ibEntering_Date_Ward_Transfer" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            AlternateText="Нажмите, чтобы показать календарь" />
                                        <cc1:CalendarExtender ID="ceEntering_Date_Ward_Transfer" runat="server" TargetControlID="tboxEntering_Date_Ward_Transfer"
                                            PopupButtonID="ibEntering_Date_Ward_Transfer" Format="dd.MM.yyyy" />
                                        <cc1:MaskedEditExtender 
                                            ID="meeEntering_Date_Ward_Transfer" 
                                            runat="server" 
                                            TargetControlID="tboxEntering_Date_Ward_Transfer"
                                            Mask="99/99/9999" 
                                            CultureName="ru-RU" 
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true"
                                            ClearTextOnInvalid="false" 
                                            MaskType="Date" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" 
                                            ID="mevEntering_Date_Ward_Transfer" 
                                            runat="server" 
                                            ControlToValidate="tboxEntering_Date_Ward_Transfer"
                                            ControlExtender="meeEntering_Date_Ward_Transfer" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг)"
                                            IsValidEmpty="false" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата поступления вводится в формате (дд.мм.гггг)"
                                            MaximumValueMessage="Дата поступления не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата поступления не должна быть меньше даты рождения"
                                            MinimumValue='<%# GetCrfDate("Birth_Date").ToString("dd.MM.yyyy")%>' 
                                            MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>' />
                                        <%--<asp:Label ID="lblEntering_DateError" runat="server" Text="" SkinID="ErrorLabel" />--%>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата перевода" SortExpression="transfer_date">
                                    <ItemTemplate>
                                        <asp:Label ID="lbltransfer_date_Ward_Transfer" runat="server" Text='<%# Eval("transfer_date", "{0:d}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxtransfer_date_Ward_Transfer" runat="server" Text='<%# Bind("transfer_date", "{0:d}") %>'></asp:TextBox>
                                        <asp:ImageButton runat="Server" ID="ibtransfer_date_Ward_Transfer" ImageUrl="~/images/Calendar_scheduleHS.png"
                                            AlternateText="Нажмите, чтобы показать календарь" />
                                        <cc1:CalendarExtender ID="cetransfer_date_Ward_Transfer" runat="server" TargetControlID="tboxtransfer_date_Ward_Transfer"
                                            PopupButtonID="ibtransfer_date_Ward_Transfer" Format="dd.MM.yyyy" />
                                        <cc1:MaskedEditExtender 
                                            ID="meetransfer_date_Ward_Transfer" 
                                            runat="server" 
                                            TargetControlID="tboxtransfer_date_Ward_Transfer"
                                            Mask="99/99/9999" 
                                            CultureName="ru-RU" 
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true"
                                            ClearTextOnInvalid="false" 
                                            MaskType="Date" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" 
                                            ID="mevtransfer_date_Ward_Transfer" 
                                            runat="server" 
                                            ControlToValidate="tboxtransfer_date_Ward_Transfer"
                                            ControlExtender="meetransfer_date_Ward_Transfer" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг)"
                                            IsValidEmpty="true" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата перевода вводится в формате (дд.мм.гггг)"
                                            MaximumValueMessage="Дата перевода не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата перевода не должна быть меньше даты рождения"
                                            MinimumValue='<%# GetCrfDate("Birth_Date").ToString("dd.MM.yyyy")%>' 
                                            MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>' />
                                        <asp:Label ID="lbltransfer_dateError" runat="server" Text="" SkinID="ErrorLabel" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                            CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                            OnClick="btnDeleteCrf_Ward_Transfer_Click" /></ItemTemplate>
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
                            <asp:Button ID="btnAddCrf_Ward_Transfer" runat="server" Text="Добавить отделение"
                                OnClick="btnAddCrf_Ward_Transfer_Click" />
                            <asp:Label ID="lblError_Ward_Transfer" runat="server" Text="" SkinID="ErrorLabel"></asp:Label>
                        </div>
                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAddCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnFindCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnRefreshCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="PageIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemCommand" />
                        <%--<asp:AsyncPostBackTrigger ControlID="TabContainer1" EventName="ActiveTabChanged" />--%>
                    </Triggers>
                </asp:UpdatePanel>
            
</ContentTemplate>
        

</cc1:TabPanel>


        <cc1:TabPanel runat="server" HeaderText="АМТ в ЛПУ" ID="TabPanel7">
            <ContentTemplate>


                <asp:UpdatePanel ID="UpdatePanel9" runat="server" UpdateMode="Conditional"><ContentTemplate>
                    <asp:Panel ID="Panel2" runat="server" ScrollBars="Horizontal" >

            <asp:SqlDataSource ID="dsrcCrf_Therapy" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                SelectCommand="SELECT  crf_therapy_id, crf_id, crf_number, trade_ab_id, trade_ad_description, trade_ab_other, single_dose, measure_item_id, measure_item_description, frequency_id, frequency_description, admin_route_id, admin_route_description, admin_route_other, prescription_date_time, abolition_date_time, therapy_reason_id, therapy_reason_description, crf_diagnosis_id, diagnosis_text, therapy_type_id, therapy_type_description, suser FROM VW_INTERFACE_CRF_THERAPY WHERE (crf_id = @crf_id)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsrcCrf_TherapyDetails" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM Crf_Therapy WHERE (Crf_Therapy_ID = @Crf_Therapy_ID)" 
                InsertCommand="INSERT INTO Crf_Therapy(Crf_id,SUSER) VALUES (@Crf_ID,@SUSER)"
                SelectCommand="SELECT crf_therapy_id, crf_id, crf_number, trade_ab_id, trade_ad_description, trade_ab_other, single_dose, measure_item_id, measure_item_description, frequency_id, frequency_description, admin_route_id, admin_route_description, admin_route_other, prescription_date_time, abolition_date_time, therapy_reason_id, therapy_reason_description, crf_diagnosis_id, diagnosis_text, therapy_type_id, therapy_type_description, suser FROM VW_INTERFACE_CRF_THERAPY WHERE (crf_therapy_id = @crf_therapy_id)"
                UpdateCommand="UPDATE Crf_Therapy SET trade_ab_id=@trade_ab_id, trade_ab_other=@trade_ab_other, single_dose=@single_dose, measure_item_id=@measure_item_id, frequency_id=@frequency_id, admin_route_id=@admin_route_id, admin_route_other=@admin_route_other, prescription_date_time=@prescription_date_time, abolition_date_time=@abolition_date_time, therapy_reason_id=@therapy_reason_id, crf_diagnosis_id=@crf_diagnosis_id, therapy_type_id=@therapy_type_id, SUSER = @SUSER WHERE (crf_therapy_id = @crf_therapy_id)"
                ProviderName="System.Data.SqlClient">
                <DeleteParameters>
                    <asp:Parameter Name="Crf_Therapy_ID" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter Name="crf_therapy_id" ControlID="gvwCrf_Therapy" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="trade_ab_id" Type="Int32" />
                    <asp:Parameter Name="trade_ab_other" Type="String" />
                    <asp:Parameter Name="single_dose" Type="Decimal" />
                    <asp:Parameter Name="measure_item_id" Type="Int32" />
                    <asp:Parameter Name="frequency_id" Type="Int32" />
                    <asp:Parameter Name="admin_route_id" Type="Int32" />
                    <asp:Parameter Name="admin_route_other" Type="String" />
                    <asp:Parameter Name="prescription_date_time" Type="DateTime" />
                    <asp:Parameter Name="abolition_date_time" Type="DateTime" />
                    <asp:Parameter Name="therapy_reason_id" Type="Int32" />
                    <asp:Parameter Name="crf_diagnosis_id" Type="Int32" />
                    <asp:Parameter Name="therapy_type_id" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                    <asp:ControlParameter ControlID="gvwCrf_Therapy" Name="Crf_Therapy_ID" PropertyName="SelectedValue" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>

                    <div style="text-align: left; vertical-align: middle">
                        <asp:GridView ID="gvwCrf_Therapy" runat="server" AllowPaging="True"
                            AllowSorting="True"
                            AutoGenerateColumns="False" DataKeyNames="crf_therapy_id" 
                            DataSourceID="dsrcCrf_Therapy" CellPadding="4"
                            ForeColor="#333333" GridLines="None" Width="98%" OnPageIndexChanging="gvwCrf_Therapy_PageIndexChanging"
                            SelectedIndex="0" OnSelectedIndexChanging="gvwCrf_Therapy_SelectedIndexChanging" 
                            OnRowCreated="gvwCrf_Therapy_RowCreated" 
                            EnableModelValidation="True" onload="gvwCrf_Therapy_Load" >
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
                                <asp:BoundField DataField="crf_number" HeaderText="ИРК" ReadOnly="True" SortExpression="crf_number" />
                                <asp:BoundField DataField="trade_ad_description" 
                                    HeaderText="Торговое наименование" ReadOnly="True"
                                    SortExpression="trade_ad_description" />
<%--                                <asp:BoundField DataField="trade_ab_other" 
                                    HeaderText="Торговое наименование (доп.)" ReadOnly="True" 
                                    SortExpression="trade_ab_other" />
--%>                                <asp:BoundField DataField="single_dose" HeaderText="Разовая доза" ReadOnly="True"
                                    SortExpression="single_dose" />
                                <asp:BoundField DataField="measure_item_description" HeaderText="Ед. изм." 
                                    ReadOnly="True" SortExpression="measure_item_description" />
                                <asp:BoundField DataField="frequency_description"
                                    HeaderText="Кратность" ReadOnly="True" 
                                    SortExpression="frequency_description" />
                                <asp:BoundField DataField="admin_route_description" HeaderText="Путь введения" 
                                    SortExpression="admin_route_description" ReadOnly="True" />
                                <asp:BoundField DataField="admin_route_other" HeaderText="Путь введения (другой)"
                                    ReadOnly="True" SortExpression="admin_route_other" />
                                <asp:BoundField DataField="prescription_date_time" 
                                    HeaderText="Дата и время назначения" ReadOnly="True"
                                    SortExpression="prescription_date_time" 
                                    DataFormatString="{0:dd.MM.yyyy HH:mm}" />
                                <asp:BoundField DataField="abolition_date_time" 
                                    DataFormatString="{0:dd.MM.yyyy HH:mm}" HeaderText="Дата и время отмены" 
                                    SortExpression="abolition_date_time" />
                                <asp:BoundField DataField="therapy_reason_description" 
                                    HeaderText="Цель назначения" ReadOnly="True" 
                                    SortExpression="therapy_reason_description" />
                                <asp:BoundField DataField="diagnosis_text" HeaderText="Диагноз" ReadOnly="True" 
                                    SortExpression="diagnosis_text" />
                                <asp:BoundField DataField="therapy_type_description" HeaderText="Вид АМТ" 
                                    ReadOnly="True" SortExpression="therapy_type_description" />
                            </Columns>
                            <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="Center" />
                            <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                            <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <EditRowStyle BackColor="#2461BF" />
                            <AlternatingRowStyle BackColor="White" />
                        </asp:GridView>
                    </asp:Panel>
                        <asp:Button ID="btnAddCrf_Therapy" runat="server" Text="Добавить препарат"
                            OnClick="btnAddCrf_Therapy_Click" />
                    </div>


                    <asp:Panel ID="Panel3" runat="server">
                        <asp:DetailsView ID="dvwCrf_Therapy" runat="server" AutoGenerateRows="False" DataKeyNames="Crf_Therapy_ID"
                            DataSourceID="dsrcCrf_TherapyDetails" EnableModelValidation="True"
                            OnItemDeleted="dvwCrf_Therapy_ItemDeleted" 
                            OnItemUpdated="dvwCrf_Therapy_ItemUpdated" OnItemUpdating="dvwCrf_Therapy_ItemUpdating"
                            OnItemCreated="dvwCrf_Therapy_ItemCreated" 
                            ondatabound="dvwCrf_Therapy_DataBound" onload="dvwCrf_Therapy_Load">
                            <Fields>
                                <asp:TemplateField HeaderText="ИРК" SortExpression="center_number">
                                    <ItemTemplate>
                                        <asp:Label ID="lblCrf_NumberSelect" runat="server" Text='<%# Eval("crf_number") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="lblCrf_NumberEdit" runat="server" Text='<%# Eval("crf_number") %>'></asp:Label>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Торговое наименование" SortExpression="trade_ad_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTrade_AB" runat="server" Text='<%# Eval("trade_ad_description") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlTrade_AB" runat="server" DataSourceID="dsrcTrade_AB" DataTextField="DESCRIPTION"
                                            DataValueField="Trade_AB_ID" SelectedValue='<%# Bind("Trade_AB_ID") %>'>
                                        </asp:DropDownList>
                                        <asp:Label ID="lblTrade_AB_Other" runat="server" Text="доп."></asp:Label>
                                        <asp:TextBox ID="tboxTrade_AB_Other" runat="server" Text='<%# Bind("Trade_AB_Other") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
<%--                                <asp:TemplateField HeaderText="Торговое наименование (доп.)" SortExpression="trade_ab_other">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTrade_AB_Other" runat="server" Text='<%# Eval("Trade_AB_Other") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxTrade_AB_Other" runat="server" Text='<%# Bind("Trade_AB_Other") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
--%>                                <asp:TemplateField HeaderText="Разовая доза" SortExpression="single_dose">
                                    <ItemTemplate>
                                        <asp:Label ID="lblSingle_Dose" runat="server" 
                                            Text='<%# Eval("single_dose", "{0:F}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxSingle_Dose" runat="server" 
                                            Text='<%# Bind("single_dose", "{0:F}") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvSingle_Dose" runat="server" ControlToValidate="tboxSingle_Dose"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" setfocusonerror="false"></asp:RequiredFieldValidator>
                                        <asp:CompareValidator ID="cvSingle_Dose" runat="server" ControlToValidate="tboxSingle_Dose"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="Разовая доза должна быть числом"
                                            setfocusonerror="false" Type="Double" Operator="DataTypeCheck">
                                        </asp:CompareValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Ед. изм." SortExpression="measure_item_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMeasure_Item" runat="server" Text='<%# Eval("Measure_Item_Description") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlMeasure_Item" runat="server" DataSourceID="dsrcMeasure_Item" DataTextField="DESCRIPTION"
                                            DataValueField="Measure_Item_ID" SelectedValue='<%# Bind("Measure_Item_ID") %>'>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Кратность" SortExpression="frequency_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFrequency" runat="server" Text='<%# Eval("Frequency_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlFrequency" runat="server" DataSourceID="dsrcFrequency" DataTextField="DESCRIPTION"
                                            DataValueField="Frequency_ID" SelectedValue='<%# Bind("Frequency_ID") %>'>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Путь введения" SortExpression="admin_route_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAdmin_Route" runat="server" Text='<%# Eval("Admin_Route_Description") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlAdmin_Route" runat="server" DataSourceID="dsrcAdmin_Route" DataTextField="DESCRIPTION"
                                            DataValueField="Admin_Route_ID" SelectedValue='<%# Bind("Admin_Route_ID") %>'>
                                        </asp:DropDownList>
                                        <asp:Label ID="lblAdmin_Route_Other" runat="server" Text="другой"></asp:Label>
                                        <asp:TextBox ID="tboxAdmin_Route_Other" runat="server" Text='<%# Bind("Admin_Route_Other") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
<%--                                <asp:TemplateField HeaderText="Путь введения (другой)" SortExpression="admin_route_other">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAdmin_Route_Other" runat="server" Text='<%# Eval("Admin_Route_Other") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxAdmin_Route_Other" runat="server" Text='<%# Bind("Admin_Route_Other") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>
--%>                                <asp:TemplateField HeaderText="Дата и время назначения" SortExpression="prescription_date_time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPrescription_Date_Time" runat="server" Text='<%# Eval("Prescription_Date_Time", "{0:dd.MM.yyyy HH:mm}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxPrescription_Date_Time" runat="server" Text='<%# Bind("Prescription_Date_Time", "{0:dd.MM.yyyy HH:mm}") %>'></asp:TextBox>
                                        <asp:CustomValidator ID="cvPrescription_Date_TimeMin" runat="server" ErrorMessage="Дата назначения не должна быть меньше даты рождения"
                                            controltovalidate="tboxPrescription_Date_Time" OnServerValidate="fnValidateBirthDate" Display="Dynamic">
                                        </asp:CustomValidator>
                                        <asp:CustomValidator ID="cvPrescription_Date_TimeMax" runat="server" ErrorMessage="Дата назначения не должна превышать текущую дату"
                                            controltovalidate="tboxPrescription_Date_Time" ClientValidationFunction="fnValidateMaxNow" Display="Dynamic">
                                        </asp:CustomValidator>
                                        <cc1:MaskedEditExtender ID="meePrescription_Date_Time" runat="server" TargetControlID="tboxPrescription_Date_Time"
                                            Mask="99/99/9999 99:99" 
                                            CultureName="ru-RU"
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true" 
                                            ClearTextOnInvalid="false"
                                            MaskType="DateTime" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" ID="mevPrescription_Date_Time" runat="server"
                                            ControlToValidate="tboxPrescription_Date_Time" ControlExtender="meePrescription_Date_Time"
                                            Display="Dynamic" TooltipMessage="(дд.мм.гггг чч:мм)"  
                                            IsValidEmpty="false" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата назначения вводится в формате (дд.мм.гггг чч:мм)" 
                                            MaximumValueMessage="Дата назначения не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата назначения не должна быть меньше даты госпитализации" />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Дата и время отмены" SortExpression="abolition_date_time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAbolition_Date_Time" runat="server" Text='<%# Eval("Abolition_Date_Time", "{0:dd.MM.yyyy HH:mm}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxAbolition_Date_Time" runat="server" Text='<%# Bind("Abolition_Date_Time", "{0:dd.MM.yyyy HH:mm}") %>'></asp:TextBox>
                                        <asp:CustomValidator ID="cvAbolition_Date_TimeMin" runat="server" ErrorMessage="Дата назначения не должна быть меньше даты рождения"
                                            controltovalidate="tboxAbolition_Date_Time" OnServerValidate="fnValidateBirthDate" Display="Dynamic">
                                        </asp:CustomValidator>
                                        <asp:CustomValidator ID="cvAbolition_Date_TimeMax" runat="server" ErrorMessage="Дата назначения не должна превышать текущую дату"
                                            controltovalidate="tboxAbolition_Date_Time" ClientValidationFunction="fnValidateMaxNow" Display="Dynamic">
                                        </asp:CustomValidator>
                                        <cc1:MaskedEditExtender ID="meeAbolition_Date_Time" runat="server" TargetControlID="tboxAbolition_Date_Time"
                                            Mask="99/99/9999 99:99" 
                                            CultureName="ru-RU"
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true" 
                                            ClearTextOnInvalid="false"
                                            MaskType="DateTime" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" ID="mevAbolition_Date_Time" runat="server"
                                            ControlToValidate="tboxAbolition_Date_Time" ControlExtender="meeAbolition_Date_Time"
                                            Display="Dynamic" TooltipMessage="(дд.мм.гггг чч.мм)"  
                                            IsValidEmpty="true"
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата отмены вводится в формате (дд.мм.гггг чч.мм)" 
                                            MaximumValueMessage="Дата отмены не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата отмены не должна быть меньше даты госпитализации"/>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Цель назначения" SortExpression="therapy_reason_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTherapy_Reason" runat="server" Text='<%# Eval("Therapy_Reason_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlTherapy_Reason" DataSourceID="dsrcTherapy_Reason" DataTextField="description" DataValueField="therapy_reason_id" runat="server" SelectedValue='<%# Bind("Therapy_Reason_ID") %>'>
                                        </asp:DropDownList>
                                        <cc1:CascadingDropDown ID="cddTherapy_Reason" runat="server" Category="Therapy_Reason" 
                                            LoadingText="Загрузка..." PromptText="[Цель назначения]" 
                                            ServiceMethod="GetDropDownTherapy" ServicePath="~/GetABWard.asmx" 
                                            TargetControlID="ddlTherapy_Reason" SelectedValue="1" UseContextKey="false">
                                        </cc1:CascadingDropDown>
                                        <asp:RequiredFieldValidator ID="rfvTherapy_Reason" runat="server" ControlToValidate="ddlTherapy_Reason"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Цель (повод для назначения)" SortExpression="diagnosis_text">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDiagnosis_Text" runat="server" Text='<%# Eval("Diagnosis_Text") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlCrf_Diagnosis" runat="server" DataSourceID="dsrcCrf_Diagnosis" DataValueField="crf_diagnosis_id" DataTextField="diagnosis_text" SelectedValue='<%# Bind("Crf_Diagnosis_ID") %>'>
                                            <%--<asp:ListItem Value="" Text="Нет данных"></asp:ListItem>--%>
                                        </asp:DropDownList>
                                        <cc1:CascadingDropDown ID="cddCrf_Diagnosis" runat="server" Category="Crf_Diagnosis" 
                                            LoadingText="Загрузка..." ParentControlID="ddlTherapy_Reason" 
                                            PromptText="[Цель (повод для назначения)]" ServiceMethod="GetDropDownTherapy"
                                            ServicePath="~/GetABWard.asmx" TargetControlID="ddlCrf_Diagnosis">
                                        </cc1:CascadingDropDown>
                                        <asp:RequiredFieldValidator ID="rfvCrf_Diagnosis" runat="server" ControlToValidate="ddlCrf_Diagnosis"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>

                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Вид АМТ" SortExpression="therapy_type_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTherapy_Type" runat="server" Text='<%# Eval("Therapy_Type_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlTherapy_Type" runat="server" DataSourceID="dsrcTherapy_Type" DataTextField="description" DataValueField="therapy_type_id" SelectedValue='<%# Bind("Therapy_Type_ID") %>'>
                                        </asp:DropDownList>
                                        <cc1:CascadingDropDown ID="cddTherapy_Type" runat="server" Category="Therapy_Type" 
                                            LoadingText="Загрузка..." ParentControlID="ddlTherapy_Reason" 
                                            PromptText="[Вид АМТ]" ServiceMethod="GetDropDownTherapy"
                                            ServicePath="~/GetABWard.asmx" TargetControlID="ddlTherapy_Type">
                                        </cc1:CascadingDropDown>
                                        <asp:RequiredFieldValidator ID="rfvTherapy_Type" runat="server" ControlToValidate="ddlTherapy_Type"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:BoundField DataField="suser" HeaderText="Пользователь" ReadOnly="True" SortExpression="suser" />
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                            OnClick="btnEditCrf_Therapy_Click" />
                                        <asp:ImageButton ID="btnDelete" runat="server" CausesValidation="False" ImageUrl="~/images/16_L_remove.gif"
                                            ToolTip="Удалить" Text="Удалить" OnClientClick="javascript:return confirm('Вы действительно хотите удалит эту запись?');"
                                            OnClick="btnDeleteCrf_Therapy_Click" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSaveCrf_Therapy_Click" />
                                        <asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                            ImageUrl="~/images/clear.GIF" ToolTip="Отмена" Text="Отмена" OnClick="btnCancelCrf_Therapy_Click" />
                                    </EditItemTemplate>
                                    <ControlStyle CssClass="controls" />
                                </asp:TemplateField>
                            </Fields>
                        </asp:DetailsView>
                        <asp:Label ID="lblError_Crf_Therapy" runat="server" Text="" SkinID="ErrorLabel"></asp:Label>
                    </asp:Panel>
                    
                </ContentTemplate>
                <Triggers>
                    <asp:AsyncPostBackTrigger ControlID="btnAddCrf" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnFindCrf" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="btnRefreshCrf" EventName="Click" />
                    <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="PageIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="SelectedIndexChanged" />
                    <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemCommand" />
                    <%--<asp:AsyncPostBackTrigger ControlID="TabContainer1" EventName="ActiveTabChanged" />--%>
                </Triggers>
            </asp:UpdatePanel>

            
            </ContentTemplate>
        

        </cc1:TabPanel>





        
        <cc1:TabPanel runat="server" HeaderText="Микробиологич. исследования " ID="TabPanel8">
            <ContentTemplate>
                <asp:UpdatePanel ID="UpdatePanel10" runat="server" UpdateMode="Conditional">
                    <ContentTemplate>

            <asp:SqlDataSource ID="dsrcCrf_Microbiology" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Crf_Microbiology WHERE (Crf_Microbiology_ID = @Crf_Microbiology_ID)"
                InsertCommand="INSERT INTO Crf_Microbiology(Crf_ID,SUSER) VALUES(@Crf_ID,@SUSER)"
                SelectCommand="SELECT Crf_Microbiology_ID,crf_number,material_receiving_date,Clinical_Material_Group_ID,Clinical_Material_id,Clinical_Material_description,Clinical_Material_Other,laboratory_number,is_no_growth,is_no_growth_description,SUSER FROM VW_INTERFACE_CRF_MICROBIOLOGY WHERE ((Crf_ID = @Crf_ID))"
                UpdateCommand="UPDATE Crf_Microbiology SET material_receiving_date=@material_receiving_date,Clinical_Material_id=@Clinical_Material_id,Clinical_Material_Other=@Clinical_Material_Other,laboratory_number=@laboratory_number,is_no_growth=@is_no_growth,SUSER=@SUSER WHERE (Crf_Microbiology_ID = @Crf_Microbiology_ID)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Crf_Microbiology_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="material_receiving_date" Type="DateTime" />
                    <asp:Parameter Name="Clinical_Material_id" Type="Int32" />
                    <asp:Parameter Name="Clinical_Material_Other" Type="String" />
                    <asp:Parameter Name="laboratory_number" Type="String" />
                    <asp:Parameter Name="is_no_growth" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                    <asp:Parameter Name="Crf_Microbiology_ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcCrf_Microbiology_Microbe" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Crf_Microbiology_Microbe WHERE (Crf_Microbiology_Microbe_ID = @Crf_Microbiology_Microbe_ID)"
                InsertCommand="INSERT INTO Crf_Microbiology_Microbe(Crf_Microbiology_ID,SUSER) VALUES(@Crf_Microbiology_ID,@SUSER)"
                SelectCommand="SELECT Crf_Microbiology_Microbe.Crf_Microbiology_Microbe_ID,Crf_Microbiology.laboratory_number, Crf_Microbiology_Microbe.Microbe_id, Microbe.description as Microbe_description, Crf_Microbiology_Microbe.microbe_other, Crf_Microbiology_Microbe.SUSER FROM Crf_Microbiology_Microbe inner join Crf_Microbiology on Crf_Microbiology_Microbe.Crf_Microbiology_id=Crf_Microbiology.Crf_Microbiology_id inner join Microbe on Crf_Microbiology_Microbe.Microbe_id=Microbe.Microbe_id WHERE ((Crf_Microbiology_Microbe.Crf_Microbiology_ID = @Crf_Microbiology_ID))"
                UpdateCommand="UPDATE Crf_Microbiology_Microbe SET Microbe_id=@Microbe_id,microbe_other=@microbe_other,SUSER=@SUSER WHERE (Crf_Microbiology_Microbe_ID = @Crf_Microbiology_Microbe_ID)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvwCrf_Microbiology" Name="Crf_Microbiology_ID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Crf_Microbiology_Microbe_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Microbe_id" Type="Int32" />
                    <asp:Parameter Name="microbe_other" Type="String" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                    <asp:Parameter Name="Crf_Microbiology_Microbe_ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="gvwCrf_Microbiology" Name="Crf_Microbiology_ID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>

                        <div style="text-align: left; vertical-align: middle">
                        <asp:GridView ID="gvwCrf_Microbiology" runat="server" AllowPaging="True" SelectedIndex="0"
                            AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" CssClass="controls"
                            DataKeyNames="Crf_Microbiology_ID" DataSourceID="dsrcCrf_Microbiology" ForeColor="#333333"
                            GridLines="None" PageSize="15" OnRowEditing="gvwCrf_Microbiology_RowEditing"
                            OnRowCancelingEdit="gvwCrf_Microbiology_RowCancelingEdit" OnRowUpdated="gvwCrf_Microbiology_RowUpdated"
                            OnRowCreated="gvwCrf_Microbiology_RowCreated" OnPageIndexChanging="gvwCrf_Microbiology_PageIndexChanging"
                            EnableModelValidation="True" OnRowUpdating="gvwCrf_Microbiology_RowUpdating">
                            <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                            <RowStyle BackColor="#EFF3FB" />
                            <Columns>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select"
                                            ImageUrl="~/images/16_publish.gif" ToolTip="Выбрать" Text="Выбрать" />
                                        <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                            ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                            OnClick="btnEditCrf_Microbiology_Click" />
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                            ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSaveCrf_Microbiology_Click" />&#160;<asp:ImageButton
                                                ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/images/clear.GIF"
                                                ToolTip="Отмена" Text="Отмена" OnClick="btnCancelCrf_Microbiology_Click" />
                                    </EditItemTemplate>
                                    <ControlStyle CssClass="controls" />
                                    <ItemStyle HorizontalAlign="Left" />
                                </asp:TemplateField>
                                <asp:BoundField DataField="crf_number" HeaderText="ИРК" ReadOnly="True" SortExpression="crf_number" />
                                <asp:TemplateField HeaderText="Дата получения" SortExpression="material_receiving_date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMaterial_Receiving_Date" runat="server" Text='<%# Eval("material_receiving_date","{0:dd.MM.yyyy}") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxMaterial_Receiving_Date" runat="server" Text='<%# Bind("Material_Receiving_Date","{0:dd.MM.yyyy}") %>'
                                            Width="100px"></asp:TextBox>
                                        <cc1:MaskedEditExtender 
                                            ID="meeMaterial_Receiving_Date" 
                                            runat="server" 
                                            TargetControlID="tboxMaterial_Receiving_Date"
                                            Mask="99/99/9999" 
                                            CultureName="ru-RU" 
                                            MessageValidatorTip="true" 
                                            ClearMaskOnLostFocus="true"
                                            ClearTextOnInvalid="false" 
                                            MaskType="Date" />
                                        <cc1:MaskedEditValidator SetFocusOnError="false" 
                                            ID="mevMaterial_Receiving_Date" 
                                            runat="server" 
                                            ControlToValidate="tboxMaterial_Receiving_Date"
                                            ControlExtender="meeMaterial_Receiving_Date" 
                                            Display="Dynamic" 
                                            TooltipMessage="(дд.мм.гггг)"
                                            IsValidEmpty="false" 
                                            EmptyValueMessage="*" 
                                            InvalidValueMessage="Дата получения вводится в формате (дд.мм.гггг)"
                                            MaximumValueMessage="Дата получения не должна превышать текущую дату" 
                                            MinimumValueMessage="Дата получения не должна быть меньше даты госпитализации"
                                            MinimumValue='<%# GetCrfDate("Hospitalization_Date_Time").ToString("dd.MM.yyyy")%>' 
                                            MaximumValue='<%# DateTime.Now.ToString("dd.MM.yyyy")%>' />
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Клинический материал" SortExpression="Clinical_Material_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblClinical_Material_Group" runat="server" Text='<%# Eval("Clinical_Material_DESCRIPTION") %>'></asp:Label>
                                    </ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text="Локализация"></asp:Label>
                                        <asp:DropDownList ID="ddlClinical_Material_Group" runat="server" DataSourceID="dsrcClinical_Material_Group"
                                            DataTextField="DESCRIPTION" DataValueField="Clinical_Material_Group_ID" SelectedValue='<%# Eval("Clinical_Material_Group_ID") %>'>
                                        </asp:DropDownList>
                                        <cc1:CascadingDropDown ID="cddClinical_Material_Group" runat="server" Category="Clinical_Material_Group" LoadingText="Загрузка..."
                                            PromptText="[Локализация инфекции]" ServiceMethod="GetDropDownClinicalMaterial" ServicePath="~/GetABWard.asmx"
                                            TargetControlID="ddlClinical_Material_Group" UseContextKey="True">
                                        </cc1:CascadingDropDown>
                                        <asp:RequiredFieldValidator ID="rfvClinical_Material_Group" runat="server" ControlToValidate="ddlClinical_Material_Group"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                        <asp:Label ID="Label2" runat="server" Text="Клинический материал"></asp:Label>
                                        <asp:DropDownList ID="ddlClinical_Material" runat="server" DataSourceID="dsrcClinical_Material"
                                            DataTextField="DESCRIPTION" DataValueField="Clinical_Material_ID" SelectedValue='<%# Bind("Clinical_Material_ID") %>'>
                                        </asp:DropDownList>
                                        <cc1:CascadingDropDown ID="cddClinical_Material" runat="server" Category="Clinical_Material" LoadingText="Загрузка..."
                                            PromptText="[Клинический материал]" ServiceMethod="GetDropDownClinicalMaterial" ServicePath="~/GetABWard.asmx"
                                            TargetControlID="ddlClinical_Material" ParentControlID="ddlClinical_Material_Group" UseContextKey="True">
                                        </cc1:CascadingDropDown>
                                        <asp:RequiredFieldValidator ID="rfvClinical_Material" runat="server" ControlToValidate="ddlClinical_Material"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Клинический материал (другой)" SortExpression="clinical_material_other">
                                    <ItemTemplate>
                                        <asp:Label ID="lblClinical_Material_Other" runat="server" Text='<%# Eval("Clinical_Material_Other") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxClinical_Material_Other" runat="server" Width="300px" Text='<%# Bind("Clinical_Material_Other") %>'></asp:TextBox>
                                    </EditItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Лабораторный номер" SortExpression="laboratory_number">
                                    <ItemTemplate>
                                        <asp:Label ID="lblLaboratory_Number" runat="server" Text='<%# Eval("Laboratory_Number") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:TextBox ID="tboxLaboratory_Number" runat="server" Text='<%# Bind("Laboratory_Number") %>'></asp:TextBox>
                                        <asp:RequiredFieldValidator ID="rfvLaboratory_Number" runat="server" ControlToValidate="tboxLaboratory_Number"
                                            CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="false"></asp:RequiredFieldValidator>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Выделен(ы) МО" SortExpression="is_no_growth_description">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIs_No_Growth" runat="server" Text='<%# Eval("is_no_growth_description") %>'></asp:Label></ItemTemplate>
                                    <EditItemTemplate>
                                        <asp:DropDownList ID="ddlIs_No_Growth" runat="server" DataSourceID="dsrcLogic"
                                            DataTextField="DESCRIPTION" DataValueField="Logic_ID" SelectedValue='<%# Bind("is_no_growth") %>'>
                                        </asp:DropDownList>
                                    </EditItemTemplate>
                                </asp:TemplateField>
                                <asp:TemplateField ShowHeader="False">
                                    <ItemTemplate>
                                        <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                            CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                            OnClick="btnDeleteCrf_Microbiology_Click" /></ItemTemplate>
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
                            <asp:Button ID="Button1" runat="server" Text="Добавить исследование"
                                OnClick="btnAddCrf_Microbiology_Click" />
                            <asp:Label ID="lblError_Microbiology" runat="server" Text="" SkinID="ErrorLabel"></asp:Label>
                        </div>





                        <cc1:TabContainer ID="tcMicrobe" runat="server">
                            <cc1:TabPanel ID="tpMicrobe" runat="server" HeaderText="Выделенные МО">
                                <ContentTemplate>

                                    <div style="text-align: left; vertical-align: middle">
                                    <asp:GridView ID="gvwCrf_Microbiology_Microbe" runat="server" AllowPaging="True"
                                        AllowSorting="True" AutoGenerateColumns="False" CellPadding="4" CssClass="controls"
                                        DataKeyNames="Crf_Microbiology_Microbe_ID" DataSourceID="dsrcCrf_Microbiology_Microbe" ForeColor="#333333"
                                        GridLines="None" PageSize="15" OnRowEditing="gvwCrf_Microbiology_Microbe_RowEditing"
                                        OnRowCancelingEdit="gvwCrf_Microbiology_Microbe_RowCancelingEdit" OnRowUpdated="gvwCrf_Microbiology_Microbe_RowUpdated"
                                        OnRowCreated="gvwCrf_Microbiology_Microbe_RowCreated" OnPageIndexChanging="gvwCrf_Microbiology_Microbe_PageIndexChanging"
                                        EnableModelValidation="True" OnRowUpdating="gvwCrf_Microbiology_Microbe_RowUpdating" SelectedIndex="0">
                                        <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                        <RowStyle BackColor="#EFF3FB" />
                                        <Columns>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                                        ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать"
                                                        OnClick="btnEditCrf_Microbiology_Microbe_Click" /></ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                                        ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" OnClick="btnSaveCrf_Microbiology_Microbe_Click" />
                                                    <asp:ImageButton
                                                        ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel" ImageUrl="~/images/clear.GIF"
                                                        ToolTip="Отмена" Text="Отмена" OnClick="btnCancelCrf_Microbiology_Microbe_Click" />
                                                </EditItemTemplate>
                                                <ControlStyle CssClass="controls" />
                                                <ItemStyle HorizontalAlign="Left" />
                                            </asp:TemplateField>
                                            <asp:BoundField DataField="laboratory_number" HeaderText="Лабораторный номер" ReadOnly="True" SortExpression="laboratory_number" />
                                            <asp:TemplateField HeaderText="Выделенный МО" SortExpression="Microbe_description">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMicrobe" runat="server" Text='<%# Eval("Microbe_DESCRIPTION") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:DropDownList ID="ddlMicrobe" runat="server" DataSourceID="dsrcMicrobe"
                                                        DataTextField="DESCRIPTION" DataValueField="Microbe_ID" SelectedValue='<%# Bind("Microbe_ID") %>'>
                                                    </asp:DropDownList>
                                                    <asp:RequiredFieldValidator ID="rfvMicrobe" runat="server" ControlToValidate="ddlMicrobe"
                                                        CssClass="controls" Display="Dynamic" ErrorMessage="*" setfocusonerror="false"></asp:RequiredFieldValidator>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Выделенный МО (другой)" SortExpression="microbe_other">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblMicrobe_Other" runat="server" Text='<%# Eval("Microbe_Other") %>'></asp:Label>
                                                </ItemTemplate>
                                                <EditItemTemplate>
                                                    <asp:TextBox ID="tboxMicrobe_Other" runat="server" Text='<%# Bind("Microbe_Other") %>'></asp:TextBox>
                                                </EditItemTemplate>
                                            </asp:TemplateField>
                                            <asp:TemplateField ShowHeader="False">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                                        CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                                        OnClick="btnDeleteCrf_Microbiology_Microbe_Click" /></ItemTemplate>
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
                                        <asp:Button ID="btnAddCrf_Microbiology_Microbe" runat="server" Text="Добавить микроорганизм"
                                            OnClick="btnAddCrf_Microbiology_Microbe_Click" />
                                        <asp:Label ID="lblError_Microbiology_Microbe" runat="server" Text="" SkinID="ErrorLabel"></asp:Label>
                                    </div>


                                </ContentTemplate>
                            </cc1:TabPanel>
                        </cc1:TabContainer>


                    </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger ControlID="btnAddCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnFindCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="btnRefreshCrf" EventName="Click" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="PageIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="gvwCrf" EventName="SelectedIndexChanged" />
                        <asp:AsyncPostBackTrigger ControlID="dvwCrf" EventName="ItemCommand" />
                        <%--<asp:AsyncPostBackTrigger ControlID="gvwCrf_Microbiology" EventName="SelectedIndexChanged" />--%>
                        <%--<asp:AsyncPostBackTrigger ControlID="TabContainer1" EventName="ActiveTabChanged" />--%>
                    </Triggers>
                </asp:UpdatePanel>
            
</ContentTemplate>
        

</cc1:TabPanel>










    </cc1:TabContainer>


            <asp:SqlDataSource ID="dsrcCrf" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                SelectCommand="SELECT crf_id, center_id, center_number, crf_number, case_history, fio, birth_date, sex_id, sex_description, hospitalization_date_time, release_death_date, therapy_result_id, therapy_result_description, death_reason_text, is_previous_hospitalisation, is_previous_hospitalisation_description, date_add, date_update, suser FROM VW_INTERFACE_CRF WHERE (center_id = @Center_ID) OR (IS_ADMIN = @IS_ADMIN)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:SessionParameter Name="Center_ID" SessionField="Center_ID" />
                    <asp:SessionParameter Name="IS_ADMIN" SessionField="is_admin" />
                </SelectParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsrcCrfDetails" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM Crf WHERE (Crf_ID = @Crf_ID)" InsertCommand="INSERT INTO Crf(center_id,SUSER) VALUES (@Center_ID,@SUSER)"
                SelectCommand="SELECT Crf_ID, center_id, center_number, crf_number, case_history, fio, birth_date, sex_id, sex_description, hospitalization_date_time, release_death_date, therapy_result_id, therapy_result_description, death_reason_text, is_previous_hospitalisation, is_previous_hospitalisation_description, date_add, date_update, suser FROM VW_INTERFACE_CRF WHERE crf_id=@crf_id"
                UpdateCommand="UPDATE Crf SET crf_number = @crf_number, case_history = @case_history, fio = @fio, birth_date = @birth_date, sex_id = @sex_id, hospitalization_date_time = @hospitalization_date_time, release_death_date = @release_death_date, therapy_result_id=@therapy_result_id, death_reason_text=@death_reason_text, is_previous_hospitalisation=@is_previous_hospitalisation, SUSER = @SUSER WHERE (Crf_ID = @Crf_ID)"
                ProviderName="System.Data.SqlClient">
                <DeleteParameters>
                    <asp:Parameter Name="Crf_ID" Type="Int32" />
                </DeleteParameters>
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="crf_id" PropertyName="SelectedValue"
                        Type="Int32" />
                </SelectParameters>
                <UpdateParameters>
                    <asp:Parameter Name="crf_number" Type="Int32" />
                    <asp:Parameter Name="case_history" Type="String" />
                    <asp:Parameter Name="fio" Type="String" />
                    <asp:Parameter Name="birth_date" Type="DateTime" />
                    <asp:Parameter Name="sex_id" Type="Int32" />
                    <asp:Parameter Name="hospitalization_date_time" Type="DateTime" />
                    <asp:Parameter Name="release_death_date" Type="DateTime" />
                    <asp:Parameter Name="therapy_result_id" Type="Int32" />
                    <asp:Parameter Name="death_reason_text" Type="String" />
                    <asp:Parameter Name="is_previous_hospitalisation" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue"
                        Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:SessionParameter Name="center_id" SessionField="Center_ID" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsrcCrf_Diagnosis_Main" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Crf_Diagnosis WHERE (Crf_Diagnosis_ID = @Crf_Diagnosis_ID)"
                InsertCommand="INSERT INTO Crf_Diagnosis(Crf_ID,diagnosis_type_id,SUSER) VALUES(@Crf_ID,2,@SUSER)"
                SelectCommand="SELECT Crf_Diagnosis.Crf_Diagnosis_ID,crf.crf_number,Crf_Diagnosis.diagnosis_text,Crf_Diagnosis.start_date, Crf_Diagnosis.SUSER FROM Crf_Diagnosis inner join crf on Crf_Diagnosis.crf_id=crf.crf_id WHERE ((Crf_Diagnosis.Crf_ID = @Crf_ID) AND (Crf_Diagnosis.diagnosis_type_id=2))"
                UpdateCommand="UPDATE Crf_Diagnosis SET diagnosis_text=@diagnosis_text,start_date=@start_date,SUSER=@SUSER WHERE (Crf_Diagnosis_ID = @Crf_Diagnosis_ID)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Crf_Diagnosis_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="diagnosis_text" Type="String" />
                    <asp:Parameter Name="start_date" Type="DateTime" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                    <asp:Parameter Name="Crf_Diagnosis_ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsrcCrf_Diagnosis_Nosocomial" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Crf_Diagnosis WHERE (Crf_Diagnosis_ID = @Crf_Diagnosis_ID)"
                InsertCommand="INSERT INTO Crf_Diagnosis(Crf_ID,diagnosis_type_id,SUSER) VALUES(@Crf_ID,3,@SUSER)"
                SelectCommand="SELECT Crf_Diagnosis.Crf_Diagnosis_ID,crf.crf_number,Crf_Diagnosis.Diagnosis_ID,Diagnosis.Description as diagnosis_description,Crf_Diagnosis.diagnosis_text,Crf_Diagnosis.clinical_material_group_id, clinical_material_group.description as clinical_material_group_description,Crf_Diagnosis.start_date, Crf_Diagnosis.end_date, Crf_Diagnosis.is_end_date_unknown, logic.description as is_end_date_unknown_description, Crf_Diagnosis.diagnosis_result_id, diagnosis_result.description as diagnosis_result_description,Crf_Diagnosis.SUSER FROM Crf_Diagnosis inner join crf on Crf_Diagnosis.crf_id=crf.crf_id inner join logic on crf_diagnosis.is_end_date_unknown=logic.logic_id inner join diagnosis_result on crf_diagnosis.diagnosis_result_id=diagnosis_result.diagnosis_result_id inner join clinical_material_group on crf_diagnosis.clinical_material_group_id=clinical_material_group.clinical_material_group_id inner join diagnosis on crf_diagnosis.diagnosis_id=diagnosis.diagnosis_id WHERE ((Crf_Diagnosis.Crf_ID = @Crf_ID) AND (Crf_Diagnosis.diagnosis_type_id=3))"
                UpdateCommand="UPDATE Crf_Diagnosis SET diagnosis_id=@diagnosis_id,diagnosis_text=@diagnosis_text,clinical_material_group_id=@clinical_material_group_id,start_date=@start_date,end_date=@end_date,is_end_date_unknown=@is_end_date_unknown,diagnosis_result_id=@diagnosis_result_id,SUSER=@SUSER WHERE (Crf_Diagnosis_ID = @Crf_Diagnosis_ID)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Crf_Diagnosis_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="diagnosis_id" Type="Int32" />
                    <asp:Parameter Name="diagnosis_text" Type="String" />
                    <asp:Parameter Name="clinical_material_group_id" Type="Int32" />
                    <asp:Parameter Name="start_date" Type="DateTime" />
                    <asp:Parameter Name="end_date" Type="DateTime" />
                    <asp:Parameter Name="is_end_date_unknown" Type="Int32" />
                    <asp:Parameter Name="diagnosis_result_id" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                    <asp:Parameter Name="Crf_Diagnosis_ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsrcCrf_Diagnosis_Operation" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Crf_Diagnosis WHERE (Crf_Diagnosis_ID = @Crf_Diagnosis_ID)"
                InsertCommand="INSERT INTO Crf_Diagnosis(Crf_ID,diagnosis_type_id,SUSER) VALUES(@Crf_ID,4,@SUSER)"
                SelectCommand="SELECT Crf_Diagnosis.Crf_Diagnosis_ID,crf.crf_number,Crf_Diagnosis.diagnosis_text,Crf_Diagnosis.start_date, Crf_Diagnosis.end_date, Crf_Diagnosis.SUSER FROM Crf_Diagnosis inner join crf on Crf_Diagnosis.crf_id=crf.crf_id WHERE ((Crf_Diagnosis.Crf_ID = @Crf_ID) AND (Crf_Diagnosis.diagnosis_type_id=4))"
                UpdateCommand="UPDATE Crf_Diagnosis SET diagnosis_text=@diagnosis_text,start_date=@start_date,end_date=@end_date,SUSER=@SUSER WHERE (Crf_Diagnosis_ID = @Crf_Diagnosis_ID)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Crf_Diagnosis_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="diagnosis_text" Type="String" />
                    <asp:Parameter Name="start_date" Type="DateTime" />
                    <asp:Parameter Name="end_date" Type="DateTime" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                    <asp:Parameter Name="Crf_Diagnosis_ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsrcCrf_Risk_Factor" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Crf_Risk_Factor WHERE (Crf_Risk_Factor_ID = @Crf_Risk_Factor_ID)"
                InsertCommand="INSERT INTO Crf_Risk_Factor(Crf_ID,SUSER) VALUES(@Crf_ID,@SUSER)"
                SelectCommand="SELECT Crf_Risk_Factor.Crf_Risk_Factor_ID,crf.crf_number, Crf_Risk_Factor.Risk_Factor_id, Risk_Factor.description as Risk_Factor_description, risk_factor_text, Crf_Risk_Factor.start_date, Crf_Risk_Factor.end_date, Crf_Risk_Factor.Is_Continue, logic.description as Is_Continue_description, Crf_Risk_Factor.SUSER FROM Crf_Risk_Factor inner join crf on Crf_Risk_Factor.crf_id=crf.crf_id inner join logic on Crf_Risk_Factor.Is_Continue=logic.logic_id inner join Risk_Factor on Crf_Risk_Factor.Risk_Factor_id=Risk_Factor.Risk_Factor_id WHERE ((Crf_Risk_Factor.Crf_ID = @Crf_ID))"
                UpdateCommand="UPDATE Crf_Risk_Factor SET Risk_Factor_id=@Risk_Factor_id,risk_factor_text=@risk_factor_text,start_date=@start_date,end_date=@end_date,Is_Continue=@Is_Continue,SUSER=@SUSER WHERE (Crf_Risk_Factor_ID = @Crf_Risk_Factor_ID)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Crf_Risk_Factor_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="Risk_Factor_id" Type="Int32" />
                    <asp:Parameter Name="risk_factor_text" Type="String" />
                    <asp:Parameter Name="start_date" Type="DateTime" />
                    <asp:Parameter Name="end_date" Type="DateTime" />
                    <asp:Parameter Name="Is_Continue" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    <asp:Parameter Name="Crf_Risk_Factor_ID"  Type="Int32"/>
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsrcCrf_Previous_Hospitalisation" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Crf_Previous_Hospitalisation WHERE (Crf_Previous_Hospitalisation_ID = @Crf_Previous_Hospitalisation_ID)"
                InsertCommand="INSERT INTO Crf_Previous_Hospitalisation(Crf_ID,SUSER) VALUES(@Crf_ID,@SUSER)"
                SelectCommand="SELECT Crf_Previous_Hospitalisation.Crf_Previous_Hospitalisation_ID,crf.crf_number, Crf_Previous_Hospitalisation.city_name, Crf_Previous_Hospitalisation.stationar_name, Crf_Previous_Hospitalisation.Hospitalisation_Date, Crf_Previous_Hospitalisation.Release_Date, Crf_Previous_Hospitalisation.SUSER FROM Crf_Previous_Hospitalisation inner join crf on Crf_Previous_Hospitalisation.crf_id=crf.crf_id WHERE ((Crf_Previous_Hospitalisation.Crf_ID = @Crf_ID))"
                UpdateCommand="UPDATE Crf_Previous_Hospitalisation SET city_name=@city_name,stationar_name=@stationar_name,Hospitalisation_Date=@Hospitalisation_Date,Release_Date=@Release_Date,SUSER=@SUSER WHERE (Crf_Previous_Hospitalisation_ID = @Crf_Previous_Hospitalisation_ID)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Crf_Previous_Hospitalisation_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="city_name" Type="String" />
                    <asp:Parameter Name="stationar_name" Type="String" />
                    <asp:Parameter Name="Hospitalisation_Date" Type="DateTime" />
                    <asp:Parameter Name="Release_Date" Type="DateTime" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                    <asp:Parameter Name="Crf_Previous_Hospitalisation_ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>

            <asp:SqlDataSource ID="dsrcCrf_Ward_Transfer" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Crf_Ward_Transfer WHERE (Crf_Ward_Transfer_ID = @Crf_Ward_Transfer_ID)"
                InsertCommand="INSERT INTO Crf_Ward_Transfer(Crf_ID,SUSER) VALUES(@Crf_ID,@SUSER)"
                SelectCommand="SELECT Crf_Ward_Transfer.Crf_Ward_Transfer_ID,crf.crf_number, Crf_Ward_Transfer.ward_name, Crf_Ward_Transfer.Ward_Type_id, Ward_Type.description as Ward_Type_description, Crf_Ward_Transfer.Entering_Date, Crf_Ward_Transfer.transfer_date, Crf_Ward_Transfer.SUSER FROM Crf_Ward_Transfer inner join crf on Crf_Ward_Transfer.crf_id=crf.crf_id inner join Ward_Type on Crf_Ward_Transfer.Ward_Type_id=Ward_Type.Ward_Type_id WHERE ((Crf_Ward_Transfer.Crf_ID = @Crf_ID))"
                UpdateCommand="UPDATE Crf_Ward_Transfer SET ward_name=@ward_name,Ward_Type_id=@Ward_Type_id,Entering_Date=@Entering_Date,transfer_date=@transfer_date,SUSER=@SUSER WHERE (Crf_Ward_Transfer_ID = @Crf_Ward_Transfer_ID)"
                ProviderName="System.Data.SqlClient">
                <SelectParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                </SelectParameters>
                <DeleteParameters>
                    <asp:Parameter Name="Crf_Ward_Transfer_ID" Type="Int32" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ward_name" Type="String" />
                    <asp:Parameter Name="Ward_Type_id" Type="String" />
                    <asp:Parameter Name="Entering_Date" Type="DateTime" />
                    <asp:Parameter Name="transfer_date" Type="DateTime" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                    <asp:Parameter Name="Crf_Ward_Transfer_ID" Type="Int32" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" Type="Int32" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" Type="String" />
                </InsertParameters>
            </asp:SqlDataSource>





    <asp:SqlDataSource ID="dsrcSex" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" SelectCommand="SELECT SEX_ID, DESCRIPTION FROM SEX ORDER BY DESCRIPTION"
        ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcTherapy_Result" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" SelectCommand="SELECT THERAPY_RESULT_ID,DESCRIPTION FROM THERAPY_RESULT ORDER BY DESCRIPTION"
        ProviderName="System.Data.SqlClient"></asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcDiagnosis_Result" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Diagnosis_Result_ID, DESCRIPTION FROM dbo.Diagnosis_Result ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcDiagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Diagnosis_ID, DESCRIPTION FROM dbo.Diagnosis ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcLogic" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Logic_ID, DESCRIPTION FROM dbo.Logic ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcRisk_Factor" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Risk_Factor_ID, DESCRIPTION FROM dbo.Risk_Factor ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcWard_Type" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Ward_Type_ID, DESCRIPTION FROM dbo.Ward_Type ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcTrade_AB" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Trade_AB_ID, DESCRIPTION FROM dbo.Trade_AB ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcMeasure_Item" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Measure_Item_ID, DESCRIPTION FROM dbo.Measure_Item ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcFrequency" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Frequency_ID, DESCRIPTION FROM dbo.Frequency ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcAdmin_Route" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Admin_Route_ID, DESCRIPTION FROM dbo.Admin_Route ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcTherapy_Reason" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Therapy_Reason_ID, DESCRIPTION FROM dbo.Therapy_Reason ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcTherapy_Type" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Therapy_Type_ID, DESCRIPTION FROM dbo.Therapy_Type ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcCrf_Diagnosis" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="(SELECT Crf_Diagnosis_ID, CASE diagnosis.description WHEN N'Другой' THEN N'' ELSE diagnosis.description END + ISNULL(CASE diagnosis.description WHEN N'Другой' THEN N'' ELSE N' ' END + crf_diagnosis.diagnosis_text, N'') as diagnosis_text FROM dbo.Crf_Diagnosis inner join diagnosis on Crf_Diagnosis.diagnosis_id=diagnosis.diagnosis_id WHERE crf_id=@crf_id) union (select null,'Нет данных') ORDER BY Crf_Diagnosis_ID">
        <SelectParameters>
            <asp:ControlParameter ControlID="gvwCrf" Name="Crf_ID" PropertyName="SelectedValue" />
        </SelectParameters>
    </asp:SqlDataSource>

    <asp:SqlDataSource ID="dsrcMicrobe" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Microbe_ID, DESCRIPTION FROM dbo.Microbe ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcClinical_Material" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Clinical_Material_ID, DESCRIPTION FROM dbo.Clinical_Material ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
    <asp:SqlDataSource ID="dsrcClinical_Material_Group" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
        EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT Clinical_Material_Group_ID, DESCRIPTION FROM dbo.Clinical_Material_Group ORDER BY DESCRIPTION">
    </asp:SqlDataSource>
</asp:Content>
