function changeButton() {
  $('.button').click(function(){
    var url = window.location.href;
    var buttonId = $(this).data('button-id');
    setTimeout(function(){
      $('#change-favorites-' + buttonId).load(url + ' #change-favorites-' + buttonId);
    }, 25);
  });
}

function clickThings() {
  var url = window.location.href
  $('#search').click(function(){
    $('#search').load(url + ' #button-762cb48b24d77730832dd762cf68478e')
  });
}

$( document ).ready(function() {
  changeButton();
});
