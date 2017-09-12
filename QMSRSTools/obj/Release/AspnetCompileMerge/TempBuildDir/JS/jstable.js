//plugin adding, removing, and editing records in client-side table
/*Note: this plugin must add a constraint to not allow duplication*/

(function ($)
{
    var TableView = function($el, options) 
    {
        this.options = $.extend({}, this.settings, options);
        this.control = $el;
        this.selectedRow = -1;

       
        if (this.json != null)
            this.json = null;

        this.json = options.JSON;
        this.tree = options.Tree;


        this.settings =
        {
            JSON: null,
            Attributes: null,
            Settings: null,
            Width: 20
        };
        
        this.load = function ()
        {
            var $obj = this;

            this.clear();

            if (this.json.length > 0)
            {
                $(this.json).each(function (index, value)
                {
                    $obj.appendRow(index, value, $obj);
                });
            }

        };
        
        this.clear = function ()
        {
            var $obj = this;
            $(this.control).children().not(':first').each(function ()
            {
                $(this).remove();
            });

            $(this.control).css('display', 'none');
        };

        this.removeRowAt = function (attr, data, nodes) {

            //remove row by specifying the attribute name, and its value

            var $obj = this;
            $(this.control).find('.tr').children('.tdl').each(function (index, value) {
                if ($(this).attr("id").search(attr) != -1) {
                    if ($(this).html() == data) {
                        var row = $(this).parent();
                        $obj.removeRow(row);
                    }
                }
            });
        };

        this.removeRow = function (row)
        {
            var index = this.getJSONIndex(this.json, row);

            var jsonObject = this.json[index];

            if (jsonObject.Status == 3)
            {
                //remove .tr from the table
                row.remove();

                //remove the related json object from json list

                this.removeJSONAt(index);
                this.sortRows();

            }
            else
            {
                var result = confirm('Are you sure you would like to remove the selected record?')
                if (result == true) {
                    jsonObject.Status = 4;
                    row.hide('1000');
                }
            }

            if ($(this.control).children().not(':first').length == 0) {
                $(this.control).hide("1000");
            }
        };

        this.sortRows = function () {
            $(this.control).children().not(':first').each(function (i, value) {
                $(this).attr('id', i);
            });
        };

        this.getJSONIndex = function (JSON, curr) {
            var $obj = this;
            var index = -1;

            $.each(this.json, function (j, obj) {
                if (parseInt(curr.attr('id')) == j) {
                    index = j;
                }
            });

            return index;
        };

        this.removeJSONAt = function (index) {
            var $obj = this;

            $.each($obj.json, function (i, value) {
                if (i == index)
                {
                    $json = value;
                    $obj.json.splice(i, 1);
                }
            });


        };

        this.addRow = function (obj) {
            var result = true;

            var length = this.json.length;

            this.json.push(obj);
            this.appendRow(length, this.json[length], this);

            return result;
        };

        this.getKeyCount = function (obj) {
            //return total keys in JSON Object
            var keys = 0;
            for (var key in obj) {
                if (obj.hasOwnProperty(key)) {
                    keys++;
                }
            }
            return keys;
        };

        this.appendRow = function (index, value, obj) {
            var $obj = this;

            var sb = new StringBuilder();

            sb.append("<div id='" + index + "' class='tr'>");
            sb.append("<div class='tdh' style='width:50px'>");
            sb.append("<img id='delete_" + index + "' src='../Images/cancel.png' alt='' class='row_img'/>");
            sb.append("</div>");

            for (var i = 0; i < $obj.options.Attributes.length; i++)
            {
                for (var key in value)
                {
                    if (key == $obj.options.Attributes[i])
                    {
                        sb.append("<div id='" + key + "_" + index + "' class='tdl' style='width:" + $obj.options.Width + "%'>" + value[key] + "</div>");
                    }
                }
            }

            sb.append("</div>");

            $(this.control).append(sb.toString());

            var row = $(this.control).find('.tr').last();

            $(row).find("img").bind('click', function () {
                $obj.removeRow(row);
            });

            //bind each cell to its corresponding control
            $(row).children(".tdl").each(function (column, value) {
                $(this).cell($obj.control, index, $obj.json, $(value).attr('id').substring(0, $(value).attr('id').lastIndexOf("_")), $.parseJSON($obj.options.Settings[column]));
            });

            if ($(this.control).css('display') == 'none') {
                $(this.control).css('display', 'block');
            }

        };
        this.setJSON = function (obj) {
            this.json = obj;
        };

        this.getJSON = function () {
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

    $.fn.table = function (options)
    {
        var method = (typeof options === 'string') ? options : undefined;

        if (method)
        {
            var customPlugins = [];

            function getCustomPlugin() {
                var $el = $(this);
                var table = $el.data('table');

                customPlugins.push(table);
            }

            this.each(getCustomPlugin);

            var args = (arguments.length > 1) ? Array.prototype.slice.call(arguments, 1) : undefined;
            var results = [];

            function applyMethod(index)
            {
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
        else if (typeof options == 'object' || !options)
        {
            function init()
            {
                var $el = $(this);
                var table = new TableView($el, options);

                $el.data('table', table);
            }
            return this.each(init);
        }
    };
  
})(jQuery);
