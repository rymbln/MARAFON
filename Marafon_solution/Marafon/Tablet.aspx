<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true" CodeBehind="Tablet.aspx.cs" Inherits="Marafon.Tablet" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlFindPack_Store" runat="server" Style="display: none; text-align: right;
                vertical-align: middle" CssClass="modalPopup">
                <asp:Panel ID="pnlFindHeader" runat="server" Style="cursor: move; background-color: #DDDDDD;
                    border: solid 1px Gray; color: Black; text-align: center;">
                    <div>
                        <p>
                            Поиск</p>
                    </div>
                </asp:Panel>
                <br />
                <asp:Label ID="lblFind" runat="server" Text="Номер "></asp:Label>
                <asp:TextBox ID="tboxFindPack_Store" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btnFindPack_Store" runat="server" Text="Найти" OnClick="btnFindPack_Store_Click" />
                <asp:Button ID="btnCancelFindPack_Store" runat="server" Text="Отменить поиск" />
            </asp:Panel>
            <asp:SqlDataSource ID="dsrcWard" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                EnableViewState="False" ProviderName="System.Data.SqlClient" 
                SelectCommand="SELECT WARD_ID, WARD_DESCRIPTION FROM VW_INTERFACE_WARD_DESCRIPTION WHERE (SUSER=@SUSER) OR (@IS_ADMIN=1) GROUP BY WARD_ID, WARD_DESCRIPTION ORDER BY WARD_DESCRIPTION">
                <SelectParameters>
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    <asp:SessionParameter Name="IS_ADMIN" SessionField="is_admin" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="dsrcPack_Store" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="DELETE FROM dbo.pack_store WHERE (pack_store_ID = @pack_store_ID)"
                SelectCommand="SELECT PS.PACK_STORE_ID, PS.WARD_ID, W.DESCRIPTION AS WARD_DESCRIPTION FROM PACK_STORE PS INNER JOIN WARD W ON PS.WARD_ID=W.WARD_ID"
                UpdateCommand="UPDATE PACK_STORE SET WARD_ID = @WARD_ID, SUSER=@SUSER WHERE (PACK_STORE_ID = @PACK_STORE_ID)"
                ProviderName="System.Data.SqlClient">
                <DeleteParameters>
                    <asp:Parameter Name="PACK_STORE_ID" />
                </DeleteParameters>
                <UpdateParameters>
                    <asp:Parameter Name="WARD_ID" />
                    <asp:SessionParameter Name="SUSER" SessionField="uid" />
                    <asp:Parameter Name="PACK_STORE_ID" />
                </UpdateParameters>
            </asp:SqlDataSource>
            <asp:GridView ID="gvwPack_Store" runat="server" AllowPaging="True" AllowSorting="True"
                AutoGenerateColumns="False" CellPadding="4" CssClass="controls" DataKeyNames="PACK_STORE_ID"
                DataSourceID="dsrcPack_Store" ForeColor="#333333" GridLines="None" PageSize="15"
                SelectedIndex="0" OnRowEditing="gvwPack_Store_RowEditing" OnRowCancelingEdit="gvwPack_Store_RowCancelingEdit"
                OnRowCommand="gvwPack_Store_RowCommand" OnRowUpdated="gvwPack_Store_RowUpdated"
                Caption="Формы выпуска"
                onpageindexchanged="gvwPack_Store_PageIndexChanged" 
                onrowcreated="gvwPack_Store_RowCreated" 
                onrowupdating="gvwPack_Store_RowUpdating">
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <RowStyle BackColor="#EFF3FB" />
                <Columns>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:Label ID="lblEditError" runat="server" SkinID="ErrorLabel"> </asp:Label>
                            <asp:ImageButton ID="btnEdit" runat="server" CausesValidation="False" CommandName="Edit"
                                ImageUrl="~/images/ico_16_4207.gif" Text="Редактировать" />
                            &nbsp;
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:ImageButton ID="btnSave" runat="server" CausesValidation="True" CommandName="Update"
                                ImageUrl="~/images/16_L_save.gif" Text="Сохранить" />
                            &nbsp;<asp:ImageButton ID="btnCancel" runat="server" CausesValidation="False" CommandName="Cancel"
                                ImageUrl="~/images/clear.GIF" Text="Отмена" />
                        </EditItemTemplate>
                        <ControlStyle CssClass="controls" />
                        <ItemStyle HorizontalAlign="Left" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Отделение" SortExpression="WARD_DESCRIPTION">
                        <ItemTemplate>
                            <asp:Label ID="lblWardSelect" runat="server" Text='<%# Eval("WARD_DESCRIPTION") %>'></asp:Label>
                        </ItemTemplate>
                        <EditItemTemplate>
                            <asp:DropDownList ID="ddlWardSelect" runat="server" DataSourceID="dsrcWard"
                                DataTextField="WARD_DESCRIPTION" DataValueField="WARD_ID" SelectedValue='<%# Bind("WARD_ID") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvWardSelect" runat="server" ControlToValidate="ddlWardSelect"
                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True">
                            </asp:RequiredFieldValidator>
                        </EditItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ShowHeader="False">
                        <ItemTemplate>
                            <asp:ImageButton ID="btnDelete" runat="server" AlternateText="Удалить" CausesValidation="False"
                                CommandName="Delete" ImageUrl="~/images/16_L_remove.gif" OnClientClick="javascript:return confirm('Удалить данные?');"
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
                <asp:Label ID="lblAddError" runat="server" SkinID="ErrorLabel" Text=""></asp:Label>
                <asp:Button ID="btnAddPack_Store" runat="server" Text="Добавить запись" OnClick="btnAddPack_Store_Click" />
                <asp:Label ID="lblRefreshError" runat="server" SkinID="ErrorLabel" Text=""></asp:Label>
                <asp:Button ID="btnRefreshPack_Store" runat="server" Text="Обновить данные" OnClick="btnRefreshPack_Store_Click" />
                <asp:Label ID="lblFindError" runat="server" SkinID="ErrorLabel"></asp:Label>
                <asp:Button ID="btnFindPopup" runat="server" Text="Поиск" />
            </div>
            <cc1:ModalPopupExtender ID="mpeFind" runat="server" TargetControlID="btnFindPopup"
                PopupControlID="pnlFindPack_Store" BackgroundCssClass="modalBackground" CancelControlID="btnCancelFindPack_Store"
                DropShadow="true" PopupDragHandleControlID="pnlFindHeader">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnAddPack_Store" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnFindPack_Store" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="btnRefreshPack_Store" EventName="Click" />
            <asp:AsyncPostBackTrigger ControlID="gvwPack_Store" EventName="DataBound" />
            <asp:AsyncPostBackTrigger ControlID="gvwPack_Store" EventName="RowCommand" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
