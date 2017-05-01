
$(document).on('turbolinks:load', function() {
  $('.ui-group input').blur(function() {
    $(this).closest('.ui-group').removeClass('focus');
  }).focus(function() {
    $(this).closest('.ui-group').addClass('focus');
  });

  $('.ui-group-edit').on('click', function(){
    $(this).parent().find('input').focus();
  })

  // MASKED PLUGIN
  $('.js-mask-phone').mask('+000 00000000');
  $('.js-mask-date').mask('00.00.0000');

  // textarea autogrow
  $("textarea").keyup(function(e) {
    while($(this).outerHeight() < this.scrollHeight + parseFloat($(this).css("borderTopWidth")) + parseFloat($(this).css("borderBottomWidth"))) {
        $(this).height($(this).height()+1);
    };
  });

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

  // Magnific popup
  $('.popup-with-zoom-anim').magnificPopup({
		type: 'inline',
		fixedContentPos: false,
		fixedBgPos: true,
		overflowY: 'auto',
		closeBtnInside: true,
		preloader: false,
		midClick: true,
		removalDelay: 300,
		mainClass: 'my-mfp-zoom-in'
	});

  $('#socialModalImage').hide();

  function is_valid_url(url) {
    return /^(http(s)?:\/\/)?(www\.)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$/.test(url);
  }

  // LOGIC
  $('#socialModal select').on('change', function(){
    // show image uploader if selected custom
    if ( $(this).val() == 'custom' ){
      $('#socialModalImage').fadeIn();
    } else{
      $('#socialModalImage').fadeOut();
    }

  });

  fieldNum = 0;
  // click handler
  $('#socialModal .btn').on('click', function(e){
    var link = $(this).closest('#socialModal').find('#socialModalLink input');
    var icon = $('#socialModal select').val();

    if ( !is_valid_url(link.val()) ){
      console.log('form not valid');
      link.parent().find('.ui-group__validation').text('URL is not valid')
      return false;
    } else{
      link.parent().find('.ui-group__validation').text('');

      // paste to the form
      $('#socialModalPaste').append('<input type="hidden" name="shop[socials_attributes][' + fieldNum + '][link]" value="' + link.val() + '" id="shop_socials_attributes_' + fieldNum + '_link">');
      $('#socialModalPaste').append('<input type="hidden" name="shop[socials_attributes][' + fieldNum + '][icon]" value="' + icon + '" id="shop_socials_attributes_' + fieldNum + '_icon">');

      $('.shop__socials').append('<div class="shop__social removable"><i class="ico ico-remove" data-number='+fieldNum+'></i><a href="'+ link.val() +'"><i class="ico ico-social ico-social-'+ icon +'"></i></a></div>');

      // close modal
      $.magnificPopup.close();
      link.val('');

      fieldNum++
    }

    e.preventDefault();
  });

  $('.shop__socials').on('click', '.shop__social.removable .ico-remove', function(){
    var numId = $(this).data('number');
    $(this).parent().fadeOut().remove();
    $('#shop_socials_attributes_' + numId + '_link').remove();
    $('#shop_socials_attributes_' + numId + '_icon').remove();
  });

  // PAYMENTS
  fieldNumP = 0;
  // click handler
  $('#paymentModal .btn').on('click', function(e){

    var icon = $('#paymentModal select').val();
    // paste to the form
    $('#paymentModalPaste').append('<input type="hidden" name="shop[payments_attributes][' + fieldNumP + '][icon]" value="' + icon + '" id="shop_payments_attributes_' + fieldNumP + '_icon">');

    $('.shop__payments').append('<div class="shop__payment removable"><i class="ico ico-remove" data-number='+fieldNumP+'></i><i class="ico ico-payment ico-payment-'+ icon +'"></i></div>');

    // close modal
    $.magnificPopup.close();

    fieldNumP++

    e.preventDefault();
  });

  $('.shop__payments').on('click', '.shop__payment.removable .ico-remove', function(){
    var numId = $(this).data('number');
    $(this).parent().fadeOut().remove();
    $('#shop_payments_attributes_' + numId + '_icon').remove();
  });


  // SHOP PRODUCT SORTING
  var productQ = getQueryVariable('filter');

  $('.shop__sorting__filter').on('click', function(){
    var filter = $(this).data('filter');

    if(productQ) {
      // if filter present - replace query
      loc = location.href.replace("filter=" + productQ, "filter=" + filter);
    } else{
      // else just add filter
      loc += "?filter="+ filter +"";
    }
    location.href = loc;

  });

  // SET ACTIVE CLASS
  if (productQ){
    $('.shop__sorting__filter').each(function(i, val){

      if ($(val).data('filter') == filterQ){
        $(val).siblings().removeClass('active');
        $(val).addClass('active');
      }

    });
  }

  // REGISTRATIONS CONTROLLER
  $('.validate-agree').parent().on('submit', function(e){
    if ( $(this).find('#agreed').is(':checked') ){
      $(this).find('#agreed').parent().parent().removeClass('has-error');
    } else {
      $(this).find('#agreed').parent().parent().addClass('has-error');
      e.preventDefault();
      return false;
    }
  });

  // PSEUDO LINK
  $('.shop__listing').on('click', function(){
    if ( $(this).data('link') ){
      window.location.href = $(this).data('link');
    }
  });

  $('.shop__listing .btn').on('click', function(e){
    e.stopPropagation();

  });

});
