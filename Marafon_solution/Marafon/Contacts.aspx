<%@ Page Title="" Language="C#" MasterPageFile="~/Site.Master" AutoEventWireup="true"
    CodeBehind="Contacts.aspx.cs" Inherits="Marafon.Contacts" Theme="Marafon" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <asp:Panel ID="Panel1" runat="server" GroupingText="Ввод данных" HorizontalAlign="Left"
        Width="97%" CssClass="controls" SkinID="AboutPanel">
        <asp:HyperLink ID="HyperLink26" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/Crf.aspx">Перейти к вводу ИРК</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/PackStore.aspx">Перейти к вводу данных по потреблению</asp:HyperLink>
        <br />
    </asp:Panel>
    <asp:Panel ID="Panel8" runat="server" GroupingText="Общая информация" HorizontalAlign="Left"
        Width="97%" SkinID="AboutPanel">
        <asp:HyperLink ID="HyperLink13" runat="server" CssClass="controls" NavigateUrl="~/documents/Marafon_Protocol.pdf"
            Target="_blank">Скачать протокол исследования</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink15" runat="server" CssClass="controls" NavigateUrl="~/documents/Marafon_CRF.pdf"
            Target="_blank">Скачать ИРК</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink2" runat="server" CssClass="controls" NavigateUrl="~/documents/Marafon_CRF_Rules.pdf"
            Target="_blank">Скачать правила заполнения ИРК</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink3" runat="server" CssClass="controls" NavigateUrl="~/documents/Marafon_Presentation.pdf"
            Target="_blank">Скачать презентацию проекта "МАРАФОН"</asp:HyperLink>
    </asp:Panel>
    <asp:Panel ID="Panel10" runat="server" GroupingText="Координатор исследования " HorizontalAlign="Left"
        Width="97%" CssClass="controls" SkinID="AboutPanel">
        <br />
        <asp:HyperLink ID="HyperLink19" runat="server" CssClass="controls">ФИО: Сидоченкова Екатерина Александровна</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink20" runat="server" CssClass="controls">Телефон: 8-915-653-95-00</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink21" runat="server" CssClass="controls" NavigateUrl="mailto:kate.sidochenkova@antibiotic.ru"
            Target="_blank">E-mail: Kate.Sidochenkova@antibiotic.ru</asp:HyperLink>
        <br />
    </asp:Panel>
    <asp:Panel ID="Panel9" runat="server" GroupingText="Техническая поддержка " HorizontalAlign="Left"
        Width="97%" SkinID="AboutPanel">
        <br />
        <asp:HyperLink ID="HyperLink16" runat="server" CssClass="controls">ФИО: Трушин Иван Витальевич</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink17" runat="server" CssClass="controls">Телефон: 8 (4812) 45-06-02 (доб. 142)</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink18" runat="server" CssClass="controls" NavigateUrl="mailto:Ivan.Trushin@antibiotic.ru"
            Target="_blank">E-mail: Ivan.Trushin@antibiotic.ru</asp:HyperLink>
        <br />
    </asp:Panel>
</asp:Content>

