// function moveBody() {
//   var checked = $('#nav-trigger').prop('checked');
//   if ( checked == true ) {
//     $('#bodyId').addClass('move-body');
//   } else {
//     $('#bodyId').removeClass('move-body');
//   }
// }
//
function checkSize () {
  $('#nav-trigger').click(function() {
    if ($(window).width() <= 730) {
      darkenContent();
    }
  });
}


function darkenContent() {
  var checked = $('#nav-trigger').prop('checked');
  if ( checked === true ) {
    $('.site-cover').css('background-color', 'rgba(0, 0, 0, 0.5)');
  } else {
    $('.site-cover').css('background-color', 'rgba(0, 0, 0, 0)');
  }
}

$(function(){
  checkSize();
});
