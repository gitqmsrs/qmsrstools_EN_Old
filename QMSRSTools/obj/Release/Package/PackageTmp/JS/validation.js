/*validate against future dates*/
function comparePast(sender, args)
{
    args.IsValid = true;

    var todaypart = getDatePart(new Date().format("dd/MM/yyyy"));
    var datepart = getDatePart(args.Value);

    var today = new Date(todaypart[2], (todaypart[1] - 1), todaypart[0]);
    var date = new Date(datepart[2], (datepart[1] - 1), datepart[0]);

    if (date > today)
    {
        args.IsValid = false;
    }
    else {
        args.IsValid = true;
    }

    return args.IsValid;
}

/*validate against past dates*/
function compareFuture(sender, args)
{
    args.IsValid = true;

    var todaypart = getDatePart(new Date().format("dd/MM/yyyy"));
    var datepart = getDatePart(args.Value);

    var today = new Date(todaypart[2], (todaypart[1] - 1), todaypart[0]);
    var date = new Date(datepart[2], (datepart[1] - 1), datepart[0]);

    if (date >= today) {
        args.IsValid = true;
    }
    else
    {
        args.IsValid = false;
    }

    return args.IsValid;
}

/*validate realistic dates*/
function validateDate(sender, args)
{
    args.IsValid = true;

    var datepart = getDatePart(args.Value);

    var day = parseInt(datepart[0]);
    var month = parseInt(datepart[1]);
    var year = parseInt(datepart[2]);
  
    // Check the ranges of month and year
    if (year < 1000 || year > 3000 || month == 0 || month > 12)
    {
        args.IsValid = false;
    }

    var monthLength = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

    // Adjust for leap years
    if (year % 400 == 0 || (year % 100 != 0 && year % 4 == 0))
    {
        monthLength[1] = 29;
    }

    // Check the range of the day
    args.IsValid= (day > 0 && day <= monthLength[month - 1]);

    return args.IsValid;
}

/*validate against future and past dates*/
function compareEqualsToday(sender, args)
{
    args.IsValid = true;

    var todaypart = getDatePart(new Date().format("dd/MM/yyyy"));
    var datepart = getDatePart(args.Value);

    var today = new Date(todaypart[2], (todaypart[1] - 1), todaypart[0]);
    var date = new Date(datepart[2], (datepart[1] - 1), datepart[0]);

    if (date > today || date<today)
    {
        args.IsValid = false;
    }

    return args.IsValid;
}

/*validate against past dates*/
function compareGreaterThanEqualsToday(sender, args) {
    args.IsValid = true;

    var todaypart = getDatePart(new Date().format("dd/MM/yyyy"));
    var datepart = getDatePart(args.Value);

    var today = new Date(todaypart[2], (todaypart[1] - 1), todaypart[0]);
    var date = new Date(datepart[2], (datepart[1] - 1), datepart[0]);

    if (date >= today) {
        args.IsValid = true;
    }
    else {
        args.IsValid = false;
    }

    return args.IsValid;
}


/*validate against ID fields*/
function validateIDField(sender, args) {
    args.IsValid = true;

    var iChars = "!@$#%^&*+=[]\\\';,.{}|\":<>";
    for (var i = 0; i < args.Value.length; i++) {
        if (iChars.indexOf(args.Value.charAt(i)) != -1) {
            args.IsValid = false;

            return false;
        }
    }

    return args.IsValid;
}

/*validate against special characters*/
function validateSpecialCharacters(sender, args)
{
    args.IsValid = true;

    var iChars = "!@$%^&*+=[]\\\';.{}|\":<>";
    for (var i = 0; i < args.Value.length; i++)
    {
        if (iChars.indexOf(args.Value.charAt(i)) != -1)
        {
            args.IsValid = false;

            return false;
        }
    }

    return args.IsValid;
}


function validateSpecialCharactersLongText(sender, args) {
    args.IsValid = true;

    var iChars = "!@$%^*+=[]{}|<>";
    for (var i = 0; i < args.Value.length; i++) {
        if (iChars.indexOf(args.Value.charAt(i)) != -1) {
            args.IsValid = false;

            return false;
        }
    }

    return args.IsValid;
}


function validatePhoneNumber(sender, args)
{
    args.IsValid = true;

    var pattern = "^[\+]?[0-9]{10,12}$";
    var regex = new RegExp(pattern);
    if (!regex.test(args.Value))
    {
        args.IsValid = false;
    }

    return args.IsValid;
}

function validateZero(sender, args)
{
    args.IsValid = true;

    var number = parseInt(args.Value);

    if (number <= 0)
    {
        args.IsValid = false;
    }

    return args.IsValid;
}