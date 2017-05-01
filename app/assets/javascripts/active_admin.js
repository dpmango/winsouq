//= require active_admin/base
//= require tinymce

$(document).on('turbolinks:load', function() {
  tinyMCE.init({
     selector: 'textarea.tinyMCE',
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


$(document).ready(function(){
  tinyMCE.init({
     selector: '#active_admin_content textarea',
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
