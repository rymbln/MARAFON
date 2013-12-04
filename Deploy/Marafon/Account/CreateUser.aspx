<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="CreateUser.aspx.cs" Inherits="Marafon.Account.CreateUser" Theme="Marafon" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server" UpdateMode="Conditional">
        <ContentTemplate>
            <asp:Panel ID="pnlFindUser" runat="server" Style="display: none; text-align: right;
                vertical-align: middle" CssClass="modalPopup">
                <asp:Panel ID="pnlFindHeader" runat="server" Style="cursor: move; background-color: #DDDDDD;
                    border: solid 1px Gray; color: Black; text-align: center;">
                    <div>
                        <p>
                            Поиск</p>
                    </div>
                </asp:Panel>
                <br />
                <asp:Label ID="lblFindUserName" runat="server" Text="Имя пользователя или его часть: "></asp:Label>
                <asp:TextBox ID="tboxFindUserName" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="lblFindLastName" runat="server" Text="Фамилия или её часть: "></asp:Label>
                <asp:TextBox ID="tboxFindLastName" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="lblFindRoleName" runat="server" Text="Название роли или её часть: "></asp:Label>
                <asp:TextBox ID="tboxFindRoleName" runat="server"></asp:TextBox>
                <br />
                <asp:Label ID="lblFindCenter" runat="server" Text="Название центра или его часть: "></asp:Label>
                <asp:TextBox ID="tboxFindCenter" runat="server"></asp:TextBox>
                <br />
                <br />
                <asp:Button ID="btnFindUser" runat="server" Text="Поиск" OnClick="btnFindUser_Click" />
                <asp:Button ID="btnCancelFindUser" runat="server" Text="Отменить поиск" />
            </asp:Panel>
            
            
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                DeleteCommand="procDeleteUser" DeleteCommandType="StoredProcedure" InsertCommand="procAddNewUser"
                InsertCommandType="StoredProcedure" SelectCommand="SELECT * FROM [VW_ENGINE_USERS]">
                <DeleteParameters>
                    <asp:Parameter Name="UserName" Type="String" />
                </DeleteParameters>
                <InsertParameters>
                    <asp:Parameter Name="UserName" Type="String" />
                    <asp:Parameter Name="Password" Type="String" />
                    <asp:Parameter Name="ConfirmPassword" Type="String" />
                    <asp:Parameter Name="FirstName" Type="String" />
                    <asp:Parameter Name="LastName" Type="String" />
                    <asp:Parameter Name="RoleName" Type="String" />
                    <asp:Parameter Name="Center_ID" Type="Int32" />
                </InsertParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                SelectCommand="SELECT [center_id], [description] FROM [vw_center_description]">
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" ConnectionString="<%$ ConnectionStrings:MarafonConnection %>"
                SelectCommand="SELECT [RoleName] FROM [vw_aspnet_Roles]"></asp:SqlDataSource>
            <asp:DetailsView ID="DetailsView1" runat="server" AutoGenerateRows="False" DataKeyNames="UserName"
                DataSourceID="SqlDataSource1" Height="50px" Width="125px" AllowPaging="True"
                HeaderText="Управление пользователями" EnableModelValidation="True">
                <Fields>
                    <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Имя пользователя"
                        SortExpression="UserName">
                        <ItemTemplate>
                            <asp:Label ID="lblUserName" runat="server" Text='<%# Eval("UserName") %>'></asp:Label>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tboxUserNameInsert" runat="server" Text='<%# Bind("UserName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvUserName" runat="server" ControlToValidate="tboxUserNameInsert"
                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Пароль" SortExpression="Password">
                        <ItemTemplate>
                            <asp:Label ID="lblPassword" runat="server" Text='<%# Eval("Password") %>'></asp:Label>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tboxPasswordInsert" runat="server" Text='<%# Bind("Password") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvPassword" runat="server" ControlToValidate="tboxPasswordInsert"
                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Подтверждение пароля"
                        SortExpression="ConfirmPassword">
                        <ItemTemplate>
                            <asp:Label ID="lblConfirmPassword" runat="server" Text='<%# Eval("ConfirmPassword") %>'></asp:Label>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tboxConfirmPasswordInsert" runat="server" Text='<%# Bind("ConfirmPassword") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvConfirmPassword" runat="server" ControlToValidate="tboxConfirmPasswordInsert"
                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Имя" SortExpression="FirstName">
                        <ItemTemplate>
                            <asp:Label ID="lblFirstName" runat="server" Text='<%# Eval("FirstName") %>'></asp:Label>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tboxFirstNameInsert" runat="server" Text='<%# Bind("FirstName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvFirstName" runat="server" ControlToValidate="tboxFirstNameInsert"
                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Фамилия" SortExpression="LastName">
                        <ItemTemplate>
                            <asp:Label ID="lblLastName" runat="server" Text='<%# Eval("LastName") %>'></asp:Label>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:TextBox ID="tboxLastNameInsert" runat="server" Text='<%# Bind("LastName") %>'></asp:TextBox>
                            <asp:RequiredFieldValidator ID="rfvLastName" runat="server" ControlToValidate="tboxLastNameInsert"
                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField ConvertEmptyStringToNull="False" HeaderText="Роль" SortExpression="RoleName">
                        <ItemTemplate>
                            <asp:Label ID="lblRoleName" runat="server" Text='<%# Eval("RoleName") %>'></asp:Label>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="ddlRoleName" runat="server" DataSourceID="SqlDataSource2" DataTextField="RoleName"
                                DataValueField="RoleName" SelectedValue='<%# Bind("RoleName") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvRoleName" runat="server" ControlToValidate="ddlRoleName"
                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Центр" SortExpression="Center_id">
                        <ItemTemplate>
                            <asp:Label ID="lblCenter" runat="server" Text='<%# Eval("Center_Description") %>'></asp:Label>
                        </ItemTemplate>
                        <InsertItemTemplate>
                            <asp:DropDownList ID="ddlCenter" runat="server" DataSourceID="SqlDataSource3" DataTextField="description"
                                DataValueField="center_id" SelectedValue='<%# Bind("Center_id") %>'>
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="rfvCenter" runat="server" ControlToValidate="ddlCenter"
                                CssClass="controls" Display="Dynamic" ErrorMessage="*" SetFocusOnError="True"></asp:RequiredFieldValidator>
                        </InsertItemTemplate>
                    </asp:TemplateField>
                    <asp:CommandField ShowDeleteButton="True" ButtonType="Button" ShowInsertButton="True"
                        EditText="Редактировать" UpdateText="Сохранить" InsertText="Добавить пользователя"
                        SelectText="Выбрать" />
                </Fields>
            </asp:DetailsView>
            <div style="text-align: left; vertical-align: middle">
                <asp:Button ID="btnRefreshUser" runat="server" Text="Обновить данные" OnClick="btnRefreshUser_Click" />
                <asp:Button ID="btnFindPopup" runat="server" Text="Поиск" />
            </div>
            <cc1:ModalPopupExtender id="mpeFindUser" runat="server" targetcontrolid="btnFindPopup"
                popupcontrolid="pnlFindUser" backgroundcssclass="modalBackground" cancelcontrolid="btnCancelFindUser"
                dropshadow="true" popupdraghandlecontrolid="pnlFindHeader">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:AsyncPostBackTrigger ControlID="btnFindUser" EventName="Click" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
