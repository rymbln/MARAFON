<%@ Page Title="О проекте" Language="C#" MasterPageFile="~/Site.master" AutoEventWireup="true"
    CodeBehind="About.aspx.cs" Inherits="Marafon.About" Theme="Marafon" %>

<asp:Content ID="BodyContent" runat="server" ContentPlaceHolderID="MainContent">
    <asp:Panel runat="server" SkinID="AboutPanel">
        <p style="text-align: center; font-weight: 700; font-size: large;">
            Краткая инструкция по работе с базой данных
        </p>
        <p style="text-align: justify">
            База данных исследования «МАРАФОН» состоит из 2 разделов: Ввод ИРК – для 
            регистрации информации, касающейся пациентов, включенных в исследование, и Ввод 
            данных по потреблению АМП.
        </p>
        <p style="text-align: justify">
            <img alt="" src="images/Start.gif" 
                style="width: 522px; height: 205px" />
        </p>
        <p style="text-align: justify; font-weight: 700;">
            Общие правила ввода данных.
        </p>
        <p style="text-align: justify">
            Для того чтобы создать новую ИРК, нужно нажать кнопку «Добавить»</p>
        <p style="text-align: justify">
            &nbsp;<img alt="" src="images/Add_Crf_Start.gif" 
                style="width: 441px; height: 228px" /></p>
        <p style="text-align: justify">
            Все данные вводятся в соответствующие поля на соответствующих вкладках. Названия 
            полей и вкладок соответствуют бумажной ИРК. После заполнения всех необходимых 
            полей <span style="color: #FF0000"><strong>ОБЯЗАТЕЛЬНО</strong></span> нужно 
            сохранять введенные данные нажатием кнопки «Сохранить».</p>
        <p style="text-align: justify">
            &nbsp;<img alt="" src="images/Tabs.gif" 
                style="width: 676px; height: 420px" /></p>
        <p style="text-align: justify">
            Виды полей для ввода данных: свободное поле – позволяет ввести любой текст (1); 
            поле для ввода даты – позволяет ввести дату вручную или выбрать дату, используя 
            календарь
            <img alt="" src="images/Calendar_scheduleHS.png" 
                style="width: 16px; height: 16px" />
            (2); поле, содержащее выпадающий список (3) – позволяет выбрать один из 
            вариантов формулировки данных, содержащихся в списке.</p>
        <p style="text-align: justify">
            &nbsp;<img alt="" src="images/Infill_Data.gif" 
                style="width: 766px; height: 520px" /></p>
        <p style="text-align: justify">
            При необходимости ввести информацию, не содержащуюся в выпадающем списке, Вы 
            можете внести ее в свободное поле с аналогичным заголовком и пометкой «(доп.)» 
            (4). Если Вы не нашли нужного значения в списке и свободное поле с аналогичным 
            заголовком и пометкой «(доп.)» отсутствует, выберите наиболее близкий вариант из 
            списка и проинформируйте об этом координатора.
        </p>
        <p style="text-align: justify">
            <img alt="" src="images/Other.gif" 
                style="width: 800px; height: 150px" />
        </p>
        <p style="text-align: justify">
            В свободных полях «Диагноз» (вкладка «Диагнозы»), «Диагноз(доп.)» (вкладка 
            «Нозокомиальные инф-и»), «Вид оперативного вмешательства» (вкладка «Операции»), 
            «Город» и «Стационар» (вкладка «Предшеств. госпитализации»), а также «Отделение» 
            (вкладка «Пребывание в отделениях») при заполнении появляется подсказка в виде 
            списка из введённых ранее значений. Вы можете воспользоваться предложенным 
            списком или добавить новый вариант, продолжая набирать текст (5).
        </p>
        <p style="text-align: justify">
            <img alt="" src="images/Auto_Complete.gif" 
                style="width: 581px; height: 241px" />
        </p>
        <p style="text-align: justify">
            Поля, обязательные для заполнения, обозначаются знаком «<span 
                style="color: #FF0000">*</span>» (6). Если используется неверный формат 
            ввода данных или введенные данные не соответствуют протоколу исследования, 
            появляется предупреждение (7).
        </p>
        <p style="text-align: justify">
            <img alt="" src="images/Errors.gif" 
                style="width: 1038px; height: 213px" />
        </p>
        <p style="text-align: justify">
            После заполнения всех необходимых полей нужно сохранить введенные данные. Для 
            этого нажмите кнопку «Сохранить»
            <img alt="" src="images/16_L_save.gif" 
                style="width: 16px; height: 16px" />
            (8). Для того чтобы отменить добавление данных, нажмите на кнопку «Отмена»
            <img alt="" src="images/clear.GIF" 
                style="width: 16px; height: 16px" />
            (9). Для того чтобы изменить данные, дополнить карту или удалить ошибочно 
            внесённые данные, нужно выбрать необходимую карту: для этого нужно нажать на 
            кнопку «Выбрать»
            <img alt="" src="images/16_publish.gif" 
                style="width: 16px; height: 16px" />
            (10) в соответствующей строке. Выбранная строка выделяется в таблице жирным 
            шрифтом. Для удаления нужно нажать кнопку «Удалить»
            <img alt="" src="images/16_L_remove.gif" 
                style="width: 16px; height: 16px" />
            (11), при удалении база запросит подтверждение. Для изменения данных нужно 
            нажать на кнопку «Редактировать»
            <img alt="" src="images/ico_16_4207.gif" 
                style="width: 16px; height: 16px" />
            (12).
        </p>
        <p style="text-align: justify">
            <img alt="" src="images/Buttons.gif" 
                style="width: 758px; height: 244px" />
        </p>
        <p style="text-align: justify">
            Дальнейшие действия при изменении данных повторяют действия при добавлении 
            карты. При добавлении и изменении данных выбор других строк невозможен. После 
            ввода информации о пациенте можно вносить информацию о диагнозах, НИ, операциях, 
            факторах риска, предшествующих госпитализациях, пребывании в различных 
            отделениях, АМП и микробиологических исследованиях пациента. Для этого нужно 
            выбрать карту (после добавления новой карты она выбирается автоматически). Для 
            того чтобы ввести новые данные, нажмите кнопку «Добавить…» на соответствующей 
            странице. Например, для добавления клинического диагноза на странице 
            «Клинические диагнозы», нажмите кнопку «Добавить клинический диагноз» (13).
        </p>
        <p style="text-align: justify">
            <img alt="" src="images/Add_In_Tab.gif" 
                style="width: 317px; height: 121px" />
        </p>
        <p style="text-align: justify">
            На каждой странице после заполнения всех необходимых полей
            <span style="color: #FF0000"><strong>ОБЯЗАТЕЛЬНО</strong></span> нужно сохранять 
            введенные данные нажатием кнопки «Сохранить». Если нужная карта отсутствует на 
            странице, нужно воспользоваться поиском. Для этого нужно нажать кнопку «Поиск» 
            (15). Для того чтобы показать все результаты, нужно нажать кнопку «Обновить 
            данные» (16).
        </p>
        <p style="text-align: justify">
            <img alt="" src="images/Find_Refresh.gif" 
                style="width: 411px; height: 109px" />
        </p>
    </asp:Panel>
    <br />
    <asp:Panel ID="Panel8" runat="server" SkinID="AboutPanel">
        <br />
        <asp:HyperLink ID="HyperLink13" runat="server" CssClass="controls" NavigateUrl="~/documents/Marafon_Protocol.doc"
            Target="_blank">Скачать протокол исследования</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink15" runat="server" CssClass="controls" NavigateUrl="~/documents/Marafon_CRF.doc"
            Target="_blank">Скачать ИРК</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink2" runat="server" CssClass="controls" NavigateUrl="~/documents/Marafon_CRF_Rules.doc"
            Target="_blank">Скачать правила заполнения ИРК</asp:HyperLink>
        <br />
        <br />
        <asp:HyperLink ID="HyperLink3" runat="server" CssClass="controls" NavigateUrl="~/documents/Marafon_CRF_Rules.doc"
            Target="_blank">Скачать презентацию проекта "МАРАФОН"</asp:HyperLink>
    </asp:Panel>
    <br />
    <asp:Panel runat="server" SkinID="AboutPanel">
        <asp:HyperLink ID="HyperLink26" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/Crf.aspx">Перейти к вводу ИРК</asp:HyperLink>
        <br />
        <asp:HyperLink ID="HyperLink4" runat="server" CssClass="controls" Style="font-weight: 700"
            Font-Size="Medium" NavigateUrl="~/PackStore.aspx">Перейти к вводу данных по потреблению</asp:HyperLink>
        <br />
    </asp:Panel>
</asp:Content>
