//= require active_admin/base
//= require tinymce

$(document).on('turbolinks:load', function() {
  tinyMCE.init({
     mode: 'textareas',
     theme: 'modern'
   });
});
