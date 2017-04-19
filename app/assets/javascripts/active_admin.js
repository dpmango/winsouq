//= require active_admin/base
//= require tinymce

$(document).on('turbolinks:load', function() {
  tinyMCE.init({
     mode: 'textareas',
     theme: 'modern',
     menubar: false,
     plugins: [
      'advlist autolink lists link image charmap',
      'contextmenu directionality',
      'emoticons textcolor colorpicker textpattern'
     ],
      toolbar: 'undo redo | insert | bold underline italic | alignleft aligncenter alignright alignjustify | bullist numlist outdent indent | link'
   });
});
