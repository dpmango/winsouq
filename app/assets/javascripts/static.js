
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

  $('.shop__product.shop__product--hidden').hide();
  // SHOP ADD PRODUCT
  $('.shop__products__new').on('click', function(){
    $(this).fadeOut();
    $('.shop__product.shop__product--hidden').fadeIn();
  });

  // SHOPS SORTING
  function getQueryVariable(variable) {
  	 var query = window.location.search.substring(1);
     var vars = query.split('&');
     for (var i=0; i<vars.length; i++) {
          var pair = vars[i].split('=');
          if (pair[0] == variable) {
            return pair[1];
          }
     }

     return false;
  }

  var loc = window.location.href;
  var searchQ = getQueryVariable('q');
  var filterQ = getQueryVariable('filter');

  $('.shop__sortby__filter').on('click', function(){
    var filter = $(this).data('filter');

    if (searchQ && !filterQ){
      // if search query present and no filter - add filter
      loc += "&filter="+ filter +"";
    } else if(filterQ) {
      // if filter present - replace query
      loc = location.href.replace("filter=" + filterQ, "filter=" + filter);
    } else{
      // else just add filter
      loc += "?filter="+ filter +"";
    }
    location.href = loc;

  });

  // SET ACTIVE CLASS
  if (filterQ){
    $('.shop__sortby__filter').each(function(i, val){

      if ($(val).data('filter') == filterQ){
        $(val).siblings().removeClass('active');
        $(val).addClass('active');
      }

    });
  }

  // FAVORITE LINKS
  $('.shop__product-box').on('click', function(){
    if ( $(this).data('link') ){

      window.location.href = '/shops/' + $(this).data('link')
    }

  });

});
