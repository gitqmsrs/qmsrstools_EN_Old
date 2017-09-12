function redirectPage(link) {
    window.location = link;
}

//String Builder Class Implementation
function StringBuilder(value)
{
    this.strings = new Array("");
    this.append(value);
}

// Appends the given value to the end of this instance.
StringBuilder.prototype.append = function (value) {
    if (value) {
        this.strings.push(value);
    }
}

// Clears the string buffer
StringBuilder.prototype.clear = function () {
    this.strings.length = 1;
}

// Converts this instance to a String.
StringBuilder.prototype.toString = function () {
    return this.strings.join("");
}

//calculate days
function getDays(startdate, enddate) {
    // from milliseconds to one day

    var day = 1000 * 60 * 60 * 24;

    var difference = enddate - startdate;

    return isNaN(difference) ? "-" : Math.round(difference / day);
}

function format(source)
{
    var text = source;

    //format detail text
    ///\s+/g space characters

    if (text != '' && text.search("<p>")==-1)
    {
        text = $.trim(text);

        text = '<p>' + text + '</p>';

        text = text.replace(/\(/g, " ( ");
        text = text.replace(/\)/g, " ) ");

        text = text.replace(/\.\s/g, ".</p><br/><p>");
        text = text.replace(/\,\s{3,}/g, "</p><br/><p>");
  
    }
    return text;
}

function removeFormat(source)
{
    var text = source;

    text = text.replace(new RegExp("<p>", "g"), "");
    text = text.replace(new RegExp("</p>", "g"), "");
    text = text.replace(new RegExp("<br/>", "g"), "\n");
  
    return text;
}

function shortenText(text)
{
    if (text != null) {
        if (text.length > 50) {
            text = text.substring(0, 49);
            text += '...';
        }
    }
    return text;
}
//calculate time difference 
function timeDifference(starttime, endtime)
{
    var difference = toSeconds(endtime) - toSeconds(starttime);
    var result =
    [
       isNaN(difference) ? '-' : Math.floor(difference / 3600),
       isNaN(difference) ? '-' : Math.floor((difference % 3600) / 60),
       isNaN(difference) ? '-' : Math.floor(difference % 60)
    ];

    return result.map(function (v)
    {
        return v < 10 ? '0' + v : v;
    }).join(":");
}

//split string into hours, minutes, and seconds
function toSeconds(timestr) {
    //extract hours, minutes, and seconds
    var seconds = timestr.split(":");

    var hours = seconds[0] * 3600;
    var minutes = seconds[1] * 60;
    var seconds = seconds[2] * 1;

    //return the result in seconds
    return hours + minutes + seconds;
}

//Ajax Loader for Loading User Controls on Client Side
function loadAjax(ID, extension, control)
{
    control.show();
    control.html("<div>Please Wait...</div>");
    $.ajax(
    {
        type: "GET",
        url: "ControlRenderer.ashx?URL=" + ID + "&Extension=" + extension,
        dataType: "HTML",
        success: function (data)
        {
            control.html(data);
        },
        error: function (xhr, status, error)
        {
            var r = jQuery.parseJSON(xhr.responseText);
            alert(xhr.responseText);
        }
    });
}

function resetGroup(control)
{
    $(control).children().each(function (index, value) {
        $(this).find('.textbox').each(function () {
            $(this).val('');

            if ($(this).hasClass("treefield") == false) {
                /*to reset text remaining counter*/
                $(this).keyup();
            }
        });

        $(this).find('.date').each(function () {
            $(this).val('');
        });

        $(this).find('.readonly').each(function () {
            $(this).val('');
        });

        $(this).find('.combobox').each(function () {
            $(this).val(0);
        });

        $(this).find('.checkbox').each(function () {
            $(this).attr('checked', false);
            $(this).trigger('change');
        });

        $(this).find('.radiobutton').each(function () {
            $(this).prop('checked', false);
        });

        $(this).find(".textremaining").each(function () {
            $(this).html('');
        });

        $(this).find(".checklist").each(function () {
            $(this).empty();
        });

        $(this).find(".validator").each(function () {
            $(this).hide();
        });

        $(this).find(".tooltip").each(function () {
            $(this).hide();
        });

        $(this).find(".selectionfield").each(function () {
            if ($(this).is(':hidden') == false) {
                $(this).hide();
            }
        });


        /*hide any opened select boxes*/
        $(".selectbox").each(function () {
            $(this).hide('800');
        });
    });
}

function reset()
{
    //clear textboxes
    $(".textbox").each(function () {
        $(this).val('');
    });
    $(".readonly").each(function () {
        $(this).val('')
    });
    $(".date").each(function ()
    {
        $(this).val('')
    });
    $(".readonlydate").each(function ()
    {
        $(this).val('')
    });

    $(".combobox").each(function ()
    {
        $(this).val(0);
    });

    $(".checkbox").each(function ()
    {
        $(this).attr('checked', false);
    });

}

function bindComboboxXML(xml, classname, field, bound, ID, loader)
{
    $(ID).empty();

    if (xml != null)
    {
        if ($(xml).find(classname).size() > 0)
        {
            var HTML = "<option value=0>Select Value</option>";

            $(xml).find(classname).each(function (index, value)
            {
                HTML += "<option value='" + $(this).attr(field) + "'>" + $(this).attr(field) + "</option>";
            });

            $(ID).append(HTML);
            $(ID).val(bound);
        }
    }
    if (loader != null)
    {
        $(loader).hide("1000");
    }


}
//load data from database to asp dropdownlist
function loadComboboxXML(xml, classname, field, ID, loader)
{
    $(ID).empty();

    if (xml != null) {
        if ($(xml).find(classname).size() > 0) {
            var HTML = "<option value=0>Select Value</option>";

            $(xml).find(classname).each(function (index, value) {
                HTML += "<option value='" + $(this).attr(field) + "'>" + $(this).attr(field) + "</option>";
            });

            $(ID).append(HTML);
        }
    }
    if (loader != null) {
        $(loader).hide("1000");
    }

}

function loadCombobox(ID, values)
{
    $(ID).empty();

    var HTML = '<option value=0>Select Value</option>';
    $.each(values, function (key, value)
    {
        HTML += "<option value='" + value + "'>" + value + "</option>";
    });
    $(ID).append(HTML);
}

function loadComboboxAjax(MethodName, ID, loader)
{
    $(loader).stop(true).hide().fadeIn(500, function ()
    {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: getServiceURL().concat(MethodName),
            data: "{}",
            dataType: "json",
            success: function (data)
            {
                $(loader).fadeOut(500, function ()
                {
                    //clear all previously loaded data
                    $(ID).empty();

                    if (data.d.length > 0) {
                        var HTML = '<option value=0>Select Value</option>';
                        $.each(data.d, function (key, value) {
                            HTML += "<option value='" + value + "'>" + value + "</option>";
                        });
                        $(ID).append(HTML);
                    }
                });
            },
            error: function (xhr, status, error)
            {
                $(loader).fadeOut(500, function ()
                {
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                });
            }
        });
    });
}

function bindComboboxAjax(MethodName, control, bound, loader)
{
    $(loader).stop(true).hide().fadeIn(500, function () {

        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: getServiceURL().concat(MethodName),
            dataType: "json",
            success: function (data)
            {
                $(loader).fadeOut(500, function () {
                    clearCombobox(control);

                    if (data.d.length > 0) {
                        var HTML = '<option value=0>Select Value</option>';

                        $.each(data.d, function (key, value) {
                            HTML += "<option value='" + value + "'>" + value + "</option>";
                        });

                        $(control).append(HTML);
                        $(control).val(bound);
                    }
                });
            },
            error: function (xhr, status, error)
            {
                $(loader).fadeOut(500, function () {

                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                });
            }
        });
    });
}


function loadLogoImage(companyID)
{
    $("#logoheader").attr("src", "http://www.qmsrs.com/qmsrstools/ImageHandler.ashx?query=select CompanyLogo from HumanResources.Company where CompanyID=" + companyID + "&width=324&height=78");
}

//load data from database to asp dropdownlist
function loadLastIDAjax(MethodName, ID)
{
    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        url: getServiceURL().concat(MethodName),
        data: "{}",
        dataType: "json",
        success: function (data)
        {

            if (data.d != '')
            {
                $(ID).text('Previous ID: ' + data.d);
            }
            else
            {
                $(ID).text('Create New ID');
            }
        }
    });
}

function bindParamComboboxAjax(MethodName, control, param, bound,loader)
{
    var parameter = param.split(":");

    $(loader).stop(true).hide().fadeIn(500, function ()
    {
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: getServiceURL().concat(MethodName),
            data: "{" + param + "}",
            dataType: "json",
            success: function (data)
            {
                $(loader).fadeOut(500, function () {
                    clearCombobox(control);

                    if (data.d.length > 0) {
                        var HTML = '<option value=0>Select Value</option>';
                        $.each(data.d, function (key, value) {
                            HTML += "<option value='" + value + "'>" + value + "</option>";
                        });
                        $(control).append(HTML);
                        $(control).val(bound);
                    }
                });
            },
            error: function (xhr, status, error)
            {
                $(loader).fadeOut(500, function () {
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                });
            }
        });
    });

}
function loadParamComboboxAjax(MethodName, controls, param,loader)
{
    $(loader).stop(true).hide().fadeIn(500, function () {
        var parameter = param.split(":");
        $.ajax(
        {
            type: "POST",
            contentType: "application/json; charset=utf-8",
            url: getServiceURL().concat(MethodName),
            data: "{" + parameter[0] + ":" + parameter[1] + "}",
            dataType: "json",
            success: function (data)
            {
                $(loader).fadeOut(500, function ()
                {
                    $(controls).each(function (i, value) {
                        clearCombobox(controls[i]);
                    });

                    if (data.d.length > 0) {
                        $(controls).each(function (i, value) {
                            var HTML = '<option value=0>Select Value</option>';
                            $.each(data.d, function (key, value) {
                                HTML += "<option value='" + value + "'>" + value + "</option>";
                            });
                            $(controls[i]).append(HTML);
                        });
                    }
                });
            },
            error: function (xhr, status, error)
            {
                $(loader).fadeOut(500, function ()
                {
                    var r = jQuery.parseJSON(xhr.responseText);
                    alert(r.Message);
                });
            }
        });
    });
}
function clearCombobox(control)
{
    $(control).empty();
}
function submitData(URL, JSONParam)
{
    $find('SaveExtender').show();

    $.ajax(
    {
        type: "POST",
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        data: JSON.stringify(JSONParam),
        url: URL,
        success: function (data)
        {
            $find('SaveExtender').hide();
            alert(data.d);
        },
        error: function (errorThrown)
        {
            $find('SaveExtender').hide();
            alert(errorThrown.responseText);
        }
    });
}
function getURL()
{
    return 'http://www.qmsrs.com/qmsrstools/'
}

function getServiceURL()
{
    return 'http://www.qmsrs.com/qmsrstools/DBService.asmx/';
}

function getDatePart(date)
{
    return date.split("/");
}

function showDialog(title, val)
{
    $("#dialog").children('p').each(function () {
        $(this).text(val);
    });

    $("#dialog").dialog(
    {
        width: 450,
        title: title,
        show: "slow",
        modal: true,
        height: 130,
        hide: "highlight",
        buttons:
        [{ text: "OK", click: function () { $(this).dialog("close"); } }]
    });
}

function addWaterMarkText(value,control)
{
    $(control).val(value).addClass('watermarktext');

    //if blur and no value inside, set watermark text and class again.
    $(control).blur(function ()
    {
        if ($(this).val().length == 0)
        {
            $(this).val(value).addClass('watermarktext');
        }
    });

    //if focus and text is watermrk, set it to empty and remove the watermark class
    $(control).focus(function ()
    {
        if ($(this).val() == value)
        {
            $(this).val('').removeClass('watermarktext');
        }
    });
}

function escapeHtml(string)
{

    var entityMap =
    {
        "&": "&amp;",
        "<": "&lt;",
        ">": "&gt;",
        '"': '&quot;',
        "'": '&#39;',
        "\\": '&#92;'
    };

    return String(string).replace(/[&<>"'\\]/g, function (s)
    {
        return entityMap[s];
    });
}

