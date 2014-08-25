// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require interact.min

$(document).on('ready', function(){
  interact('#sidebar', '#requests', '#docs').resizeable(true).on('resizemove', function (event) {
    var target = event.target;
    var newWidth  = parseFloat($(target).width()) + event.dx;
    $(target).width(newWidth + 'px');
    //I have to add 40 so that the request div doesn't go behind the sidebar div
    $('#requests').css('margin-left', (newWidth + 40) + 'px');
  });
});

$(document).on('click', 'a[data-request-uid]', function(e) {
  $('#requests .highlight').removeClass('highlight');
  $(e.target.parentNode).addClass('highlight');
  var uid = $(this).data('request-uid');
  $('.request').hide(0, function() {
    $('.request[data-uid="' + uid + '"]').show();
  });
});
