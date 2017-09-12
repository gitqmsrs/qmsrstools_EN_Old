//plugin adding, removing, and editing records in client-side table
/*Note: this plugin must add a constraint to not allow duplication*/

(function ($) {
    var Matrix= function($el, options) 
    {
        this.options = $.extend({}, this.settings, options);
        this.control = $el;
        this.selectedRow = -1;

        if (this.json != null)
            this.json = null;

        this.json = options.JSON; 

        this.settings =
        {
            JSON: null,
            Attributes: null,
            Settings: null,

            Width: 20
        };

      
        this.load= function ()
        {
            var $obj = this;

            this.clear();

            if (this.json.length > 0)
            {
                $(this.json).each(function (index, value)
                {
                    /*let Y indicates a column, and X indicates a row*/
                    /*check if the row number already exists*/

                 
                    if ($obj.findRowNumber("row_" + parseInt(value["X"])) == false)
                    {
                        var newrow = "<tr id='row_" + parseInt(value["X"]) + "' class='tr'>";

                        /*indication for row header*/
                        if (parseInt(value["Y"]) == 0 || parseInt(value["X"]) == 0) {
                            newrow += "<td id='" + parseInt(value["X"]) + "_" + parseInt(value["Y"]) + "' class='tdh'>" + value["Value"] + "</td>";
                        }
                        else {
                            newrow += "<td id='" + parseInt(value["X"]) + "_" + parseInt(value["Y"]) + "' class='tdl'>" + value["Value"] + "</td>";
                        }

                        newrow += "</tr>";

                        $($obj.control).append(newrow);
                    }
                    else
                    {
                        var currentrow = $('tr', $($obj.control)).eq($obj.getRowNumber("row_" + parseInt(value["X"])));

                        if (currentrow != null)
                        {
                            var column = null;
                            /*indication for column header, or the remainings of the first row*/
                            if (parseInt(value["Y"]) == 0 || parseInt(value["X"]) == 0) {
                                column = "<td id='" + parseInt(value["X"]) + "_" + parseInt(value["Y"]) + "' class='tdh'>" + value["Value"] + "</td>";
                            }
                            else {
                                column = "<td id='" + parseInt(value["X"]) + "_" + parseInt(value["Y"]) + "' class='tdl'>" + value["Value"] + "</td>";
                            }

                            $(currentrow).append(column);

                            if (parseInt(value["X"]) > 0)
                            {
                                var lastcolumn = $(currentrow).find('.tdl').last();

                                $(lastcolumn).matrixcell($obj.control, $obj.json, $(column).attr('id'), {});
                            }
                        }
                    }
                });
            }

        };

        this.clear= function ()
        {
            var $obj = this;
            $(this.control).children().each(function ()
            {
                $(this).remove();
            });
        };

        this.findRowNumber=function(rowID)
        {
            var found = false;
            $(".tr").each(function (index, row)
            {
                if ($(this).attr('id') == rowID)
                {
                    found = true;
                }
            });

            return found;
        };

        this.getRowNumber=function(rowID)
        {
            var rowindex = -1;

            $(".tr").each(function (index, row)
            {
                if ($(this).attr('id') == rowID)
                {
                    rowindex = index;
                }
            });

            return rowindex;
        };

        this.getJSONIndex= function (JSON, curr)
        {
            var $obj = this;
            var index = -1;

            $.each(this.json, function (j, obj) {
                if (parseInt(curr.attr('id')) == j) {
                    index = j;
                }
            });

            return index;
        };

        this.setJSON= function (obj)
        {
            this.json = obj;
        };

        this.getJSON= function ()
        {
            return this.json;
        };

        this.clearTextbox = function () {
            //clear textboxes
            $(".textbox").each(function () {
                $(this).val("");
            });
        };

        this.load();
    };
    $.fn.matrixtable = function (options)
    {
        var method = (typeof options === 'string') ? options : undefined;

        if (method) {
            var customPlugins = [];

            function getCustomPlugin() {
                var $el = $(this);
                var matrix = $el.data('matrixtable');

                customPlugins.push(matrix);
            }

            this.each(getCustomPlugin);

            var args = (arguments.length > 1) ? Array.prototype.slice.call(arguments, 1) : undefined;
            var results = [];

            function applyMethod(index) {
                var customPlugin = customPlugins[index];

                if (!customPlugin) {
                    console.warn('$.customPlugin not instantiated yet');
                    console.info(this);
                    results.push(undefined);
                    return;
                }

                if (typeof customPlugin[method] === 'function') {
                    var result = customPlugin[method].apply(customPlugin, args);
                    results.push(result);
                } else {
                    console.warn('Method \'' + method + '\' not defined in $.customPlugin');
                }
            }

            this.each(applyMethod);

            return (results.length > 1) ? results : results[0];
        }
        else if (typeof options == 'object' || !options) {
            function init()
            {
                var $el = $(this);
                var matrix = new Matrix($el, options);

                $el.data('matrixtable', matrix);
            }
            return this.each(init);
        }
    };

})(jQuery);
