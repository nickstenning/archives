$.metadata.setType('attr','data');

$(document).ready(function() {
    // All non-GET requests will add the authenticity token
    // if not already present in the data packet
    $("body").bind("ajaxSend", function(elm, xhr, s) {
      if (s.type == "GET") return;
      if (s.data && s.data.match(new RegExp("\\b" + window._auth_token_name + "="))) return;
      if (s.data) {
        s.data = s.data + "&";
      } else {
        s.data = "";
        // if there was no data, jQuery didn't set the content-type
        xhr.setRequestHeader("Content-Type", s.contentType);
      }
      s.data = s.data + encodeURIComponent(window._auth_token_name)
                      + "=" + encodeURIComponent(window._auth_token);
    });
    
    jQuery.ajaxSetup({
      'beforeSend': function(xhr) {xhr.setRequestHeader("Accept", "text/javascript")},
    });
    
    // All A tags with class 'get', 'post', 'put' or 'delete' will perform an ajax call
    $('a.get').livequery('click', function() {
      $.get($(this).attr('href'));
      return false;
    }).attr("rel", "nofollow");

    ['post', 'put', 'delete'].forEach(function(method) {
      $('a.' + method).livequery('click', function() {
        if ($(this).metadata().confirm &&
            !confirm($(this).metadata().confirm)) return false;
        $.post($(this).attr('href'), "_method=" + method);
        return false;
      }).attr("rel", "nofollow");
    });
    
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
});
