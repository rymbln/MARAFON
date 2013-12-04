// JScript File

function fnValidateMinNow(source, args) 
{
    if (args.Value == null) 
    {
        args.IsValid = true;
        return true;
    }

    var arrDate = args.Value.split('.');
    var strDate = arrDate[1] + '/' + arrDate[0] + '/' + arrDate[2];
    var dtDate = Date.parse(strDate);
    if (dtDate == NaN) 
    {
        args.IsValid = true;
        return true;
    }

    var dtNow = new Date();
    var dtMin = Date.parse('01/01/1900');

    if ((dtDate < dtNow) && (dtDate > dtMin))
    {
        args.IsValid = true;
    }
    else {
        args.IsValid = false;
    }
    return true;
}


function IsDate(ctrlValue,LNG) 
{
    var dateStr =  ctrlValue ;
    var datePat = /^(\d{1,2})(\.)(\d{1,2})(\.)(\d{4})$/;
    var matchArray = dateStr.match(datePat); // is the format ok?
  
    if (matchArray == null) 
    {
        if (LNG == 1) 
        {
            alert("Введите дату в формате dd.mm.yyyy!");
        }
        else
        {
            alert("Please enter date as either mm.dd.yyyy.");
        }    
        return false;
    }
    if (LNG == 1) 
    {
        day = matchArray[1]; // p@rse date into variables
        month = matchArray[3];
        year = matchArray[5];
    }
    else
    {
        month = matchArray[1]; // p@rse date into variables
        day = matchArray[3];
        year = matchArray[5];
    }
    if (month < 1 || month > 12) 
    { // check month range
        alert("Месяц может принимать значение от 1 до 12!");
        return false;
    }
    if (day < 1 || day > 31) 
    {
        alert("День может принимать значение от 1 до 31!");
        return false;
    }
    if ((month==4 || month==6 || month==9 || month==11) && day==31) 
    {
        alert("В месяце "+month+" меньше 31 дня!");
        return false;
    }
    if (month == 2) 
    { // check for february 29th
        var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
        if (day > 29 || (day==29 && !isleap)) 
        {
            alert("В феврале " + year + " года меньше 29 дней!");
            return false;
        }
    }
    return true;
}   

function fnIsDate(source, args)
{
    if (args.Value == null)
    {
        args.IsValid = false;
        return false;
    }
    var boolResult = IsDate(args.Value,1);
    if (boolResult)
    {
        args.IsValid = true;
    }
    else
    {
        args.IsValid = false;
    }
    return true;
}

function IsDateTime(ctrlValue,LNG) 
{
    var dateStr =  ctrlValue ;
    var datePat = /^(\d{1,2})(\.)(\d{1,2})(\.)(\d{4})(\ )(\d{1,2})(\:)(\d{1,2})$/;
    var matchArray = dateStr.match(datePat); // is the format ok?
  
    if (matchArray == null) 
    {
        if (LNG == 1) 
        {
            alert("Введите дату в формате dd.mm.yyyy mm:ss!");
        }
        else
        {
            alert("Please enter date as either mm.dd.yyyy mm:ss!");
        }    
        return false;
    }
    if (LNG == 1) 
    {
        day = matchArray[1]; // p@rse date into variables
        month = matchArray[3];
        year = matchArray[5];
    }
    else
    {
        month = matchArray[1]; // p@rse date into variables
        day = matchArray[3];
        year = matchArray[5];
    }
    minute = matchArray[7];
    second = matchArray[9];
    if (month < 1 || month > 12) 
    { // check month range
        alert("Месяц может принимать значение от 1 до 12!");
        return false;
    }
    if (day < 1 || day > 31) 
    {
        alert("День может принимать значение от 1 до 31!");
        return false;
    }
    if ((month==4 || month==6 || month==9 || month==11) && day==31) 
    {
        alert("В месяце "+month+" меньше 31 дня!");
        return false;
    }
    if (month == 2) 
    { // check for february 29th
        var isleap = (year % 4 == 0 && (year % 100 != 0 || year % 400 == 0));
        if (day > 29 || (day==29 && !isleap)) 
        {
            alert("В феврале " + year + " года меньше 29 дней!");
            return false;
        }
    }
    if (minute < 0 || minute > 59) 
    { // check month range
        alert("Число минут может быть от 0 до 59!");
        return false;
    }
    if (second < 0 || second > 59) 
    { // check month range
        alert("Число секунд может быть от 0 до 59!");
        return false;
    }
    return true;
}   

function fnIsDateTime(source, args)
{
    if (args.Value == null)
    {
        args.IsValid = false;
        return false;
    }
    var boolResult = IsDateTime(args.Value,1);
    if (boolResult)
    {
        args.IsValid = true;
    }
    else
    {
        args.IsValid = false;
    }
    return true;
}

function fnIsNotEmpty(source, args)
{
    if (args.Value == null)
    {
        alert("Поле не заполнено!");
        args.IsValid = false;
        return false;
    }
    else
    {
        if (args.Value == "")
        {
            alert("Поле не заполнено!");
            args.IsValid = false;
            return false;
        }
        else
        {
            args.IsValid = true;
            return true;
        }
    }
}
