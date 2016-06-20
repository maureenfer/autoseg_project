// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require bootstrap-sprockets
//= require jquery_ujs
//= require jquery-ui
//= require turbolinks
//= require_tree .

jQuery(document).ready(function() {
  setTimeout(function() {
    var source = new EventSource('/list_stream');
    source.addEventListener('results', function(e) {
      $("#lists").append("<li>List '"+ JSON.parse(e.data).name +"' was updated.</li>");
      $(".alert-warning").removeClass('hide');
    });
  }, 1);
});
