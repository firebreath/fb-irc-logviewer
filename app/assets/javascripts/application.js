// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require_tree .

$(function() {
  // make table rows clickable
  $('tr').each(function(index) {
    if ($(this).find('td:first > a').attr('href') != undefined) {
      $(this).css('cursor', 'pointer');
      $(this).click( function() {
        window.location = $(this).find('a').attr('href');
      });
    }
  });

  if (document.location.hash) {
    $("a[name="+document.location.hash.substr(1)+"]").addClass("search_result");
  }

});
