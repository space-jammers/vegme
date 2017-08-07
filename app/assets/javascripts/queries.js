function changeButton() {
  $('.favOrNot').click(function(){
    $(this).addClass('animated pulse');
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
      $('.form-container').addClass('slideOutLeft');
      $('#get-form').addClass('floating-btn animated slideInLeft');
    }
 }).fail(function() {
      $('.form-container').slideDown();
  });

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
    // $(this).parents('.callout').addClass('animated fadeOut');
    // $('animated fadeOutLeft').remove();
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
  console.log($().jquery);
});
