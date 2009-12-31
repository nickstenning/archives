$.metadata.setType('attr','data');

$(document).ready(function() {
    $('.autocomplete').livequery(function () {
        var md = $(this).metadata();
        $(this).autocomplete(md.url, {
            formatItem: function (item) {
                return $.evalJSON(item).name;
            }
        }).result(function (e, i) {
            i = $.evalJSON(i);
            $(e.target).val('');
            $(this).parent().before(
                '<input type="hidden" name="item[' + md.objtype + '][]" value="' + i.id + '">' +
                '<dd>' + i.name + '</dd>'
            );
        });
    });

    $('.edit_item .taglist li a').livequery('click', function () {
        var hf = $(this).next('input');
        $(hf.form).find('#item_attachments')
                  .append('<option value="' + hf.attr('value') + '">' + $(this).parent().text() + '</option>');
        hf.parent().remove();

        return false;
    });
    
    $('.actions li a').livequery(function () {
        if ($(this).attr('href') === window.location.pathname) {
            $(this).addClass('active');
        }
    });
});
