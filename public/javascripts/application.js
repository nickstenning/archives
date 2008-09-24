$.fn.wait = function(time, type) {
    time = time || 1000;
    type = type || "fx";
    return this.queue(type, function() {
        var self = this;
        setTimeout(function() {
            $(self).dequeue();
        }, time);
    });
};

$.datepicker.setDefaults({
    dateFormat: 'yy-mm-dd',
    minDate: new Date(1855, 0, 1), // Unlikely to have theatre archive material from before we were founded.
    maxDate: '', // i.e. Today. Again, we're unlikely to have archive material from the future.
    yearRange: '1855:9999'
});

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
    
    
    // Fade out flash notifications after a brief period.
    $('#flashholder > p').wait(5000).hide('drop', { direction: "up" }, 3000);
    
    // Set up jQuery UI tabs.
    $('ul.tabbed').livequery(function () {
        $(this).tabs();
    }, function () {
        $(this).tabs("destroy");
    });
    
    
    // Set up jQuery datepicker on all elements with class 'datepicker'.
    $('.datepicker').livequery(function () {
        $(this).datepicker();
    }, function () {
        $(this).datepicker("destroy");
    });
    
    $('dd.datedetail a').livequery('click', function () {
        $(this).hide();
        $(this).next().show();
        $.jGrowl("Select a day in the right month or year, and then select how specific you can be.");
    });
    
    $('.autocomplete').livequery(function () {
        var md = $(this).metadata();
        $(this).autocomplete(md.url).result(function (e, i) {
            $(e.target).val('');
            $(this).parent().before('<dd>'+i+'</dd>');
        });
    });
    
});
