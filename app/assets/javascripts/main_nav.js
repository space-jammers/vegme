function moveBody() {
  var checked = $('#nav-trigger').prop('checked');
  if ( checked == true ) {
    $('#bodyId').addClass('move-body');
  } else {
    $('#bodyId').removeClass('move-body');
  }
}

function checkSize () {
  $('#nav-trigger').click(function() {
    if ($(window).width() <= 730) {
      moveBody();
    }
  });
}

$(function(){
  checkSize();
});
