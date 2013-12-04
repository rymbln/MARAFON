<%@ Page Title="Группы КМ и КМ" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="ClinicalMaterialGroup.aspx.cs" Inherits="Marafon.ClinicalMaterialGroup" Theme="Marafon" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlFindClinical_Material_Group" runat="server" Style="display: none; text-align: right;
                vertical-align: middle" CssClass="modalPopup">
                <asp:Panel ID="pnlFindHeader" runat="server" Style="cursor: move; background-color: #DDDDDD;
                    border: solid 1px Gray; color: Black; text-align: center;">
                    <div>
                        <p>
                            Поиск</p>
                    </div>
                </asp:Panel>
                <br />
                <asp:Label ID="lblFindClinical_Material_Group" runat="server" Text="Название или его часть: "></asp:Label>
                <asp:TextBox ID="tboxFindClinical_Material_Group" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btnFindClinical_Material_Group" runat="server" Text="Найти" OnClick="btnFindClinicalMaterialGroup_Click" />
                <asp:Button ID="btnCancelFindClinical_Material_Group" runat="server" Text="Отменить поиск" />
            </asp:Panel>
            <asp:SqlDataSource ID="dsrcClinical_Material_Group" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.Clinical_Material_Group WHERE (Clinical_Material_Group_ID = @Clinical_Material_Group_ID)" 
                InsertCommand="INSERT INTO Clinical_Material_Group (SUSER) VALUES(@SUSER)"
                SelectCommand="SELECT Clinical_Material_Group_ID, DESCRIPTION, SUSER FROM Clinical_Material_Group"
                UpdateCommand="UPDATE Clinical_Material_Group SET DESCRIPTION = @DESCRIPTION, SUSER = @SUSER WHERE Clinical_Material_Group_ID=@Clinical_Material_Group_ID"
                ProviderName="System.Data.SqlClient">
                <DeleteParameters>
                    <asp:Parameter Name="Clinical_Material_Group_ID" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="DESCRIPTION" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    <asp:Parameter Name="Clinical_Material_Group_ID" />
                </UpdateParameters>
                <InsertParameters>
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gvwClinical_Material_Group" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Clinical_Material_Group_ID"
                DataSourceID="dsrcClinical_Material_Group" ForeColor="#333333" 
                GridLines="None" PageSize="15"
                SelectedIndex="0" OnRowEditing="gvwClinical_Material_Group_RowEditing" OnRowCancelingEdit="gvwClinical_Material_Group_RowCancelingEdit"
                OnRowUpdated="gvwClinical_Material_Group_RowUpdated" 
                Caption="Группы клинических материалов"
                OnPageIndexChanging="gvwClinical_Material_Group_PageIndexChanging" 
                onrowcreated="gvwClinical_Material_Group_RowCreated" 
                ondatabound="gvwClinical_Material_Group_DataBound">

                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnSelect" runat="server" CausesValidation="False" CommandName="Select"
                                ImageUrl="~/images/16_publish.gif" ToolTip="Выбрать" Text="Выбрать" />
                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать" 
                                onclick="btnEdit_Click" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" 
                                onclick="btnSave_Click" />
                            &nbsp;<asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                ImageUrl="~/images/clear.GIF" ToolTip="Отмена" Text="Отмена" onclick="btnCancel_Click" />
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
                <asp:Button ID="btnAddClinical_Material_Group" runat="server" Text="Добавить запись" OnClick="btnAddClinical_Material_Group_Click" />
                <asp:Button ID="btnRefreshClinical_Material_Group" runat="server" Text="Обновить данные" OnClick="btnRefreshClinical_Material_Group_Click" />
                <asp:Button ID="btnFindPopup" runat="server" Text="Поиск" />
            </div>
            <cc1:ModalPopupExtender ID="mpeFindClinical_Material_Group" runat="server" TargetControlID="btnFindPopup"
                PopupControlID="pnlFindClinical_Material_Group" BackgroundCssClass="modalBackground" CancelControlID="btnCancelFindClinical_Material_Group"
                DropShadow="true" PopupDragHandleControlID="pnlFindHeader">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnAddClinical_Material_Group" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnFindClinical_Material_Group" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnRefreshClinical_Material_Group" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="gvwClinical_Material_Group" EventName="DataBound" />
            <asp:AsyncPostBackTrigger ControlID="gvwClinical_Material_Group" EventName="RowCommand" />
        </Triggers>
    </asp:UpdatePanel>
    <br />
    <div style="text-align: left; vertical-align: middle;">
        <cc1:TabContainer ID="TabContainer1" runat="server" ActiveTabIndex="0">
            <cc1:TabPanel runat="server" HeaderText="Клинические материалы" ID="TabPanel1">
                <ContentTemplate>
                    <asp:UpdatePanel ID="UpdatePanel2" runat="server" UpdateMode="Conditional">
                        <ContentTemplate>
                            <asp:SqlDataSource ID="dsrcClinical_Material" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                                DeleteCommand="DELETE FROM dbo.Clinical_Material WHERE (Clinical_Material_ID = @Clinical_Material_ID)" InsertCommand="INSERT INTO Clinical_Material(Clinical_Material_Group_ID,SUSER) VALUES(@Clinical_Material_Group_ID,@SUSER)"
                                SelectCommand="SELECT Clinical_Material.Clinical_Material_ID,Clinical_Material.DESCRIPTION, Clinical_Material.SUSER FROM Clinical_Material WHERE (Clinical_Material.Clinical_Material_Group_ID = @Clinical_Material_Group_ID)"
                                UpdateCommand="UPDATE Clinical_Material SET Clinical_Material_Group_ID=@Clinical_Material_Group_ID, DESCRIPTION = @DESCRIPTION, SUSER = @SUSER WHERE (Clinical_Material_ID = @Clinical_Material_ID)"
                                ProviderName="System.Data.SqlClient">
                                <SelectParameters>
                                    <asp:ControlParameter ControlID="gvwClinical_Material_Group" Name="Clinical_Material_Group_ID" PropertyName="SelectedValue" />
                                </SelectParameters>
                                <DeleteParameters>
                                    <asp:Parameter Name="Clinical_Material_ID" />
                                </DeleteParameters>
                                <UpdateParameters>
                                    <asp:ControlParameter ControlID="gvwClinical_Material_Group" Name="Clinical_Material_Group_ID" PropertyName="SelectedValue" />
                                    <asp:Parameter Name="DESCRIPTION" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                    <asp:Parameter Name="Clinical_Material_ID" />
                                </UpdateParameters>
                                <InsertParameters>
                                    <asp:ControlParameter ControlID="gvwClinical_Material_Group" Name="Clinical_Material_Group_ID" PropertyName="SelectedValue" />
                                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                                </InsertParameters>
                            </asp:SqlDataSource>
                            <asp:GridView ID="gvwClinical_Material" runat="server" AllowPaging="True" AllowSorting="True"
                                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="Clinical_Material_ID"
                                DataSourceID="dsrcClinical_Material" ForeColor="#333333" GridLines="None" PageSize="15" SelectedIndex="0"
                                OnRowEditing="gvwClinical_Material_RowEditing" OnRowCancelingEdit="gvwClinical_Material_RowCancelingEdit"
                                OnRowUpdated="gvwClinical_Material_RowUpdated"
                                onrowcreated="gvwClinical_Material_RowCreated" 
                                onpageindexchanging="gvwClinical_Material_PageIndexChanging">

                                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                                <RowStyle BackColor="#EFF3FB" />
                                <Columns>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="~/images/ico_16_4207.gif" ToolTip="Редактировать" Text="Редактировать" 
                                onclick="btnEdit_Click" />
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                ImageUrl="~/images/16_L_save.gif" ToolTip="Сохранить" Text="Сохранить" 
                                onclick="btnSave_Click" />
                            &nbsp;<asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                ImageUrl="~/images/clear.GIF" ToolTip="Отмена" Text="Отмена" onclick="btnCancel_Click" />
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
                                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                                        </EditItemTemplate>
                                    </asp:TemplateField>
                                    <asp:TemplateField ShowHeader="False">
                                        <ItemTemplate>
                                            <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                                CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" ToolTip="Удалить" OnClientClick="javascript:return confirm('Удалить данные?');"
                                                OnClick="btnDeleteClinical_Material_Click" />
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
                                <asp:Button ID="btnAddClinical_Material" runat="server" Text="Добавить запись" OnClick="btnAddClinical_Material_Click" />
                            </div>
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="btnAddClinical_Material_Group" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnFindClinical_Material_Group" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="btnRefreshClinical_Material_Group" EventName="Click" />
                            <asp:AsyncPostBackTrigger ControlID="gvwClinical_Material_Group" EventName="RowCancelingEdit" />
                            <asp:AsyncPostBackTrigger ControlID="gvwClinical_Material_Group" EventName="RowEditing" />
                            <asp:AsyncPostBackTrigger ControlID="gvwClinical_Material_Group" EventName="RowUpdated" />
                            <asp:AsyncPostBackTrigger ControlID="gvwClinical_Material_Group" EventName="RowCommand" />
                        </Triggers>
                    </asp:UpdatePanel>
                </ContentTemplate>
            </cc1:TabPanel>
        </cc1:TabContainer>
    </div>
</asp:Content>
