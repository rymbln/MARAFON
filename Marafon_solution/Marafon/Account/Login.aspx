<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Login.aspx.cs" Inherits="Marafon.Login" Theme="Marafon" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml" >
<head runat="server">
    <title>МАРАФОН</title>
</head>
<body>
    <form id="form1" runat="server">
        <asp:Panel ID="Panel1" runat="server" SkinID="TopHeaderPanelLogin">
            Мониторинг РАспространенности и антибиотикорезистентности возбудителей нозокомиальных инфекций и практики использования антимикробных препаратов в многопроФильных стационарах различных региОНов России
        </asp:Panel>
        <asp:Panel ID="Panel2" runat="server" SkinID="MainHeaderPanelLogin">
            (&quot;МАРАФОН&quot;)
        </asp:Panel>
        <br />
        <asp:Panel ID="Panel3" runat="server" SkinID="MainPanelLogin" >
        <center>
            <asp:Login ID="MainLogin" runat="server"  
                FailureText="Неверные данные. Пожалуйста, попробуйте снова" 
                LoginButtonText="Вход" PasswordLabelText="Пароль: " 
                PasswordRequiredErrorMessage="Требуется пароль" 
                RememberMeText="Запомнить меня для следующего раза" 
                TitleText="Вход" 
                UserNameLabelText="Имя пользователя: " 
                UserNameRequiredErrorMessage="Требуется имя пользователя" 
                DestinationPageUrl="~/About.aspx" RenderOuterTable="True" 
                TextLayout="TextOnLeft" onloggedin="MainLogin_LoggedIn">
            </asp:Login>
            <asp:SqlDataSource ID="SqlDataSource1" runat="server" 
                ConnectionString="<%$ ConnectionStrings:MarafonConnection %>" 
                DataSourceMode="DataReader" 
                
                SelectCommand="SELECT COUNT(*) AS cnt FROM PACK_STORE WHERE (suser = @SUSER)">
                <SelectParameters>
                    <asp:Parameter Name="SUSER" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource2" runat="server" 
                ConnectionString="<%$ ConnectionStrings:MarafonConnection %>" 
                DataSourceMode="DataReader" 
                SelectCommand="SELECT COUNT(*) AS cnt FROM crf WHERE (suser = @SUSER)">
                <SelectParameters>
                    <asp:Parameter Name="SUSER" />
                </SelectParameters>
            </asp:SqlDataSource>
            <asp:SqlDataSource ID="SqlDataSource3" runat="server" 
                ConnectionString="<%$ ConnectionStrings:MarafonConnection %>" 
                DataSourceMode="DataReader" 
                
                SelectCommand="SELECT TOP (1) Center_id FROM Users_In_Centers WHERE (Username = @SUSER)">
                <SelectParameters>
                    <asp:Parameter Name="SUSER" />
                </SelectParameters>
            </asp:SqlDataSource>
        </center>
        </asp:Panel>
    </form>
</body>
</html>
