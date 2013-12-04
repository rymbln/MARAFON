<%@ Page Title="Формы выпуска" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="MedicalForm.aspx.cs" Inherits="Marafon.MedicalForm" Theme="Marafon" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlFindDictionary" runat="server" Style="display: none; text-align: right;
                vertical-align: middle" CssClass="modalPopup">
                <asp:Panel ID="pnlFindHeader" runat="server" Style="cursor: move; background-color: #DDDDDD;
                    border: solid 1px Gray; color: Black; text-align: center;">
                    <div>
                        <p>
                            Поиск</p>
                    </div>
                </asp:Panel>
                <br />
                <asp:Label ID="lblFind" runat="server" Text="Название или его часть: "></asp:Label>
                <asp:TextBox ID="tboxFindDictionary" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btnFindDictionary" runat="server" Text="Найти"  />
                <asp:Button ID="btnCancelFindDictionary" runat="server" Text="Отменить поиск" />
            </asp:Panel>
            <asp:SqlDataSource ID="dsrcAdminRoute" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                EnableViewState="False" ProviderName="System.Data.SqlClient" SelectCommand="SELECT ADMIN_ROUTE_ID, DESCRIPTION FROM dbo.ADMIN_ROUTE ORDER BY DESCRIPTION">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcDictionary" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Medical_Form WHERE (Medical_Form_ID = @Medical_Form_ID)"
                InsertCommand="INSERT INTO Medical_Form (SUSER) VALUES(@SUSER)" 
                SelectCommand="SELECT dbo.MEDICAL_FORM.MEDICAL_FORM_ID, dbo.MEDICAL_FORM.ADMIN_ROUTE_ID, dbo.admin_route.description AS ADMIN_ROUTE_DESCRIPTION, dbo.MEDICAL_FORM.DESCRIPTION, dbo.MEDICAL_FORM.suser FROM dbo.MEDICAL_FORM INNER JOIN dbo.admin_route ON dbo.MEDICAL_FORM.ADMIN_ROUTE_ID = dbo.admin_route.admin_route_id"
                UpdateCommand="UPDATE Medical_Form SET ADMIN_ROUTE_ID = @ADMIN_ROUTE_ID, DESCRIPTION = @DESCRIPTION, SUSER = @SUSER WHERE Medical_Form_ID=@Medical_Form_ID"
                ProviderName="System.Data.SqlClient">
                <DeleteParameters>
                    <asp:Parameter Name="Medical_Form_ID" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="ADMIN_ROUTE_ID" />
                    <asp:Parameter Name="DESCRIPTION" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    <asp:Parameter Name="Medical_Form_ID" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gvwDictionary" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Medical_Form_ID"
                DataSourceID="dsrcDictionary" ForeColor="#333333" GridLines="None" PageSize="15"
                SelectedIndex="0" OnRowEditing="gvwDictionary_RowEditing" OnRowCancelingEdit="gvwDictionary_RowCancelingEdit"
                OnRowCommand="gvwDictionary_RowCommand" OnRowUpdated="gvwDictionary_RowUpdated"
                Caption="Формы выпуска"
                onrowcreated="gvwDictionary_RowCreated" 
                onpageindexchanging="gvwDictionary_PageIndexChanging">
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" />
                            &nbsp;
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" />
                            &nbsp;<asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                ImageUrl="~/images/clear.GIF" ToolTip="Отмена" />
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
                    <asp:TemplateField HeaderText="Название" SortExpression="DESCRIPTION">
                        <ItemTemplate>
                            <asp:Label ID="lblDescription" runat="server" Text='<%# Bind("DESCRIPTION") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:TextBox ID="tboxDescription" runat="server" Text='<%# Bind("DESCRIPTION") %>' Width="500px"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rvDescription" runat="server" ControlToValidate="tboxDescription"
                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
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
                <PagerStyle BackColor="#2461BF" ForeColor="White" HorizontalAlign="center" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
                <HeaderStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <EditRowStyle BackColor="#2461BF" />
                <AlternatingRowStyle BackColor="White" />
            </asp:GridView>
            <div style="text-align: left; vertical-align: middle">
                <asp:Button ID="btnAddDictionary" runat="server" Text="Добавить запись" OnClick="btnAddDictionary_Click" />
                <asp:Button ID="btnRefreshDictionary" runat="server" Text="Обновить данные" OnClick="btnRefreshDictionary_Click" />
                <asp:Button ID="btnFindPopup" runat="server" Text="Поиск" />
            </div>
            <cc1:ModalPopupExtender ID="mpeFind" runat="server" TargetControlID="btnFindPopup"
                PopupControlID="pnlFindDictionary" BackgroundCssClass="modalBackground" CancelControlID="btnCancelFindDictionary"
                DropShadow="true" PopupDragHandleControlID="pnlFindHeader">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnAddDictionary" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnFindDictionary" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnRefreshDictionary" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="gvwDictionary" EventName="DataBound" />
            <asp:AsyncPostBackTrigger ControlID="gvwDictionary" EventName="RowCommand" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
