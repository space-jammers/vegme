function changeButton() {
  $('.fav').click(function(){
    var url = window.location.href;
    var buttonId = $(this).data('button-id');
    setTimeout(function(){
      $('#change-favorites-' + buttonId).load(url + ' #change-favorites-' + buttonId);
    }, 25);
  });
}

function hideForm(){
  $.getJSON( "/queries", function( data) {
    var hidden = $('#get-form').hasClass('hidden-btn');
    if(data[0].recipe && hidden){
      $('.form-container').slideUp(1);
      $('#get-form').removeClass('hidden-btn');
      $('#get-form').addClass('floating-button');
    }
 }).fail(function() {
    $('.form-container').slideDown(1);
  });
}

function showForm(){
 $('#get-form').click(function(){
   $('.form-container').slideDown(250);
   $('#get-form').removeClass('floating-button');
   $('#get-form').addClass('hidden-btn');
 });
}


function dislikeDisappear(){
  $('.dislike').click(function(){
    $(this).parents('.callout').remove();
  });
}

function callOutHover(){
$('[data-callout-hover-reveal]').click(function(){
    if ($(this).find('.callout-footer').css('display') === 'none'){
      $(this).find('.callout-footer').slideDown(250);
    }else{
      $(this).find('.callout-footer').slideUp(250);
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

$(document).on('turbolinks:load', function() {
  dislikeDisappear();
  changeButton();
  callOutHover();
  minusPlus();
  hideForm();
  showForm();
});
