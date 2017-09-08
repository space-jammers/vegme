function changeButton() {
  $('.favOrNot').click(function(e){
    e.preventDefault();
    document.location.href = $(this).attr('href');
    var url = window.location.href;
    var buttonId = $(this).data('button-id');
    setTimeout(function(){
      $('#change-favorites-' + buttonId).load(url + ' #change-favorites-' + buttonId);
      $('#change-favorites-' + buttonId).addClass('animated pulse');
    }, 500);
  });
}

function hideForm(){
    var hidden = $('#get-form').hasClass('hidden-btn');
    if( hidden){
      $('.form-container').css('display', 'none');
      $('#get-form').addClass('animated slideInLeft');
    }else{
      $('.form-container').css('display', 'block');
    }
}

function showForm(){
 $('#get-form').click(function(e){
   $('.form-container').show('animated slideInLeft');
   $('#get-form').addClass('animated zoomOutLeft');
 });
}


function dislikeDisappear(){
  $('.dislike').click(function(){
    $(this).parents('.callout').fadeTo( "1000" , 0.5, function() {
      // Animation complete.
    });
  });
}

function footerDropDown(){
  $('.pointer').on('click', function(e){
    var dataIndex = $(this).data('index');
    if ($(".callout-footer[data-index="+dataIndex+"]").css('display') === 'none') {
      $(".callout-footer[data-index="+dataIndex+"]").slideDown();
    }else{
      $(".callout-footer[data-index="+dataIndex+"]").slideUp();
    }
  });
}

function minusPlus(){
  $('[data-quantity="plus"]').click(function(e){
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        fieldName = $(this).attr('data-field');
        // Get its current value
        var currentVal = parseInt($('input[name='+fieldName+']').val());
        // If is not undefined
        if (!isNaN(currentVal)) {
            // Increment
            $('input[name='+fieldName+']').val(currentVal + 10);
        } else {
            // Otherwise put a 0 there
            $('input[name='+fieldName+']').val(0);
        }
    });
    // This button will decrement the value till 0
    $('[data-quantity="minus"]').click(function(e) {
        // Stop acting like a button
        e.preventDefault();
        // Get the field name
        fieldName = $(this).attr('data-field');
        // Get its current value
        var currentVal = parseInt($('input[name='+fieldName+']').val());
        // If it isn't undefined or its greater than 0
        if (!isNaN(currentVal) && currentVal > 0) {
            // Decrement one
            $('input[name='+fieldName+']').val(currentVal - 10);
        } else {
            // Otherwise put a 0 there
            $('input[name='+fieldName+']').val(0);
        }
    });
}


$(function(){
  $.ajaxSetup({ cache: false });
  dislikeDisappear();
  changeButton();
  footerDropDown();
  minusPlus();
  hideForm();
  showForm();
});
