<%@ Page Title="О проекте" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="Marafon.About" Theme="Marafon" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
           
    <asp:Panel ID="Panel1" runat="server" SkinID="AboutPanel">
        <asp:HyperLink ID="HyperLink26" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/Center.aspx">Центры</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink1" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/DiagnosisResult.aspx">Исход развития инфекции</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink2" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/DiagnosisType.aspx">Типы диагнозов</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink3" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/Frequency.aspx">Кратность введения</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink4" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/ClinicalMaterialGroup.aspx">Группы КМ и КМ</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink5" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/WardBedDays.aspx">Койко-дни по стационару</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink6" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/MedicalForm.aspx">Формы выпуска</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink7" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/MeasureItem.aspx">Единицы измерения</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink8" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/Quarter.aspx">Кварталы</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink9" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/Region.aspx">Регионы</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink10" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/Risk_Factor.aspx">Факторы риска</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink11" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/Sex.aspx">Пол</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink12" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/WardType.aspx">Типы отделений</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink13" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/GenericAB.aspx">МНН и торговые названия</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink14" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/ABGroup.aspx">Группы АБ</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink15" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/AdminRoute.aspx">Пути введения</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink16" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/TabletPack.aspx">Препараты в продаже</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink17" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/Diagnosis.aspx">Диагнозы</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink18" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/RemoteDataImport.aspx">Импорт данных по потреблению</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink19" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/PatientGroup.aspx">Группы пациентов</asp:HyperLink>
        <br />
        <br />
         <br />
        <br />
        <asp:HyperLink ID="HyperLink20" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/Crf.aspx">Перейти к вводу ИРК</asp:HyperLink>
        <br />
        <br />

    </asp:Panel>
</asp:Content>
