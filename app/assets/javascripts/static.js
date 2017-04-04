
$(document).on('turbolinks:load', function() {
  $('.ui-group input').blur(function() {
    $(this).closest('.ui-group').removeClass('focus');
  }).focus(function() {
    $(this).closest('.ui-group').addClass('focus');
  });


});
