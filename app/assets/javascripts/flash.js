function showFlash() {
  var flashData = $( '.flash-message').attr('data-flash-type');
  if (flashData != '') {
    $( '.flash-message' ).css('display', 'block').addClass('animated fadeInRight');
    setTimeout(function(){
      $( '.flash-message' ).addClass( 'animated fadeOutRight' );
    }, 3500);

  }
}

function closeFlash() {
  $( '.close-button').click(function(){
    $( '.flash-message' ).addClass( 'animated fadeOutRight' );
  });
}

$(function(){
  closeFlash();
  showFlash();
});
