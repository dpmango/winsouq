
$(document).on('turbolinks:load', function() {
  $('.ui-group input').blur(function() {
    $(this).closest('.ui-group').removeClass('focus');
  }).focus(function() {
    $(this).closest('.ui-group').addClass('focus');
  });

  $('.ui-group-edit').on('click', function(){
    $(this).parent().find('input').focus();
  })

  // hamburger
  $('.hamburger').on('click', function(){
    $(this).toggleClass('is-active');
    $('.mobile-nav').toggleClass('is-active');
  });
});
