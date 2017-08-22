function hideFlash() {
  $( '.flash-message' ).css('display', 'none');
}

function showFlash() {
  var flashData = $( '.flash-message').attr('data-flash-type');
  if (flashData != '') {
    // Show flash message
    $( '.flash-message' ).css('display', 'block').addClass('animated fadeInRight');
    setTimeout(function(){
    // Hide flash message
      $( '.flash-message' ).addClass( 'animated fadeOutRight' );
    }, 3500);

  }
}
$(function(){
  hideFlash();
  showFlash();
});
