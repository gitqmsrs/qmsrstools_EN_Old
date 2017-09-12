/*This code is a plugin written in JQUERY language in order to enable editing cells on user click.
 * The code has been reviwed and customized by IHAB JAMIL ALI NEMER, product manager at QMSrs.
 * The customization is under the QMSrs Copyright (c) 2013
 * The developer has the right to retain the acknowledgement considering the optimizion effort in this plugin
 * The original idea, and license are shown below:


 * Jeditable - jQuery in place edit plugin
 *
 * Copyright (c) 2006-2008 Mika Tuupola, Dylan Verheul
 *
 * Licensed under the MIT license:
    *   http://www.opensource.org/licenses/mit-license.php
 *
 * Project home:
    *   http://www.appelsiini.net/projects/jeditable
 *
 * Based on editable by Dylan Verheul <dylan_at_dyve.net>:
 *    http://www.dyve.net/jquery/?editable
 *
 */


(function ($)
{
    $.fn.cell = function (table,row,json,columnname,options)
    {
        /*default settings for each cell*/
        var settings =
        {
            name: 'value',
            type: 'textbox',
            width: 'auto',
            height: 'auto',
            event: 'click',
            loadurl: null,
            loadData: null,
            onblur: 'submit',
            select: true,
            placeholder: 'Click to edit',
            readonly:false
        };

        if (options)
        {
            $.extend(settings, options);
        }

        /* setup some functions */
        var plugin = $.controls.types[settings.type].plugin || function () { };
        var submit = $.controls.types[settings.type].submit || function () { };
        var buttons = $.controls.types[settings.type].buttons
                    || $.controls.types['defaults'].buttons;
        var content = $.controls.types[settings.type].content
                    || $.controls.types['defaults'].content;
        var element = $.controls.types[settings.type].element
                    || $.controls.types['defaults'].element;
        var reset = $.controls.types[settings.type].reset
                    || $.controls.types['defaults'].reset;
        var callback = settings.callback || function () { };
        var onsubmit = settings.onsubmit || function () { };
        var onreset = settings.onreset || function () { };
        var onerror = settings.onerror || reset;

        /* add custom event if it does not exist */
        if (!$.isFunction($(this)[settings.event]))
        {
            $.fn[settings.event] = function (fn)
            {
                return fn ? this.bind(settings.event, fn) : this.trigger(settings.event);
            }
        }

        /*set width and height to default */

        settings.autowidth = 'auto' == settings.width;
        settings.autoheight = 'auto' == settings.height;


        return this.each(function ()
        {

            var cell = this;

            /* invoke the event on user action */

            $(this)[settings.event](function (e)
            {
                //if the cell is not read only
                if (!settings.readonly)
                {
                    /* prevent throwing an exeption if edit field is clicked again */
                    if (cell.editing) {
                        return;
                    }

                    /* figure out how wide and tall we are, saved width and height */
                    /* are workaround for http://dev.jquery.com/ticket/2190 */
                    if (0 == $(cell).width()) {
                        //$(cell).css('visibility', 'hidden');
                        settings.width = savedwidth;
                        settings.height = savedheight;
                    }
                    else {
                        if (settings.width != 'none') {
                            settings.width =
                                settings.autowidth ? $(cell).width() : settings.width;
                        }
                        if (settings.height != 'none') {
                            settings.height =
                                settings.autoheight ? $(cell).height() : settings.height;
                        }
                    }

                    //default settings
                    cell.editing = true;
                    cell.defaultvalue = $(cell).html();

                    /* create the form object */
                    var form = $('<form />');

                    /* apply css or style or both */
                    if (settings.cssclass) {
                        if ('inherit' == settings.cssclass) {
                            form.attr('class', $(cell).attr('class'));
                        }
                        else {
                            form.attr('class', settings.cssclass);
                        }
                    }

                    if (settings.style) {
                        if ('inherit' == settings.style) {
                            form.attr('style', $(cell).attr('style'));
                            /* IE needs the second line or display wont be inherited */
                            form.css('display', $(cell).css('display'));
                        } else {
                            form.attr('style', settings.style);
                        }
                    }

                    /* add main input element to form and store it in input */
                    var input = element.apply(form, [settings, cell]);


                    /* if the web service method is set to load data, this is only applicable from comboboxes */
                    if (settings.loadurl) {
                        /* if the web service method is parameterized */

                        if (settings.loadData)
                        {
                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                data: settings.loadData,
                                url: settings.loadurl,
                                success: function (data) {
                                    if (data) {
                                        content.apply(form, [data.d, settings, cell]);

                                    }
                                }
                            });

                        }
                        else {
                            $.ajax(
                            {
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                url: settings.loadurl,
                                success: function (data) {
                                    if (data) {
                                        content.apply(form, [data.d, settings, cell]);
                                    }
                                }
                            });
                        }
                    }
                    else {
                        content.apply(form, [cell.defaultvalue, settings, cell]);
                    }

                   

                    /* add created form to the cell */
                    $(cell).append(form);

                    /* set the name of the input control */
                    input.attr('name', settings.name);


                    /* focus to first visible form element */
                    $(':input:visible:enabled:first', form).focus();

                    /* highlight input contents when requested */
                    if (settings.select) {
                        input.select();
                    }

                    /* discard changes if pressing esc */
                    input.keydown(function (e) {
                        if (e.keyCode == 27) {
                            e.preventDefault();
                            //cell.reset();
                            reset.apply(form, [settings, cell]);
                        }
                        else if (e.keyCode == 13)
                        {
                            if (settings.hasHandler) {
                                HandleEvent(e);
                            }
                        }
                    });

                    var t;
                    if ('submit' == settings.onblur) {
                        input.blur(function (e) {
                            /* prevent double submit if submit was clicked */
                            t = setTimeout(function ()
                            {
                                  form.submit();
                            }, 200);
                        });
                    }

                    form.submit(function (e)
                    {
                        if (t)
                        {
                            clearTimeout(t);
                        }

                        /* do no submit */
                        e.preventDefault();

                        /* call before submit hook. */
                        /* if it returns false abort submitting */
                        if (false !== onsubmit.apply(form, [settings, cell]))
                        {
                            /* custom inputs call before submit hook. */
                            /* if it returns false abort submitting */
                            if (false !== submit.apply(form, [settings, cell]))
                            {

                                $(cell).html(input.val());

                                cell.editing = false;
                                callback.apply(cell, [cell.innerHTML, settings]);

                                $.each(json, function (i, obj)
                                {
                                    if (i == row)
                                    {
                                        for (var key in obj)
                                        {
                                            if (key == columnname)
                                            {
                                                obj[key] = $(cell).html();
                                            }

                                            if (obj["Status"] != 3)
                                            {
                                                obj["Status"] = 2;
                                            }
                                        }
                                    }

                                });

                                /* TODO: this is not dry */
                                if (!$.trim($(cell).html()))
                                {
                                    $(cell).html(settings.placeholder);
                                }
                                

                                $(table).table('setJSON', json);

                            }
                        }

                        return false;
                    });
                }
                else
                {
                    alert("This is a readonly cell");
                }
            });

            /* privileged methods */
            this.reset = function (form)
            {
                /* prevent calling reset twice when blurring */
                if (this.editing) {
                    /* before reset hook, if it returns false abort reseting */
                    if (false !== onreset.apply(form, [settings, cell]))
                    {
                        $(cell).html(cell.defaultvalue);
                        cell.editing = false;

                        /* if the cell is empty */
                        if (!$.trim($(cell).html())) {
                            $(cell).html(settings.placeholder);
                        }
                    }
                }
            }
        });
    };

    $.controls =
    {
       types:
       {
           defaults:
           {
               element: function (settings, original)
               {
                   var input = $('<input type="hidden"></input>');
                   $(this).append(input);
                   return (input);
               },
               content: function (string, settings, original)
               {
                   $(':input:first', this).val(string);
               },
               reset: function (settings, original)
               {
                   original.reset(this);
               },
               buttons: function (settings, original)
               {
                   var form = this;
                   if (settings.submit) {
                       /* if given html string use that */
                       if (settings.submit.match(/>$/)) {
                           var submit = $(settings.submit).click(function () {
                               if (submit.attr("type") != "submit") {
                                   form.submit();
                               }
                           });
                           /* otherwise use button with given string as text */
                       } else {
                           var submit = $('<button type="submit" />');
                           submit.html(settings.submit);
                       }
                       $(this).append(submit);
                   }
                   if (settings.cancel) {
                       /* if given html string use that */
                       if (settings.cancel.match(/>$/)) {
                           var cancel = $(settings.cancel);
                           /* otherwise use button with given string as text */
                       } else {
                           var cancel = $('<button type="cancel" />');
                           cancel.html(settings.cancel);
                       }
                       $(this).append(cancel);

                       $(cancel).click(function (event) {
                           //original.reset();
                           if ($.isFunction($.editable.types[settings.type].reset)) {
                               var reset = $.editable.types[settings.type].reset;
                           } else {
                               var reset = $.editable.types['defaults'].reset;
                           }
                           reset.apply(form, [settings, original]);
                           return false;
                       });
                   }
               }
           },
           textbox:
           {
               element: function (settings, original)
               {
                   var input = $('<input />');
                   if (settings.width != 'none') { input.width(settings.width); }
                   if (settings.height != 'none') { input.height(settings.height); }

                   /* https://bugzilla.mozilla.org/show_bug.cgi?id=236791 */
                    //input[0].setAttribute('autocomplete','off');
                   input.attr('autocomplete', 'off');

                   $(this).append(input);
                   return (input);
               }
           },
           date:
           {
               element: function (settings, original) {
                   var input = $('<input />');
                   if (settings.width != 'none') { input.width(settings.width); }
                   if (settings.height != 'none') { input.height(settings.height); }

                   /* https://bugzilla.mozilla.org/show_bug.cgi?id=236791 */
                   //input[0].setAttribute('autocomplete','off');
                   input.attr('autocomplete', 'off');
                 
                   $(this).append(input);
                   $(input).datepicker(
                   {
                        inline: true,
                        dateFormat: "dd/mm/yy"
                   });
                   return (input);
               }
           },
           
           select:
           {
               element: function (settings, original)
               {
                   var select = $('<select />');
                   $(this).append(select);

                   return (select);
               },
               content: function (string, settings, original)
               {

                   var $combo = this;

                   $(string).each(function (key, value)
                   {
                       var option = $('<option />').val(value).append(value);
                       $('select', $combo).append(option);
                   });


                   /* Loop option again to set selected. IE needed this... */
                   $('select', this).children().each(function ()
                   {
                       if ($(this).text() == original.defaultvalue)
                       {
                           $(this).attr('selected', 'selected');
                       };
                   });
               }
           }
       }
    }
      
})(jQuery);
